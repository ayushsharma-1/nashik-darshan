package itinerary

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/types"
)

// Repository defines the interface for itinerary data access
type Repository interface {
	// Itinerary CRUD
	Create(ctx context.Context, itinerary *Itinerary) error
	Get(ctx context.Context, id string) (*Itinerary, error)
	GetWithVisits(ctx context.Context, id string) (*Itinerary, error)
	List(ctx context.Context, filter *types.ItineraryFilter) ([]*Itinerary, error)
	Count(ctx context.Context, filter *types.ItineraryFilter) (int, error)
	Update(ctx context.Context, itinerary *Itinerary) error
	Delete(ctx context.Context, id string) error

	// Visit operations
	CreateVisits(ctx context.Context, visits []*Visit) error
	GetVisits(ctx context.Context, itineraryID string) ([]*Visit, error)
	UpdateVisit(ctx context.Context, visit *Visit) error
	DeleteVisit(ctx context.Context, id string) error
}
