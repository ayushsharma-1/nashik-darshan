package service

import (
	"context"
	"sort"
	"time"

	"github.com/omkar273/nashikdarshan/ent/visit"
	"github.com/omkar273/nashikdarshan/internal/api/dto"
	"github.com/omkar273/nashikdarshan/internal/domain/itinerary"
	"github.com/omkar273/nashikdarshan/internal/domain/place"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
)

// ItineraryService defines the interface for itinerary operations
type ItineraryService interface {
	// Core CRUD operations
	Create(ctx context.Context, userID string, req *dto.CreateItineraryRequest) (*dto.ItineraryResponse, error)
	Get(ctx context.Context, id string) (*dto.ItineraryResponse, error)
	GetWithVisits(ctx context.Context, id string) (*dto.ItineraryResponse, error)
	Update(ctx context.Context, id string, req *dto.UpdateItineraryRequest) (*dto.ItineraryResponse, error)
	Delete(ctx context.Context, id string) error

	// List operations
	List(ctx context.Context, filter *types.ItineraryFilter) (*dto.ListItinerariesResponse, error)
}

type itineraryService struct {
	ServiceParams
}

// NewItineraryService creates a new itinerary service
func NewItineraryService(params ServiceParams) ItineraryService {
	return &itineraryService{
		ServiceParams: params,
	}
}

// Create creates a new optimized itinerary
func (s *itineraryService) Create(ctx context.Context, userID string, req *dto.CreateItineraryRequest) (*dto.ItineraryResponse, error) {
	// Validate request
	if err := req.Validate(); err != nil {
		return nil, err
	}

	s.Logger.Debugw("Creating itinerary", "user_id", userID, "place_count", len(req.SelectedPlaces))

	// Fetch places from database
	places, err := s.fetchPlaces(ctx, req.SelectedPlaces)
	if err != nil {
		return nil, err
	}

	// Optimize route using routing client
	optimizedRoute, err := s.optimizeRoute(ctx, req, places)
	if err != nil {
		return nil, err
	}

	// Check feasibility
	if !optimizedRoute.Feasible {
		return nil, ierr.NewError("Cannot fit all places in the available time window").
			WithHint("Try reducing the number of places or extending the time window").
			WithReportableDetails(map[string]interface{}{
				"total_duration_minutes": optimizedRoute.TotalDurationMinutes,
				"total_visit_minutes":    optimizedRoute.TotalVisitTimeMinutes,
				"places_count":           len(places),
			}).
			Mark(ierr.ErrValidation)
	}

	// Create itinerary domain model
	itin := &itinerary.Itinerary{
		ID:                    types.GenerateUUIDWithPrefix(types.UUID_PREFIX_ITINERARY),
		UserID:                userID,
		Title:                 req.Title,
		Description:           req.Description,
		PlannedDate:           req.PlannedDate,
		StartLocation:         req.StartLocation,
		TransportMode:         req.TransportMode,
		TotalDistanceKm:       &optimizedRoute.TotalDistanceKm,
		TotalDurationMinutes:  &optimizedRoute.TotalDurationMinutes,
		TotalVisitTimeMinutes: &optimizedRoute.TotalVisitTimeMinutes,
		IsOptimized:           true,
		BaseModel: types.BaseModel{
			Status:    types.StatusPublished,
			CreatedAt: time.Now(),
			UpdatedAt: time.Now(),
			CreatedBy: userID,
			UpdatedBy: userID,
		},
		Visits: optimizedRoute.Visits,
	}

	// Save to database
	err = s.ItineraryRepo.Create(ctx, itin)
	if err != nil {
		s.Logger.Errorw("Failed to create itinerary", "error", err, "user_id", userID)
		return nil, ierr.WithError(err).
			WithHint("Failed to save itinerary").
			Mark(ierr.ErrDatabase)
	}

	s.Logger.Infow("Itinerary created successfully",
		"itinerary_id", itin.ID,
		"user_id", userID,
		"total_distance_km", optimizedRoute.TotalDistanceKm,
		"total_duration_minutes", optimizedRoute.TotalDurationMinutes,
	)

	// Fetch complete itinerary with visits for response
	createdItin, err := s.ItineraryRepo.GetWithVisits(ctx, itin.ID)
	if err != nil {
		s.Logger.Errorw("Failed to fetch created itinerary", "error", err, "itinerary_id", itin.ID)
		return nil, ierr.WithError(err).
			WithHint("Itinerary created but failed to retrieve details").
			Mark(ierr.ErrDatabase)
	}

	return dto.NewItineraryResponse(createdItin), nil
}

// optimizeRoute implements the nearest-neighbor algorithm for route optimization
func (s *itineraryService) optimizeRoute(
	ctx context.Context,
	req *dto.CreateItineraryRequest,
	places []*place.Place,
) (*itinerary.OptimizedRoute, error) {
	s.Logger.Debugw("Optimizing route", "place_count", len(places), "transport_mode", req.TransportMode)

	// Build location arrays for distance matrix API
	// First location is the start location, then all places
	allLocations := []types.Location{req.StartLocation}
	placeLocations := make([]types.Location, len(places))
	for i, p := range places {
		placeLocations[i] = p.Location
		allLocations = append(allLocations, p.Location)
	}

	// Get distance matrix from routing client
	matrix, err := s.RoutingClient.GetDistanceMatrix(ctx, allLocations, allLocations, req.TransportMode)
	if err != nil {
		s.Logger.Errorw("Failed to get distance matrix", "error", err)
		return nil, ierr.WithError(err).
			WithHint("Failed to calculate distances between locations").
			Mark(ierr.ErrIntegration)
	}

	s.Logger.Debugw("Distance matrix fetched", "size", len(allLocations))

	// Apply nearest-neighbor algorithm
	// Start from index 0 (start location)
	visited := make(map[int]bool)
	route := []int{0} // Start location index
	currentIdx := 0

	// Visit all places (indices 1 to n)
	for len(visited) < len(places) {
		// Find nearest unvisited place
		// Add 1 to indices because we need to skip the start location in exclusion map
		excludedIndices := make(map[int]bool)
		excludedIndices[0] = true // Exclude start location from destinations
		for visitedIdx := range visited {
			excludedIndices[visitedIdx+1] = true
		}

		nearestIdx, _ := matrix.FindNearestDestination(currentIdx, excludedIndices)

		// If nearestIdx is 0 (start location), we've visited all places
		if nearestIdx == 0 {
			break
		}

		route = append(route, nearestIdx)
		visited[nearestIdx-1] = true // -1 because place indices start at 1
		currentIdx = nearestIdx
	}

	s.Logger.Debugw("Route optimized", "route_length", len(route), "route", route)

	// Create visits with timing information
	visits := make([]*itinerary.Visit, 0, len(places))
	totalDistanceKm := 0.0
	totalTravelTimeMinutes := 0
	totalVisitTimeMinutes := 0

	for seq, placeIdx := range route {
		// Skip start location (index 0)
		if placeIdx == 0 {
			continue
		}

		// Get the actual place (placeIdx - 1 because places array doesn't include start location)
		placeArrayIdx := placeIdx - 1
		p := places[placeArrayIdx]

		// Determine visit duration
		visitDuration := req.DefaultDuration
		if req.VisitDurations != nil {
			if customDuration, exists := req.VisitDurations[p.ID]; exists {
				visitDuration = customDuration
			}
		}

		// Calculate distance and travel time from previous location
		var distanceKm *float64
		var travelTimeMinutes *int
		var transportMode *types.TransportMode

		if seq > 0 {
			prevIdx := route[seq-1]
			routeInfo := matrix.Get(prevIdx, placeIdx)
			distanceKm = &routeInfo.DistanceKm
			travelTimeMinutes = &routeInfo.TravelTimeMinutes
			transportMode = &req.TransportMode

			totalDistanceKm += routeInfo.DistanceKm
			totalTravelTimeMinutes += routeInfo.TravelTimeMinutes
		}

		totalVisitTimeMinutes += visitDuration

		// Create visit
		visit := &itinerary.Visit{
			ID:                            types.GenerateUUIDWithPrefix(types.UUID_PREFIX_VISIT),
			PlaceID:                       p.ID,
			SequenceOrder:                 seq, // seq already accounts for start location
			PlannedDurationMinutes:        visitDuration,
			DistanceFromPreviousKm:        distanceKm,
			TravelTimeFromPreviousMinutes: travelTimeMinutes,
			TransportMode:                 transportMode,
			BaseModel: types.BaseModel{
				Status:    types.StatusPublished,
				CreatedAt: time.Now(),
				UpdatedAt: time.Now(),
			},
			Place: p,
		}

		visits = append(visits, visit)
	}

	// Sort visits by sequence order
	sort.Slice(visits, func(i, j int) bool {
		return visits[i].SequenceOrder < visits[j].SequenceOrder
	})

	// Check feasibility - simple time-based check
	// Total time needed = travel time + visit time
	totalTimeNeeded := totalTravelTimeMinutes + totalVisitTimeMinutes

	s.Logger.Debugw("Route metrics calculated",
		"total_distance_km", totalDistanceKm,
		"total_travel_minutes", totalTravelTimeMinutes,
		"total_visit_minutes", totalVisitTimeMinutes,
		"total_time_needed", totalTimeNeeded,
	)

	optimizedRoute := &itinerary.OptimizedRoute{
		Visits:                visits,
		TotalDistanceKm:       totalDistanceKm,
		TotalDurationMinutes:  totalTravelTimeMinutes,
		TotalVisitTimeMinutes: totalVisitTimeMinutes,
		Feasible:              true, // For MVP, we assume it's feasible
	}

	return optimizedRoute, nil
}

// fetchPlaces retrieves places by IDs
func (s *itineraryService) fetchPlaces(ctx context.Context, placeIDs []string) ([]*place.Place, error) {
	places := make([]*place.Place, 0, len(placeIDs))

	for _, id := range placeIDs {
		p, err := s.PlaceRepo.Get(ctx, id)
		if err != nil {
			if ierr.IsNotFound(err) {
				return nil, ierr.NewError("Place not found").
					WithHint("One or more selected places do not exist").
					WithReportableDetails(map[string]interface{}{
						"place_id": id,
					}).
					Mark(ierr.ErrNotFound)
			}
			return nil, ierr.WithError(err).
				WithHint("Failed to fetch place details").
				Mark(ierr.ErrDatabase)
		}

		// Validate place is active
		if p.Status != types.StatusPublished {
			return nil, ierr.NewError("Place is not available").
				WithHint("One or more selected places are not currently available").
				WithReportableDetails(map[string]interface{}{
					"place_id": id,
					"status":   p.Status,
				}).
				Mark(ierr.ErrValidation)
		}

		places = append(places, p)
	}

	return places, nil
}

// Get retrieves an itinerary by ID (without visits)
func (s *itineraryService) Get(ctx context.Context, id string) (*dto.ItineraryResponse, error) {
	itin, err := s.ItineraryRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewItineraryResponse(itin), nil
}

// GetWithVisits retrieves an itinerary by ID with all visits and place details
func (s *itineraryService) GetWithVisits(ctx context.Context, id string) (*dto.ItineraryResponse, error) {
	itin, err := s.ItineraryRepo.GetWithVisits(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewItineraryResponse(itin), nil
}

// Update updates an existing itinerary
func (s *itineraryService) Update(ctx context.Context, id string, req *dto.UpdateItineraryRequest) (*dto.ItineraryResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	// Fetch existing itinerary
	itin, err := s.ItineraryRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	// Apply updates
	if req.Title != nil {
		itin.Title = *req.Title
	}
	if req.Description != nil {
		itin.Description = req.Description
	}
	if req.PlannedDate != nil {
		itin.PlannedDate = *req.PlannedDate
	}
	if req.StartLocation != nil {
		itin.StartLocation = *req.StartLocation
	}
	if req.TransportMode != nil {
		itin.TransportMode = *req.TransportMode
	}
	if req.Status != nil {
		itin.Status = *req.Status
	}

	itin.UpdatedAt = time.Now()

	// Save updates
	err = s.ItineraryRepo.Update(ctx, itin)
	if err != nil {
		s.Logger.Errorw("Failed to update itinerary", "error", err, "itinerary_id", id)
		return nil, ierr.WithError(err).
			WithHint("Failed to update itinerary").
			Mark(ierr.ErrDatabase)
	}

	s.Logger.Infow("Itinerary updated successfully", "itinerary_id", id)

	// Fetch updated itinerary with visits
	updatedItin, err := s.ItineraryRepo.GetWithVisits(ctx, id)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Itinerary updated but failed to retrieve details").
			Mark(ierr.ErrDatabase)
	}

	return dto.NewItineraryResponse(updatedItin), nil
}

// Delete deletes an itinerary by ID
func (s *itineraryService) Delete(ctx context.Context, id string) error {
	// Check if itinerary exists
	_, err := s.ItineraryRepo.Get(ctx, id)
	if err != nil {
		return err
	}

	// Delete all visits associated with this itinerary first
	client := s.DB.Querier(ctx)
	_, err = client.Visit.Delete().
		Where(visit.ItineraryIDEQ(id)).
		Exec(ctx)
	if err != nil {
		s.Logger.Errorw("Failed to delete visits for itinerary", "error", err, "itinerary_id", id)
		return ierr.WithError(err).
			WithHint("Failed to delete associated visits").
			Mark(ierr.ErrDatabase)
	}

	// Now delete the itinerary
	err = s.ItineraryRepo.Delete(ctx, id)
	if err != nil {
		s.Logger.Errorw("Failed to delete itinerary", "error", err, "itinerary_id", id)
		return ierr.WithError(err).
			WithHint("Failed to delete itinerary").
			Mark(ierr.ErrDatabase)
	}

	s.Logger.Infow("Itinerary deleted successfully", "itinerary_id", id)
	return nil
}

// List retrieves itineraries with filtering and pagination
func (s *itineraryService) List(ctx context.Context, filter *types.ItineraryFilter) (*dto.ListItinerariesResponse, error) {
	// Ensure filter has defaults
	if filter == nil {
		filter = types.NewItineraryFilter()
	}

	// Get itineraries
	itineraries, err := s.ItineraryRepo.List(ctx, filter)
	if err != nil {
		s.Logger.Errorw("Failed to list itineraries", "error", err, "filter", filter)
		return nil, ierr.WithError(err).
			WithHint("Failed to retrieve itineraries").
			Mark(ierr.ErrDatabase)
	}

	// Get total count
	total, err := s.ItineraryRepo.Count(ctx, filter)
	if err != nil {
		s.Logger.Errorw("Failed to count itineraries", "error", err, "filter", filter)
		return nil, ierr.WithError(err).
			WithHint("Failed to retrieve itinerary count").
			Mark(ierr.ErrDatabase)
	}

	// Get pagination values
	limit := filter.GetLimit()
	offset := filter.GetOffset()

	return dto.NewItineraryListResponse(itineraries, total, limit, offset), nil
}
