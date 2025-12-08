package itinerary

import (
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/internal/domain/place"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/samber/lo"
)

// Itinerary represents an itinerary domain model
type Itinerary struct {
	// Identity
	ID     string `json:"id"`
	UserID string `json:"user_id"`

	// Trip details
	Title         string              `json:"title"`
	Description   *string             `json:"description,omitempty"`
	PlannedDate   time.Time           `json:"planned_date"`
	StartLocation types.Location      `json:"start_location"`
	TransportMode types.TransportMode `json:"transport_mode"`

	// Route metrics
	TotalDistanceKm       *float64 `json:"total_distance_km,omitempty"`
	TotalDurationMinutes  *int     `json:"total_duration_minutes,omitempty"`
	TotalVisitTimeMinutes *int     `json:"total_visit_time_minutes,omitempty"`
	IsOptimized           bool     `json:"is_optimized"`

	// Metadata
	Metadata map[string]string `json:"metadata,omitempty"`

	// Audit (includes Status from BaseModel)
	types.BaseModel

	// Relations
	Visits []*Visit `json:"visits,omitempty"`
}

// Visit represents a place visit in an itinerary
type Visit struct {
	// Identity
	ID          string `json:"id"`
	ItineraryID string `json:"itinerary_id"`
	PlaceID     string `json:"place_id"`

	// Sequence
	SequenceOrder int `json:"sequence_order"`

	// Planning
	PlannedDurationMinutes int `json:"planned_duration_minutes"`

	// Route info
	DistanceFromPreviousKm        *float64             `json:"distance_from_previous_km,omitempty"`
	TravelTimeFromPreviousMinutes *int                 `json:"travel_time_from_previous_minutes,omitempty"`
	TransportMode                 *types.TransportMode `json:"transport_mode,omitempty"`
	Notes                         *string              `json:"notes,omitempty"`

	// Audit (includes Status from BaseModel)
	types.BaseModel

	// Relations
	Place *place.Place `json:"place,omitempty"`
}

// OptimizedRoute represents the result of route optimization
type OptimizedRoute struct {
	Visits                []*Visit  `json:"visits"`
	TotalDistanceKm       float64   `json:"total_distance_km"`
	TotalDurationMinutes  int       `json:"total_duration_minutes"`
	TotalVisitTimeMinutes int       `json:"total_visit_time_minutes"`
	EstimatedCompletion   time.Time `json:"estimated_completion"`
	TimeBufferMinutes     int       `json:"time_buffer_minutes"`
	Feasible              bool      `json:"feasible"`
}

// FromEnt converts ent.Itinerary to domain Itinerary
func FromEnt(e *ent.Itinerary) *Itinerary {
	if e == nil {
		return nil
	}

	itinerary := &Itinerary{
		ID:          e.ID,
		UserID:      e.UserID,
		Title:       e.Title,
		Description: e.Description,
		PlannedDate: e.PlannedDate,
		StartLocation: types.Location{
			Latitude:  e.StartLatitude,
			Longitude: e.StartLongitude,
		},
		TransportMode:         types.TransportMode(e.PreferredTransportMode),
		TotalDistanceKm:       e.TotalDistanceKm,
		TotalDurationMinutes:  e.TotalDurationMinutes,
		TotalVisitTimeMinutes: e.TotalVisitTimeMinutes,
		IsOptimized:           e.IsOptimized,
		Metadata:              e.Metadata,
		BaseModel: types.BaseModel{
			Status:    types.Status(e.Status),
			CreatedAt: e.CreatedAt,
			UpdatedAt: e.UpdatedAt,
			CreatedBy: e.CreatedBy,
			UpdatedBy: e.UpdatedBy,
		},
	}

	// Convert visits if loaded
	if e.Edges.Visits != nil {
		itinerary.Visits = VisitFromEntList(e.Edges.Visits)
	}

	return itinerary
}

// FromEntList converts a list of ent.Itinerary to domain Itinerary
func FromEntList(itineraries []*ent.Itinerary) []*Itinerary {
	return lo.Map(itineraries, func(itin *ent.Itinerary, _ int) *Itinerary {
		return FromEnt(itin)
	})
}

// VisitFromEnt converts ent.Visit to domain Visit
func VisitFromEnt(e *ent.Visit) *Visit {
	if e == nil {
		return nil
	}

	visit := &Visit{
		ID:                            e.ID,
		ItineraryID:                   e.ItineraryID,
		PlaceID:                       e.PlaceID,
		SequenceOrder:                 e.SequenceOrder,
		PlannedDurationMinutes:        e.PlannedDurationMinutes,
		DistanceFromPreviousKm:        e.DistanceFromPreviousKm,
		TravelTimeFromPreviousMinutes: e.TravelTimeFromPreviousMinutes,
		Notes:                         e.Notes,
		BaseModel: types.BaseModel{
			Status:    types.Status(e.Status),
			CreatedAt: e.CreatedAt,
			UpdatedAt: e.UpdatedAt,
			CreatedBy: e.CreatedBy,
			UpdatedBy: e.UpdatedBy,
		},
	}

	// Convert transport mode if set
	if e.TransportMode != nil {
		transportMode := types.TransportMode(*e.TransportMode)
		visit.TransportMode = &transportMode
	}

	// Convert place if loaded
	if e.Edges.Place != nil {
		visit.Place = place.FromEnt(e.Edges.Place)
	}

	return visit
}

// VisitFromEntList converts a list of ent.Visit to domain Visit
func VisitFromEntList(visits []*ent.Visit) []*Visit {
	return lo.Map(visits, func(v *ent.Visit, _ int) *Visit {
		return VisitFromEnt(v)
	})
}
