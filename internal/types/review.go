package types

import (
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/samber/lo"
)

// ReviewEntityType represents the type of entity that can be reviewed
type ReviewEntityType string

const (
	EntityTypePlace      ReviewEntityType = "place"
	EntityTypeHotel      ReviewEntityType = "hotel"
	EntityTypeRestaurant ReviewEntityType = "restaurant"
	EntityTypeEvent      ReviewEntityType = "event"
	EntityTypeExperience ReviewEntityType = "experience"
	EntityTypeAttraction ReviewEntityType = "attraction"
)

// ReviewEntityTypes contains all valid review entity types
var ReviewEntityTypes = []string{
	string(EntityTypePlace),
	string(EntityTypeHotel),
	string(EntityTypeRestaurant),
	string(EntityTypeEvent),
	string(EntityTypeExperience),
	string(EntityTypeAttraction),
}

// Validate validates the ReviewEntityType
func (e ReviewEntityType) Validate() error {
	if !lo.Contains(ReviewEntityTypes, string(e)) {
		return ierr.NewError("invalid entity type").
			WithHintf("valid types are: place, hotel, restaurant, event, experience, attraction").
			WithReportableDetails(map[string]any{"entity_type": e}).
			Mark(ierr.ErrValidation)
	}
	return nil
}

// ReviewFilter represents filters for querying reviews
type ReviewFilter struct {
	*QueryFilter
	*TimeRangeFilter

	// Entity filters
	EntityType ReviewEntityType `json:"entity_type,omitempty" form:"entity_type" validate:"omitempty"`
	EntityID   *string          `json:"entity_id,omitempty" form:"entity_id" validate:"omitempty"`

	// User filters
	UserID *string `json:"user_id,omitempty" form:"user_id" validate:"omitempty"`

	// Rating filters
	MinRating *float64 `json:"min_rating,omitempty" form:"min_rating" validate:"omitempty,min=1,max=5"`
	MaxRating *float64 `json:"max_rating,omitempty" form:"max_rating" validate:"omitempty,min=1,max=5"`

	// Content filters
	Tags            []string `json:"tags,omitempty" form:"tags" validate:"omitempty"`
	HasImages       *bool    `json:"has_images,omitempty" form:"has_images" validate:"omitempty"`
	HasContent      *bool    `json:"has_content,omitempty" form:"has_content" validate:"omitempty"`
	IsVerified      *bool    `json:"is_verified,omitempty" form:"is_verified" validate:"omitempty"`
	IsFeatured      *bool    `json:"is_featured,omitempty" form:"is_featured" validate:"omitempty"`
	MinHelpfulVotes *int     `json:"min_helpful_votes,omitempty" form:"min_helpful_votes" validate:"omitempty,min=0"`
}

// Validate validates the ReviewFilter
func (f *ReviewFilter) Validate() error {
	if f.QueryFilter != nil {
		if err := f.QueryFilter.Validate(); err != nil {
			return err
		}
	}

	if f.TimeRangeFilter != nil {
		if err := f.TimeRangeFilter.Validate(); err != nil {
			return err
		}
	}

	// Validate entity type if provided
	if f.EntityType != "" {
		if err := f.EntityType.Validate(); err != nil {
			return err
		}
	}

	// Validate rating range
	if f.MinRating != nil && f.MaxRating != nil {
		if *f.MinRating > *f.MaxRating {
			return ierr.NewError("min_rating cannot be greater than max_rating").
				WithHint("Please provide a valid rating range").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// NewReviewFilter creates a new ReviewFilter with default values
func NewReviewFilter() *ReviewFilter {
	return &ReviewFilter{
		QueryFilter:     NewDefaultQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

// GetLimit implements BaseFilter interface
func (f *ReviewFilter) GetLimit() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetLimit()
	}
	return f.QueryFilter.GetLimit()
}

// GetOffset implements BaseFilter interface
func (f *ReviewFilter) GetOffset() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOffset()
	}
	return f.QueryFilter.GetOffset()
}

// GetStatus implements BaseFilter interface
func (f *ReviewFilter) GetStatus() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetStatus()
	}
	return f.QueryFilter.GetStatus()
}

// GetSort implements BaseFilter interface
func (f *ReviewFilter) GetSort() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetSort()
	}
	return f.QueryFilter.GetSort()
}

// GetOrder implements BaseFilter interface
func (f *ReviewFilter) GetOrder() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOrder()
	}
	return f.QueryFilter.GetOrder()
}

// GetExpand implements BaseFilter interface
func (f *ReviewFilter) GetExpand() Expand {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetExpand()
	}
	return f.QueryFilter.GetExpand()
}

// IsUnlimited returns true if this is an unlimited query
func (f *ReviewFilter) IsUnlimited() bool {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().IsUnlimited()
	}
	return f.QueryFilter.IsUnlimited()
}
