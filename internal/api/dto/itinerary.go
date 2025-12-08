package dto

import (
	"time"

	"github.com/omkar273/nashikdarshan/internal/domain/itinerary"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
)

// CreateItineraryRequest represents a request to create an itinerary
type CreateItineraryRequest struct {
	Title           string              `json:"title" binding:"required,min=3,max=255"`
	Description     *string             `json:"description,omitempty" binding:"omitempty,max=1000"`
	PlannedDate     time.Time           `json:"planned_date" binding:"required"`
	StartLocation   types.Location      `json:"start_location" binding:"required"`
	TransportMode   types.TransportMode `json:"transport_mode" binding:"required"`
	SelectedPlaces  []string            `json:"selected_places" binding:"required,min=1,max=10"`
	VisitDurations  map[string]int      `json:"visit_durations,omitempty"` // placeID -> minutes
	DefaultDuration int                 `json:"default_duration" binding:"omitempty,min=15,max=240"`
}

// Validate validates the CreateItineraryRequest
func (req *CreateItineraryRequest) Validate() error {
	// Validate using project validator
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate planned date is not in the past
	today := time.Now().Truncate(24 * time.Hour)
	reqDate := req.PlannedDate.Truncate(24 * time.Hour)
	if reqDate.Before(today) {
		return ierr.NewError("Planned date cannot be in the past").
			WithHint("Please select today or a future date").
			Mark(ierr.ErrValidation)
	}

	// Validate location coordinates
	if err := req.StartLocation.Validate(); err != nil {
		return ierr.WithError(err).
			WithHint("Please provide valid latitude and longitude for start location").
			Mark(ierr.ErrValidation)
	}

	// Validate no duplicate place IDs
	seen := make(map[string]bool)
	for _, placeID := range req.SelectedPlaces {
		if seen[placeID] {
			return ierr.NewError("Duplicate place IDs not allowed").
				WithHint("Each place can only be selected once").
				WithReportableDetails(map[string]interface{}{
					"duplicate_id": placeID,
				}).
				Mark(ierr.ErrValidation)
		}
		seen[placeID] = true
	}

	// Validate transport mode
	if err := req.TransportMode.Validate(); err != nil {
		return err
	}

	// Validate visit durations if provided
	if req.VisitDurations != nil {
		for placeID, duration := range req.VisitDurations {
			if duration < 5 || duration > 480 {
				return ierr.NewError("Visit duration must be between 5 and 480 minutes").
					WithHint("Please provide a valid duration for each place").
					WithReportableDetails(map[string]interface{}{
						"place_id": placeID,
						"duration": duration,
					}).
					Mark(ierr.ErrValidation)
			}
		}
	}

	// Set default duration if not provided
	if req.DefaultDuration == 0 {
		req.DefaultDuration = 30 // 30 minutes default
	}

	return nil
}

// UpdateItineraryRequest represents a request to update an itinerary
type UpdateItineraryRequest struct {
	Title         *string              `json:"title,omitempty" binding:"omitempty,min=3,max=255"`
	Description   *string              `json:"description,omitempty" binding:"omitempty,max=1000"`
	PlannedDate   *time.Time           `json:"planned_date,omitempty"`
	StartLocation *types.Location      `json:"start_location,omitempty"`
	TransportMode *types.TransportMode `json:"transport_mode,omitempty"`
	Status        *types.Status        `json:"status,omitempty"`
}

// Validate validates the UpdateItineraryRequest
func (req *UpdateItineraryRequest) Validate() error {
	// Validate using project validator
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate planned date is not in the past if provided
	if req.PlannedDate != nil {
		today := time.Now().Truncate(24 * time.Hour)
		reqDate := req.PlannedDate.Truncate(24 * time.Hour)
		if reqDate.Before(today) {
			return ierr.NewError("Planned date cannot be in the past").
				WithHint("Please select today or a future date").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate location coordinates if provided
	if req.StartLocation != nil {
		if err := req.StartLocation.Validate(); err != nil {
			return ierr.WithError(err).
				WithHint("Please provide valid latitude and longitude for start location").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate transport mode if provided
	if req.TransportMode != nil {
		if err := req.TransportMode.Validate(); err != nil {
			return err
		}
	}

	return nil
}

// ItineraryResponse represents an itinerary in the response
type ItineraryResponse struct {
	ID                    string              `json:"id"`
	UserID                string              `json:"user_id"`
	Title                 string              `json:"title"`
	Description           *string             `json:"description,omitempty"`
	PlannedDate           time.Time           `json:"planned_date"`
	StartLocation         types.Location      `json:"start_location"`
	TransportMode         types.TransportMode `json:"transport_mode"`
	TotalDistanceKm       *float64            `json:"total_distance_km,omitempty"`
	TotalDurationMinutes  *int                `json:"total_duration_minutes,omitempty"`
	TotalVisitTimeMinutes *int                `json:"total_visit_time_minutes,omitempty"`
	IsOptimized           bool                `json:"is_optimized"`
	Status                types.Status        `json:"status"`
	CreatedAt             time.Time           `json:"created_at"`
	UpdatedAt             time.Time           `json:"updated_at"`
	Visits                []*VisitResponse    `json:"visits,omitempty"`
}

// VisitResponse represents a visit in the response
type VisitResponse struct {
	ID                            string               `json:"id"`
	ItineraryID                   string               `json:"itinerary_id"`
	PlaceID                       string               `json:"place_id"`
	SequenceOrder                 int                  `json:"sequence_order"`
	PlannedDurationMinutes        int                  `json:"planned_duration_minutes"`
	DistanceFromPreviousKm        *float64             `json:"distance_from_previous_km,omitempty"`
	TravelTimeFromPreviousMinutes *int                 `json:"travel_time_from_previous_minutes,omitempty"`
	TransportMode                 *types.TransportMode `json:"transport_mode,omitempty"`
	Notes                         *string              `json:"notes,omitempty"`
	Status                        types.Status         `json:"status"`
	CreatedAt                     time.Time            `json:"created_at"`
	UpdatedAt                     time.Time            `json:"updated_at"`
	Place                         *PlaceResponse       `json:"place,omitempty"`
}

// ListItinerariesResponse represents a paginated list of itineraries
type ListItinerariesResponse struct {
	Itineraries []*ItineraryResponse `json:"itineraries"`
	Total       int                  `json:"total"`
	Limit       int                  `json:"limit"`
	Offset      int                  `json:"offset"`
}

// NewItineraryResponse creates a new ItineraryResponse from domain model
func NewItineraryResponse(itin *itinerary.Itinerary) *ItineraryResponse {
	if itin == nil {
		return nil
	}

	resp := &ItineraryResponse{
		ID:                    itin.ID,
		UserID:                itin.UserID,
		Title:                 itin.Title,
		Description:           itin.Description,
		PlannedDate:           itin.PlannedDate,
		StartLocation:         itin.StartLocation,
		TransportMode:         itin.TransportMode,
		TotalDistanceKm:       itin.TotalDistanceKm,
		TotalDurationMinutes:  itin.TotalDurationMinutes,
		TotalVisitTimeMinutes: itin.TotalVisitTimeMinutes,
		IsOptimized:           itin.IsOptimized,
		Status:                itin.Status,
		CreatedAt:             itin.CreatedAt,
		UpdatedAt:             itin.UpdatedAt,
	}

	// Convert visits if present
	if len(itin.Visits) > 0 {
		resp.Visits = lo.Map(itin.Visits, func(v *itinerary.Visit, _ int) *VisitResponse {
			return NewVisitResponse(v)
		})
	}

	return resp
}

// NewVisitResponse creates a new VisitResponse from domain model
func NewVisitResponse(visit *itinerary.Visit) *VisitResponse {
	if visit == nil {
		return nil
	}

	resp := &VisitResponse{
		ID:                            visit.ID,
		ItineraryID:                   visit.ItineraryID,
		PlaceID:                       visit.PlaceID,
		SequenceOrder:                 visit.SequenceOrder,
		PlannedDurationMinutes:        visit.PlannedDurationMinutes,
		DistanceFromPreviousKm:        visit.DistanceFromPreviousKm,
		TravelTimeFromPreviousMinutes: visit.TravelTimeFromPreviousMinutes,
		TransportMode:                 visit.TransportMode,
		Notes:                         visit.Notes,
		Status:                        visit.Status,
		CreatedAt:                     visit.CreatedAt,
		UpdatedAt:                     visit.UpdatedAt,
	}

	// Convert place if present
	if visit.Place != nil {
		resp.Place = NewPlaceResponse(visit.Place)
	}

	return resp
}

// NewItineraryListResponse creates a new ListItinerariesResponse
func NewItineraryListResponse(itineraries []*itinerary.Itinerary, total, limit, offset int) *ListItinerariesResponse {
	return &ListItinerariesResponse{
		Itineraries: lo.Map(itineraries, func(itin *itinerary.Itinerary, _ int) *ItineraryResponse {
			return NewItineraryResponse(itin)
		}),
		Total:  total,
		Limit:  limit,
		Offset: offset,
	}
}
