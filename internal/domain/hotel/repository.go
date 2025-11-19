package hotel

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

// Repository defines the interface for hotel persistence operations
type Repository interface {
	// Core operations
	Create(ctx context.Context, hotel *Hotel) error
	Get(ctx context.Context, id string) (*Hotel, error)
	GetBySlug(ctx context.Context, slug string) (*Hotel, error)
	Update(ctx context.Context, hotel *Hotel) error
	Delete(ctx context.Context, hotel *Hotel) error

	// List operations
	List(ctx context.Context, filter *types.HotelFilter) ([]*Hotel, error)
	ListAll(ctx context.Context, filter *types.HotelFilter) ([]*Hotel, error)
	Count(ctx context.Context, filter *types.HotelFilter) (int, error)

	// Engagement operations
	IncrementViewCount(ctx context.Context, hotelID string) error
	UpdateRating(ctx context.Context, hotelID string, newRating decimal.Decimal) error
	UpdatePopularityScore(ctx context.Context, hotelID string, score decimal.Decimal) error
}
