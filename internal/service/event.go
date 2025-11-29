package service

import (
	"context"
	"time"

	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type EventService interface {
	// Event operations
	Create(ctx context.Context, req *dto.CreateEventRequest) (*dto.EventResponse, error)
	Get(ctx context.Context, id string) (*dto.EventResponse, error)
	GetBySlug(ctx context.Context, slug string) (*dto.EventResponse, error)
	Update(ctx context.Context, id string, req *dto.UpdateEventRequest) (*dto.EventResponse, error)
	Delete(ctx context.Context, id string) error
	List(ctx context.Context, filter *types.EventFilter) (*dto.ListEventsResponse, error)

	// Occurrence operations
	CreateOccurrence(ctx context.Context, req *dto.CreateOccurrenceRequest) (*dto.OccurrenceResponse, error)
	GetOccurrence(ctx context.Context, id string) (*dto.OccurrenceResponse, error)
	UpdateOccurrence(ctx context.Context, id string, req *dto.UpdateOccurrenceRequest) (*dto.OccurrenceResponse, error)
	DeleteOccurrence(ctx context.Context, id string) error
	ListOccurrences(ctx context.Context, eventID string) ([]*dto.OccurrenceResponse, error)

	// Stats
	IncrementView(ctx context.Context, id string) error
	IncrementInterested(ctx context.Context, id string) error
}

type eventService struct {
	ServiceParams
	timezone *time.Location
}

// NewEventService creates a new event service
func NewEventService(params ServiceParams) EventService {
	// Load IST timezone (Asia/Kolkata)
	ist, err := time.LoadLocation("Asia/Kolkata")
	if err != nil {
		// Fallback to UTC+5:30 if timezone database not available
		ist = time.FixedZone("IST", 5*60*60+30*60)
	}

	return &eventService{
		ServiceParams: params,
		timezone:      ist,
	}
}

// Create creates a new event
func (s *eventService) Create(ctx context.Context, req *dto.CreateEventRequest) (*dto.EventResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	event, err := req.ToEvent(ctx)
	if err != nil {
		return nil, err
	}

	err = s.EventRepo.Create(ctx, event)
	if err != nil {
		return nil, err
	}

	return dto.NewEventResponse(event), nil
}

// Get retrieves an event by ID
func (s *eventService) Get(ctx context.Context, id string) (*dto.EventResponse, error) {
	event, err := s.EventRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewEventResponse(event), nil
}

// GetBySlug retrieves an event by slug
func (s *eventService) GetBySlug(ctx context.Context, slug string) (*dto.EventResponse, error) {
	event, err := s.EventRepo.GetBySlug(ctx, slug)
	if err != nil {
		return nil, err
	}

	return dto.NewEventResponse(event), nil
}

// Update updates an existing event
func (s *eventService) Update(ctx context.Context, id string, req *dto.UpdateEventRequest) (*dto.EventResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	event, err := s.EventRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	err = req.ApplyToEvent(ctx, event)
	if err != nil {
		return nil, err
	}

	err = s.EventRepo.Update(ctx, event)
	if err != nil {
		return nil, err
	}

	return dto.NewEventResponse(event), nil
}

// Delete soft deletes an event
func (s *eventService) Delete(ctx context.Context, id string) error {
	event, err := s.EventRepo.Get(ctx, id)
	if err != nil {
		return err
	}

	// Only allow deleting published events
	if event.Status != types.StatusPublished {
		return ierr.NewError("Can only delete events with published status").
			WithReportableDetails(map[string]any{
				"event_id": id,
				"status":   event.Status,
			}).
			Mark(ierr.ErrValidation)
	}

	return s.EventRepo.Delete(ctx, id)
}

// List retrieves a paginated list of events
func (s *eventService) List(ctx context.Context, filter *types.EventFilter) (*dto.ListEventsResponse, error) {
	if filter == nil {
		filter = types.NewEventFilter()
	}

	events, err := s.EventRepo.List(ctx, filter)
	if err != nil {
		return nil, err
	}

	total, err := s.EventRepo.Count(ctx, filter)
	if err != nil {
		return nil, err
	}

	limit := filter.GetLimit()
	offset := filter.GetOffset()
	response := dto.NewListEventsResponse(events, total, limit, offset)

	return response, nil
}

// CreateOccurrence creates a new occurrence for an event
func (s *eventService) CreateOccurrence(ctx context.Context, req *dto.CreateOccurrenceRequest) (*dto.OccurrenceResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	// Verify event exists
	_, err := s.EventRepo.Get(ctx, req.EventID)
	if err != nil {
		return nil, err
	}

	occurrence, err := req.ToOccurrence(ctx)
	if err != nil {
		return nil, err
	}

	err = s.EventRepo.CreateOccurrence(ctx, occurrence)
	if err != nil {
		return nil, err
	}

	return dto.NewOccurrenceResponse(occurrence), nil
}

// GetOccurrence retrieves an occurrence by ID
func (s *eventService) GetOccurrence(ctx context.Context, id string) (*dto.OccurrenceResponse, error) {
	occurrence, err := s.EventRepo.GetOccurrence(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewOccurrenceResponse(occurrence), nil
}

// UpdateOccurrence updates an existing occurrence
func (s *eventService) UpdateOccurrence(ctx context.Context, id string, req *dto.UpdateOccurrenceRequest) (*dto.OccurrenceResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	occurrence, err := s.EventRepo.GetOccurrence(ctx, id)
	if err != nil {
		return nil, err
	}

	err = req.ApplyToOccurrence(ctx, occurrence)
	if err != nil {
		return nil, err
	}

	err = s.EventRepo.UpdateOccurrence(ctx, occurrence)
	if err != nil {
		return nil, err
	}

	return dto.NewOccurrenceResponse(occurrence), nil
}

// DeleteOccurrence soft deletes an occurrence
func (s *eventService) DeleteOccurrence(ctx context.Context, id string) error {
	_, err := s.EventRepo.GetOccurrence(ctx, id)
	if err != nil {
		return err
	}

	return s.EventRepo.DeleteOccurrence(ctx, id)
}

// ListOccurrences lists all occurrences for an event
func (s *eventService) ListOccurrences(ctx context.Context, eventID string) ([]*dto.OccurrenceResponse, error) {
	occurrences, err := s.EventRepo.ListOccurrencesByEvent(ctx, eventID)
	if err != nil {
		return nil, err
	}

	responses := make([]*dto.OccurrenceResponse, len(occurrences))
	for i, occ := range occurrences {
		responses[i] = dto.NewOccurrenceResponse(occ)
	}

	return responses, nil
}

// IncrementView increments the view count
func (s *eventService) IncrementView(ctx context.Context, id string) error {
	return s.EventRepo.IncrementViewCount(ctx, id)
}

// IncrementInterested increments the interested count
func (s *eventService) IncrementInterested(ctx context.Context, id string) error {
	return s.EventRepo.IncrementInterestedCount(ctx, id)
}
