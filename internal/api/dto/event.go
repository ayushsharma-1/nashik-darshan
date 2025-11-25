package dto

import (
	"context"
	"time"

	eventdomain "github.com/omkar273/nashikdarshan/internal/domain/event"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/shopspring/decimal"
)

// ========== Event DTOs ==========

// CreateEventRequest represents a request to create an event
type CreateEventRequest struct {
	Slug          string                 `json:"slug" binding:"required,min=3,max=100"`
	Type          types.EventType        `json:"type" binding:"required"`
	Title         string                 `json:"title" binding:"required,min=2,max=255"`
	Subtitle      *string                `json:"subtitle,omitempty" binding:"omitempty,max=500"`
	Description   *string                `json:"description,omitempty" binding:"omitempty,max=10000"`
	PlaceID       *string                `json:"place_id,omitempty"`
	StartDate     time.Time              `json:"start_date"` // Required, defaults to now() if zero value
	EndDate       *time.Time             `json:"end_date,omitempty"`
	CoverImageURL *string                `json:"cover_image_url,omitempty" binding:"omitempty,url,max=500"`
	Images        []string               `json:"images,omitempty"`
	Tags          []string               `json:"tags,omitempty"`
	Metadata      map[string]interface{} `json:"metadata,omitempty"`
	Latitude      *decimal.Decimal       `json:"latitude,omitempty"`
	Longitude     *decimal.Decimal       `json:"longitude,omitempty"`
	LocationName  *string                `json:"location_name,omitempty" binding:"omitempty,max=255"`
}

// Validate validates the CreateEventRequest
func (req *CreateEventRequest) Validate() error {
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate slug format
	if err := validator.ValidateSlugFormat(req.Slug); err != nil {
		return err
	}

	// Validate event type using the type's own Validate method
	if err := req.Type.Validate(); err != nil {
		return err
	}

	// Validate start date
	now := time.Now().UTC()
	oneYearAgo := now.AddDate(-1, 0, 0)

	// If StartDate is zero value, it will be set to now() in ToEvent
	if !req.StartDate.IsZero() && req.StartDate.Before(oneYearAgo) {
		return ierr.NewError("Start date cannot be more than 1 year in the past").
			Mark(ierr.ErrValidation)
	}

	// Validate end date if provided
	if req.EndDate != nil {
		// Use provided start date, or now() if not provided
		effectiveStartDate := req.StartDate
		if effectiveStartDate.IsZero() {
			effectiveStartDate = now
		}

		// End date must be after start date
		if !req.EndDate.After(effectiveStartDate) {
			return ierr.NewError("End date must be after start date").
				Mark(ierr.ErrValidation)
		}

		// Event duration should not exceed 10 years
		maxEndDate := effectiveStartDate.AddDate(10, 0, 0)
		if req.EndDate.After(maxEndDate) {
			return ierr.NewError("Event duration cannot exceed 10 years").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate location: must have either place_id OR coordinates, but not both
	hasPlaceID := req.PlaceID != nil && *req.PlaceID != ""
	hasCoordinates := req.Latitude != nil && req.Longitude != nil

	if hasPlaceID && hasCoordinates {
		return ierr.NewError("Event cannot have both place_id and coordinates. Please provide only one").
			Mark(ierr.ErrValidation)
	}

	if !hasPlaceID && !hasCoordinates {
		return ierr.NewError("Event must have either place_id or coordinates (latitude+longitude)").
			Mark(ierr.ErrValidation)
	}

	return nil
}

// ToEvent converts CreateEventRequest to domain Event
func (req *CreateEventRequest) ToEvent(ctx context.Context) (*eventdomain.Event, error) {
	baseModel := types.GetDefaultBaseModel(ctx)

	// Use provided StartDate or default to now() if zero value
	startDate := req.StartDate
	if startDate.IsZero() {
		startDate = time.Now().UTC()
	}

	// Status is always draft for new events (handled internally)
	baseModel.Status = types.StatusDraft

	// Convert metadata from map[string]interface{} to *types.Metadata
	var metadata *types.Metadata
	if req.Metadata != nil {
		md := make(types.Metadata)
		for k, v := range req.Metadata {
			if strVal, ok := v.(string); ok {
				md[k] = strVal
			}
		}
		metadata = &md
	}

	return &eventdomain.Event{
		ID:              types.GenerateUUIDWithPrefix(types.UUID_PREFIX_EVENT),
		Slug:            req.Slug,
		Type:            req.Type,
		Title:           req.Title,
		Subtitle:        req.Subtitle,
		Description:     req.Description,
		PlaceID:         req.PlaceID,
		StartDate:       startDate,
		EndDate:         req.EndDate,
		CoverImageURL:   req.CoverImageURL,
		Images:          req.Images,
		Tags:            req.Tags,
		Metadata:        metadata,
		Latitude:        req.Latitude,
		Longitude:       req.Longitude,
		LocationName:    req.LocationName,
		ViewCount:       0, // Default to 0 for new events
		InterestedCount: 0, // Default to 0 for new events
		BaseModel:       baseModel,
	}, nil
}

// UpdateEventRequest represents a request to update an event
type UpdateEventRequest struct {
	Type          *types.EventType       `json:"type,omitempty"`
	Title         *string                `json:"title,omitempty" binding:"omitempty,min=2,max=255"`
	Subtitle      *string                `json:"subtitle,omitempty" binding:"omitempty,max=500"`
	Description   *string                `json:"description,omitempty" binding:"omitempty,max=10000"`
	PlaceID       *string                `json:"place_id,omitempty"`
	StartDate     *time.Time             `json:"start_date,omitempty"`
	EndDate       *time.Time             `json:"end_date,omitempty"`
	CoverImageURL *string                `json:"cover_image_url,omitempty" binding:"omitempty,url"`
	Images        []string               `json:"images,omitempty"`
	Tags          []string               `json:"tags,omitempty"`
	Metadata      map[string]interface{} `json:"metadata,omitempty"`
	Latitude      *decimal.Decimal       `json:"latitude,omitempty"`
	Longitude     *decimal.Decimal       `json:"longitude,omitempty"`
	LocationName  *string                `json:"location_name,omitempty" binding:"omitempty,max=255"`
}

// Validate validates the UpdateEventRequest
func (req *UpdateEventRequest) Validate() error {
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate event type if provided using the type's own Validate method
	if req.Type != nil {
		if err := req.Type.Validate(); err != nil {
			return err
		}
	}

	// If both dates are provided, validate them
	if req.StartDate != nil && req.EndDate != nil {
		// Start date must not be too far in the past
		now := time.Now().UTC()
		oneYearAgo := now.AddDate(-1, 0, 0)

		if req.StartDate.Before(oneYearAgo) {
			return ierr.NewError("Start date cannot be more than 1 year in the past").
				Mark(ierr.ErrValidation)
		}

		// End date must be after start date
		if !req.EndDate.After(*req.StartDate) {
			return ierr.NewError("End date must be after start date").
				Mark(ierr.ErrValidation)
		}

		// Event duration should not exceed 10 years
		maxEndDate := req.StartDate.AddDate(10, 0, 0)
		if req.EndDate.After(maxEndDate) {
			return ierr.NewError("Event duration cannot exceed 10 years").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// ApplyToEvent applies the update request to an existing event
func (req *UpdateEventRequest) ApplyToEvent(ctx context.Context, event *eventdomain.Event) error {
	if req.Type != nil {
		event.Type = *req.Type
	}
	if req.Title != nil {
		event.Title = *req.Title
	}
	if req.Subtitle != nil {
		event.Subtitle = req.Subtitle
	}
	if req.Description != nil {
		event.Description = req.Description
	}
	if req.PlaceID != nil {
		event.PlaceID = req.PlaceID
	}
	if req.StartDate != nil {
		event.StartDate = *req.StartDate
	}
	if req.EndDate != nil {
		event.EndDate = req.EndDate
	}
	if req.CoverImageURL != nil {
		event.CoverImageURL = req.CoverImageURL
	}
	if req.Images != nil {
		event.Images = req.Images
	}
	if req.Tags != nil {
		event.Tags = req.Tags
	}
	if req.Metadata != nil {
		md := make(types.Metadata)
		for k, v := range req.Metadata {
			if strVal, ok := v.(string); ok {
				md[k] = strVal
			}
		}
		event.Metadata = &md
	}
	if req.Latitude != nil {
		event.Latitude = req.Latitude
	}
	if req.Longitude != nil {
		event.Longitude = req.Longitude
	}
	if req.LocationName != nil {
		event.LocationName = req.LocationName
	}

	return nil
}

// EventResponse represents an event in the response
type EventResponse struct {
	*eventdomain.Event
}

// ListEventsResponse represents a paginated list of events
type ListEventsResponse = types.ListResponse[*EventResponse]

// NewEventResponse creates an EventResponse from domain Event
func NewEventResponse(e *eventdomain.Event) *EventResponse {
	return &EventResponse{
		Event: e,
	}
}

// NewListEventsResponse creates a paginated list response
func NewListEventsResponse(events []*eventdomain.Event, total, limit, offset int) *ListEventsResponse {
	responses := make([]*EventResponse, len(events))
	for i, e := range events {
		responses[i] = NewEventResponse(e)
	}

	response := types.NewListResponse(responses, total, limit, offset)
	return &response
}

// ========== Occurrence DTOs ==========

// CreateOccurrenceRequest represents a request to create an occurrence
type CreateOccurrenceRequest struct {
	EventID        string                 `json:"event_id" binding:"required"`
	RecurrenceType types.RecurrenceType   `json:"recurrence_type" binding:"required"`
	StartTime      *time.Time             `json:"start_time,omitempty"`      // ISO 8601 format, optional/nillable
	EndTime        *time.Time             `json:"end_time,omitempty"`        // ISO 8601 format, optional/nillable
	DayOfWeek      *int                   `json:"day_of_week,omitempty"`     // 0-6 for WEEKLY
	DayOfMonth     *int                   `json:"day_of_month,omitempty"`    // 1-31 for MONTHLY/YEARLY
	MonthOfYear    *int                   `json:"month_of_year,omitempty"`   // 1-12 for YEARLY
	ExceptionDates []string               `json:"exception_dates,omitempty"` // ["2025-12-25", ...]
	Metadata       map[string]interface{} `json:"metadata,omitempty"`
}

// Validate validates the CreateOccurrenceRequest
func (req *CreateOccurrenceRequest) Validate() error {
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate recurrence type using the type's own Validate method
	if err := req.RecurrenceType.Validate(); err != nil {
		return err
	}

	// Validate times if both are provided (both are optional/nillable)
	if req.StartTime != nil && req.EndTime != nil {
		// Validate occurrence times inline
		startHour, startMin := req.StartTime.Hour(), req.StartTime.Minute()
		endHour, endMin := req.EndTime.Hour(), req.EndTime.Minute()

		startMinutes := startHour*60 + startMin
		endMinutes := endHour*60 + endMin

		if endMinutes <= startMinutes {
			return ierr.NewError("End time must be after start time").
				Mark(ierr.ErrValidation)
		}

		// Duration should be reasonable (max 12 hours)
		duration := endMinutes - startMinutes
		if duration > 12*60 {
			return ierr.NewError("Occurrence duration cannot exceed 12 hours").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate recurrence rules inline
	switch req.RecurrenceType {
	case types.RecurrenceNone, types.RecurrenceDaily:
		// No day restrictions needed
	case types.RecurrenceWeekly:
		// Weekly events MUST have day_of_week
		if req.DayOfWeek == nil {
			return ierr.NewError("Weekly recurrence requires day_of_week (0-6)").
				Mark(ierr.ErrValidation)
		}
		// Validate day of week (0-6, Sunday=0)
		if *req.DayOfWeek < 0 || *req.DayOfWeek > 6 {
			return ierr.NewError("Day of week must be between 0 (Sunday) and 6 (Saturday)").
				Mark(ierr.ErrValidation)
		}
	case types.RecurrenceMonthly:
		// Monthly events MUST have day_of_month
		if req.DayOfMonth == nil {
			return ierr.NewError("Monthly recurrence requires day_of_month (1-31)").
				Mark(ierr.ErrValidation)
		}
		// Validate day of month (1-31)
		if *req.DayOfMonth < 1 || *req.DayOfMonth > 31 {
			return ierr.NewError("Day of month must be between 1 and 31").
				Mark(ierr.ErrValidation)
		}
	case types.RecurrenceYearly:
		// Yearly events MUST have both day_of_month and month_of_year
		if req.DayOfMonth == nil {
			return ierr.NewError("Yearly recurrence requires day_of_month (1-31)").
				Mark(ierr.ErrValidation)
		}
		if req.MonthOfYear == nil {
			return ierr.NewError("Yearly recurrence requires month_of_year (1-12)").
				Mark(ierr.ErrValidation)
		}
		// Validate day of month (1-31)
		if *req.DayOfMonth < 1 || *req.DayOfMonth > 31 {
			return ierr.NewError("Day of month must be between 1 and 31").
				Mark(ierr.ErrValidation)
		}
		// Validate month of year (1-12)
		if *req.MonthOfYear < 1 || *req.MonthOfYear > 12 {
			return ierr.NewError("Month of year must be between 1 (January) and 12 (December)").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate exception dates inline
	if len(req.ExceptionDates) > 0 {
		for _, dateStr := range req.ExceptionDates {
			_, err := time.Parse("2006-01-02", dateStr)
			if err != nil {
				return ierr.NewError("Exception dates must be in YYYY-MM-DD format").
					WithReportableDetails(map[string]any{
						"invalid_date": dateStr,
					}).
					Mark(ierr.ErrValidation)
			}
		}
	}

	return nil
}

// ToOccurrence converts CreateOccurrenceRequest to domain EventOccurrence
func (req *CreateOccurrenceRequest) ToOccurrence(ctx context.Context) (*eventdomain.EventOccurrence, error) {
	baseModel := types.GetDefaultBaseModel(ctx)

	// Calculate duration if both times are provided (both are optional)
	var duration *int
	if req.StartTime != nil && req.EndTime != nil {
		durationMinutes := int(req.EndTime.Sub(*req.StartTime).Minutes())
		duration = &durationMinutes
	}

	// Status is always published for new occurrences (active/published state)
	baseModel.Status = types.StatusPublished

	// Convert metadata from map[string]interface{} to *types.Metadata
	var metadata *types.Metadata
	if req.Metadata != nil {
		md := make(types.Metadata)
		for k, v := range req.Metadata {
			if strVal, ok := v.(string); ok {
				md[k] = strVal
			}
		}
		metadata = &md
	}

	return &eventdomain.EventOccurrence{
		ID:              types.GenerateUUIDWithPrefix(types.UUID_PREFIX_OCCURRENCE),
		EventID:         req.EventID,
		RecurrenceType:  req.RecurrenceType,
		StartTime:       req.StartTime, // Optional/nillable
		EndTime:         req.EndTime,   // Optional/nillable
		DurationMinutes: duration,      // Optional/nillable, calculated if both times provided
		DayOfWeek:       req.DayOfWeek,
		DayOfMonth:      req.DayOfMonth,
		MonthOfYear:     req.MonthOfYear,
		ExceptionDates:  req.ExceptionDates,
		Metadata:        metadata,
		BaseModel:       baseModel,
	}, nil
}

// UpdateOccurrenceRequest represents a request to update an occurrence
type UpdateOccurrenceRequest struct {
	RecurrenceType *types.RecurrenceType  `json:"recurrence_type,omitempty"`
	StartTime      *time.Time             `json:"start_time,omitempty"` // ISO 8601 format, optional/nillable
	EndTime        *time.Time             `json:"end_time,omitempty"`   // ISO 8601 format, optional/nillable
	DayOfWeek      *int                   `json:"day_of_week,omitempty"`
	DayOfMonth     *int                   `json:"day_of_month,omitempty"`
	MonthOfYear    *int                   `json:"month_of_year,omitempty"`
	ExceptionDates []string               `json:"exception_dates,omitempty"`
	Metadata       map[string]interface{} `json:"metadata,omitempty"`
}

// Validate validates the UpdateOccurrenceRequest
func (req *UpdateOccurrenceRequest) Validate() error {
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate recurrence type if provided using the type's own Validate method
	if req.RecurrenceType != nil {
		if err := req.RecurrenceType.Validate(); err != nil {
			return err
		}
	}

	// If both times are provided, validate them inline
	if req.StartTime != nil && req.EndTime != nil {
		// Validate occurrence times
		startHour, startMin := req.StartTime.Hour(), req.StartTime.Minute()
		endHour, endMin := req.EndTime.Hour(), req.EndTime.Minute()

		startMinutes := startHour*60 + startMin
		endMinutes := endHour*60 + endMin

		if endMinutes <= startMinutes {
			return ierr.NewError("End time must be after start time").
				Mark(ierr.ErrValidation)
		}

		// Duration should be reasonable (max 12 hours)
		duration := endMinutes - startMinutes
		if duration > 12*60 {
			return ierr.NewError("Occurrence duration cannot exceed 12 hours").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate exception dates inline
	if len(req.ExceptionDates) > 0 {
		for _, dateStr := range req.ExceptionDates {
			_, err := time.Parse("2006-01-02", dateStr)
			if err != nil {
				return ierr.NewError("Exception dates must be in YYYY-MM-DD format").
					WithReportableDetails(map[string]any{
						"invalid_date": dateStr,
					}).
					Mark(ierr.ErrValidation)
			}
		}
	}

	return nil
}

// ApplyToOccurrence applies the update request to an existing occurrence
func (req *UpdateOccurrenceRequest) ApplyToOccurrence(ctx context.Context, occ *eventdomain.EventOccurrence) error {
	if req.RecurrenceType != nil {
		occ.RecurrenceType = *req.RecurrenceType
	}
	if req.StartTime != nil {
		occ.StartTime = req.StartTime
	}
	if req.EndTime != nil {
		occ.EndTime = req.EndTime
	}

	// Recalculate duration if both times are set
	if occ.StartTime != nil && occ.EndTime != nil {
		duration := int(occ.EndTime.Sub(*occ.StartTime).Minutes())
		occ.DurationMinutes = &duration
	}

	if req.DayOfWeek != nil {
		occ.DayOfWeek = req.DayOfWeek
	}
	if req.DayOfMonth != nil {
		occ.DayOfMonth = req.DayOfMonth
	}
	if req.MonthOfYear != nil {
		occ.MonthOfYear = req.MonthOfYear
	}
	if req.ExceptionDates != nil {
		occ.ExceptionDates = req.ExceptionDates
	}
	if req.Metadata != nil {
		md := make(types.Metadata)
		for k, v := range req.Metadata {
			if strVal, ok := v.(string); ok {
				md[k] = strVal
			}
		}
		occ.Metadata = &md
	}

	return nil
}

// OccurrenceResponse represents an occurrence in the response
type OccurrenceResponse struct {
	*eventdomain.EventOccurrence
}

// NewOccurrenceResponse creates an OccurrenceResponse from domain EventOccurrence
func NewOccurrenceResponse(occ *eventdomain.EventOccurrence) *OccurrenceResponse {
	return &OccurrenceResponse{
		EventOccurrence: occ,
	}
}

// ExpandedOccurrenceResponse represents a concrete expanded occurrence instance
type ExpandedOccurrenceResponse struct {
	*eventdomain.ExpandedOccurrence
}

// NewExpandedOccurrenceResponse creates an ExpandedOccurrenceResponse from domain ExpandedOccurrence
func NewExpandedOccurrenceResponse(expanded *eventdomain.ExpandedOccurrence) *ExpandedOccurrenceResponse {
	return &ExpandedOccurrenceResponse{
		ExpandedOccurrence: expanded,
	}
}
