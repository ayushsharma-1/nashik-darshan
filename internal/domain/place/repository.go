package place

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/types"
)

// Repository defines the interface for place persistence operations
type Repository interface {
	// Core operations
	Create(ctx context.Context, place *Place) error
	Get(ctx context.Context, id string) (*Place, error)
	GetBySlug(ctx context.Context, slug string) (*Place, error)
	Update(ctx context.Context, place *Place) error
	Delete(ctx context.Context, place *Place) error

	// List operations
	List(ctx context.Context, filter *types.PlaceFilter) ([]*Place, error)
	ListAll(ctx context.Context, filter *types.PlaceFilter) ([]*Place, error)
	Count(ctx context.Context, filter *types.PlaceFilter) (int, error)

	// Image operations
	AddImage(ctx context.Context, image *PlaceImage) error
	GetImages(ctx context.Context, placeID string) ([]*PlaceImage, error)
	UpdateImage(ctx context.Context, image *PlaceImage) error
	DeleteImage(ctx context.Context, imageID string) error
}
