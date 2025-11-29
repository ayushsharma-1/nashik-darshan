package types

import ierr "github.com/omkar273/nashikdarshan/internal/errors"

// EventType represents the category of event
type EventType string

const (
	EventTypeAarti          EventType = "AARTI"
	EventTypeFestival       EventType = "FESTIVAL"
	EventTypeCultural       EventType = "CULTURAL"
	EventTypeWorkshop       EventType = "WORKSHOP"
	EventTypeSpecialDarshan EventType = "SPECIAL_DARSHAN"
)

// Validate validates the EventType
func (et EventType) Validate() error {
	switch et {
	case EventTypeAarti, EventTypeFestival, EventTypeCultural, EventTypeWorkshop, EventTypeSpecialDarshan:
		return nil
	default:
		return ierr.NewError("Invalid event type. Must be one of: AARTI, FESTIVAL, CULTURAL, WORKSHOP, SPECIAL_DARSHAN").
			Mark(ierr.ErrValidation)
	}
}

// RecurrenceType represents how an event occurrence repeats
type RecurrenceType string

const (
	RecurrenceNone    RecurrenceType = "NONE"    // One-time event
	RecurrenceDaily   RecurrenceType = "DAILY"   // Every day
	RecurrenceWeekly  RecurrenceType = "WEEKLY"  // Specific day each week
	RecurrenceMonthly RecurrenceType = "MONTHLY" // Specific date each month
	RecurrenceYearly  RecurrenceType = "YEARLY"  // Specific date each year
)

// Validate validates the RecurrenceType
func (rt RecurrenceType) Validate() error {
	switch rt {
	case RecurrenceNone, RecurrenceDaily, RecurrenceWeekly, RecurrenceMonthly, RecurrenceYearly:
		return nil
	default:
		return ierr.NewError("Invalid recurrence type. Must be one of: NONE, DAILY, WEEKLY, MONTHLY, YEARLY").
			Mark(ierr.ErrValidation)
	}
}

// EventFilter for querying events
type EventFilter struct {
	*QueryFilter
	Type     *EventType `form:"type"`
	PlaceID  *string    `form:"place_id"`
	FromDate *string    `form:"from_date"` // ISO date YYYY-MM-DD
	ToDate   *string    `form:"to_date"`   // ISO date YYYY-MM-DD
	Tags     []string   `form:"tags"`
	Expand   *bool      `form:"expand"` // If true, expand occurrences in date range
}

// NewEventFilter creates a new EventFilter with defaults
func NewEventFilter() *EventFilter {
	return &EventFilter{
		QueryFilter: NewDefaultQueryFilter(),
	}
}

// Validate validates the event filter
func (f *EventFilter) Validate() error {
	if f.QueryFilter != nil {
		return f.QueryFilter.Validate()
	}
	return nil
}

// OccurrenceFilter for querying event occurrences
type OccurrenceFilter struct {
	*QueryFilter
	EventID *string `form:"event_id"` // Filter by parent event
}

// NewOccurrenceFilter creates a new OccurrenceFilter with defaults
func NewOccurrenceFilter() *OccurrenceFilter {
	return &OccurrenceFilter{
		QueryFilter: NewDefaultQueryFilter(),
	}
}

// Validate validates the occurrence filter
func (f *OccurrenceFilter) Validate() error {
	if f.QueryFilter != nil {
		return f.QueryFilter.Validate()
	}
	return nil
}
