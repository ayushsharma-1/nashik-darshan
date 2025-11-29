package event

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/types"
)

// Repository defines the interface for event operations
type Repository interface {
	// Event CRUD
	Create(ctx context.Context, event *Event) error
	Get(ctx context.Context, id string) (*Event, error)
	GetBySlug(ctx context.Context, slug string) (*Event, error)
	List(ctx context.Context, filter *types.EventFilter) ([]*Event, error)
	Count(ctx context.Context, filter *types.EventFilter) (int, error)
	Update(ctx context.Context, event *Event) error
	Delete(ctx context.Context, id string) error

	// EventOccurrence CRUD
	CreateOccurrence(ctx context.Context, occurrence *EventOccurrence) error
	GetOccurrence(ctx context.Context, id string) (*EventOccurrence, error)
	ListOccurrences(ctx context.Context, filter *types.OccurrenceFilter) ([]*EventOccurrence, error)
	ListOccurrencesByEvent(ctx context.Context, eventID string) ([]*EventOccurrence, error) // Deprecated: Use ListOccurrences with filter
	UpdateOccurrence(ctx context.Context, occurrence *EventOccurrence) error
	DeleteOccurrence(ctx context.Context, id string) error

	// Stats
	IncrementViewCount(ctx context.Context, id string) error
	IncrementInterestedCount(ctx context.Context, id string) error
}
