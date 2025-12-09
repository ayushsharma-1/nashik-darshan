package types

import (
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
)

// TransportMode represents the mode of transportation between visits
type TransportMode string

const (
	TransportModeWalking TransportMode = "WALKING"
	TransportModeDriving TransportMode = "DRIVING"
	TransportModeTaxi    TransportMode = "TAXI"
)

// Validate validates the TransportMode
func (tm TransportMode) Validate() error {
	switch tm {
	case TransportModeWalking, TransportModeDriving, TransportModeTaxi:
		return nil
	default:
		return ierr.NewError("Invalid transport mode").
			WithHint("Must be one of: WALKING, DRIVING, TAXI").
			Mark(ierr.ErrValidation)
	}
}

// ItineraryStatus represents the current state of an itinerary
type ItineraryStatus string

const (
	ItineraryStatusDraft     ItineraryStatus = "DRAFT"
	ItineraryStatusCompleted ItineraryStatus = "COMPLETED"
	ItineraryStatusCancelled ItineraryStatus = "CANCELLED"
)

// Validate validates the ItineraryStatus
func (is ItineraryStatus) Validate() error {
	switch is {
	case ItineraryStatusDraft, ItineraryStatusCompleted, ItineraryStatusCancelled:
		return nil
	default:
		return ierr.NewError("Invalid itinerary status").
			WithHint("Must be one of: DRAFT, COMPLETED, CANCELLED").
			Mark(ierr.ErrValidation)
	}
}

// ItineraryFilter for querying itineraries
type ItineraryFilter struct {
	*QueryFilter
	UserID          *string          `form:"user_id"`
	ItineraryStatus *ItineraryStatus `form:"status"`
	FromDate        *string          `form:"from_date"` // ISO date YYYY-MM-DD
	ToDate          *string          `form:"to_date"`   // ISO date YYYY-MM-DD
	TransportMode   *TransportMode   `form:"transport_mode"`
}

// NewItineraryFilter creates a new ItineraryFilter with defaults
func NewItineraryFilter() *ItineraryFilter {
	return &ItineraryFilter{
		QueryFilter: NewDefaultQueryFilter(),
	}
}

// Validate validates the itinerary filter
func (f *ItineraryFilter) Validate() error {
	if f.QueryFilter != nil {
		return f.QueryFilter.Validate()
	}
	return nil
}
