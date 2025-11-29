package event

import (
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

// Event represents an event domain model
type Event struct {
	// Identity
	ID   string `json:"id"`
	Slug string `json:"slug"`

	// Core
	Type        types.EventType `json:"type"`
	Title       string          `json:"title"`
	Subtitle    *string         `json:"subtitle,omitempty"`
	Description *string         `json:"description,omitempty"`

	// Association
	PlaceID *string `json:"place_id,omitempty"`

	// Validity
	StartDate time.Time  `json:"start_date"`
	EndDate   *time.Time `json:"end_date,omitempty"`

	// Media
	CoverImageURL *string  `json:"cover_image_url,omitempty"`
	Images        []string `json:"images,omitempty"`

	// Metadata
	Tags     []string        `json:"tags,omitempty"`
	Metadata *types.Metadata `json:"metadata,omitempty"`

	// Location (for citywide)
	Latitude     *decimal.Decimal `json:"latitude,omitempty"`
	Longitude    *decimal.Decimal `json:"longitude,omitempty"`
	LocationName *string          `json:"location_name,omitempty"`

	// Stats
	ViewCount       int `json:"view_count"`
	InterestedCount int `json:"interested_count"`

	// Relations (populated when needed)
	Occurrences []*EventOccurrence `json:"occurrences,omitempty"`

	// Audit (includes Status)
	types.BaseModel
}

// EventOccurrence represents an event occurrence domain model
type EventOccurrence struct {
	// Identity
	ID      string `json:"id"`
	EventID string `json:"event_id"`

	// Recurrence
	RecurrenceType types.RecurrenceType `json:"recurrence_type"`

	// Time
	StartTime       *time.Time `json:"start_time,omitempty"`
	EndTime         *time.Time `json:"end_time,omitempty"`
	DurationMinutes *int       `json:"duration_minutes,omitempty"`

	// Day specifics
	DayOfWeek   *int `json:"day_of_week,omitempty"`   // 0-6
	DayOfMonth  *int `json:"day_of_month,omitempty"`  // 1-31
	MonthOfYear *int `json:"month_of_year,omitempty"` // 1-12 (renamed from Month)

	// Exceptions
	ExceptionDates []string `json:"exception_dates,omitempty"`

	// Metadata
	Metadata *types.Metadata `json:"metadata,omitempty"`

	// Audit (includes Status)
	types.BaseModel
}

// ExpandedOccurrence represents a concrete event instance
type ExpandedOccurrence struct {
	EventID      string    `json:"event_id"`
	OccurrenceID string    `json:"occurrence_id"`
	Title        string    `json:"title"`
	StartTime    time.Time `json:"start_time"` // Full datetime
	EndTime      time.Time `json:"end_time"`   // Full datetime
	IsToday      bool      `json:"is_today"`
	IsUpcoming   bool      `json:"is_upcoming"`
	DaysUntil    int       `json:"days_until,omitempty"`
}

// FromEnt converts Ent Event to domain Event
func FromEnt(e *ent.Event) *Event {
	if e == nil {
		return nil
	}

	event := &Event{
		ID:              e.ID,
		Slug:            e.Slug,
		Type:            types.EventType(e.Type),
		Title:           e.Title,
		Subtitle:        e.Subtitle,
		Description:     e.Description,
		PlaceID:         e.PlaceID,
		StartDate:       e.StartDate,
		EndDate:         e.EndDate,
		CoverImageURL:   e.CoverImageURL,
		Images:          e.Images,
		Tags:            e.Tags,
		Metadata:        types.NewMetadataFromMap(e.Metadata),
		Latitude:        e.Latitude,
		Longitude:       e.Longitude,
		LocationName:    e.LocationName,
		ViewCount:       e.ViewCount,
		InterestedCount: e.InterestedCount,
		BaseModel: types.BaseModel{
			Status:    types.Status(e.Status),
			CreatedBy: e.CreatedBy,
			UpdatedBy: e.UpdatedBy,
			CreatedAt: e.CreatedAt,
			UpdatedAt: e.UpdatedAt,
		},
	}

	// Convert occurrences if loaded
	if e.Edges.Occurrences != nil {
		event.Occurrences = OccurrenceFromEntList(e.Edges.Occurrences)
	}

	return event
}

// OccurrenceFromEnt converts Ent EventOccurrence to domain EventOccurrence
func OccurrenceFromEnt(e *ent.EventOccurrence) *EventOccurrence {
	if e == nil {
		return nil
	}

	return &EventOccurrence{
		ID:              e.ID,
		EventID:         e.EventID,
		RecurrenceType:  types.RecurrenceType(e.RecurrenceType),
		StartTime:       e.StartTime,
		EndTime:         e.EndTime,
		DurationMinutes: e.DurationMinutes,
		DayOfWeek:       e.DayOfWeek,
		DayOfMonth:      e.DayOfMonth,
		MonthOfYear:     e.MonthOfYear,
		ExceptionDates:  e.ExceptionDates,
		Metadata:        types.NewMetadataFromMap(e.Metadata),
		BaseModel: types.BaseModel{
			Status:    types.Status(e.Status),
			CreatedBy: e.CreatedBy,
			UpdatedBy: e.UpdatedBy,
			CreatedAt: e.CreatedAt,
			UpdatedAt: e.UpdatedAt,
		},
	}
}

// FromEntList converts a list of Ent Events to domain Events
func FromEntList(events []*ent.Event) []*Event {
	if events == nil {
		return nil
	}

	result := make([]*Event, len(events))
	for i, e := range events {
		result[i] = FromEnt(e)
	}
	return result
}

// OccurrenceFromEntList converts a list of Ent EventOccurrences to domain EventOccurrences
func OccurrenceFromEntList(occurrences []*ent.EventOccurrence) []*EventOccurrence {
	if occurrences == nil {
		return nil
	}

	result := make([]*EventOccurrence, len(occurrences))
	for i, occ := range occurrences {
		result[i] = OccurrenceFromEnt(occ)
	}
	return result
}
