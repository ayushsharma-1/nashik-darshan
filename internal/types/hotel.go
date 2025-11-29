package types

import (
	"time"

	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/shopspring/decimal"
)

type HotelFilter struct {
	*QueryFilter
	*TimeRangeFilter

	// Custom filters
	Slug       []string `json:"slug,omitempty" form:"slug" validate:"omitempty"`
	StarRating []int    `json:"star_rating,omitempty" form:"star_rating" validate:"omitempty"`

	// Price range filters
	MinPrice *decimal.Decimal `json:"min_price,omitempty" form:"min_price" validate:"omitempty"`
	MaxPrice *decimal.Decimal `json:"max_price,omitempty" form:"max_price" validate:"omitempty"`

	// Geospatial filters
	Latitude  *decimal.Decimal `json:"latitude,omitempty" form:"latitude" validate:"omitempty"`
	Longitude *decimal.Decimal `json:"longitude,omitempty" form:"longitude" validate:"omitempty"`
	RadiusM   *decimal.Decimal `json:"radius_m,omitempty" form:"radius_m" validate:"omitempty"` // radius in meters

	// Search
	SearchQuery *string `json:"search_query,omitempty" form:"search_query" validate:"omitempty"`

	// Trending filter
	LastViewedAfter *time.Time `json:"last_viewed_after,omitempty" form:"last_viewed_after" validate:"omitempty"`
}

func (f *HotelFilter) Validate() error {
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

	// Validate star ratings (must be between 1 and 5)
	if len(f.StarRating) > 0 {
		for _, rating := range f.StarRating {
			if rating < 1 || rating > 5 {
				return ierr.NewError("invalid star_rating").
					WithHint("star_rating must be between 1 and 5").
					WithReportableDetails(map[string]any{"star_rating": rating}).
					Mark(ierr.ErrValidation)
			}
		}
	}

	// Validate price range
	if f.MinPrice != nil && f.MaxPrice != nil {
		if f.MinPrice.GreaterThan(*f.MaxPrice) {
			return ierr.NewError("min_price cannot be greater than max_price").
				WithHint("Please ensure min_price is less than or equal to max_price").
				Mark(ierr.ErrValidation)
		}
	}
	if f.MinPrice != nil && f.MinPrice.LessThan(decimal.Zero) {
		return ierr.NewError("min_price cannot be negative").
			WithHint("Please provide a positive value for min_price").
			Mark(ierr.ErrValidation)
	}
	if f.MaxPrice != nil && f.MaxPrice.LessThan(decimal.Zero) {
		return ierr.NewError("max_price cannot be negative").
			WithHint("Please provide a positive value for max_price").
			Mark(ierr.ErrValidation)
	}

	// Validate geospatial filters
	if f.Latitude != nil || f.Longitude != nil || f.RadiusM != nil {
		if f.Latitude == nil || f.Longitude == nil || f.RadiusM == nil {
			return ierr.NewError("latitude, longitude, and radius_m must all be provided for geospatial search").
				WithHint("Please provide all three values: latitude, longitude, and radius_m").
				Mark(ierr.ErrValidation)
		}

		// Create location and validate coordinates
		location := NewLocation(*f.Latitude, *f.Longitude)
		if err := location.Validate(); err != nil {
			return err
		}
		// Cap radius at 15km (15000m)
		if f.RadiusM.GreaterThan(decimal.NewFromInt(15000)) {
			return ierr.NewError("radius_m cannot exceed 15000 meters (15km)").
				WithHint("Maximum allowed radius is 15km (15000 meters)").
				Mark(ierr.ErrValidation)
		}
		// Radius must be positive
		if f.RadiusM.LessThanOrEqual(decimal.Zero) {
			return ierr.NewError("radius_m must be greater than 0").
				WithHint("Please provide a positive value for radius_m").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

func NewHotelFilter() *HotelFilter {
	return &HotelFilter{
		QueryFilter:     NewDefaultQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

func NewNoLimitHotelFilter() *HotelFilter {
	return &HotelFilter{
		QueryFilter:     NewNoLimitQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

// GetLimit implements BaseFilter interface
func (f *HotelFilter) GetLimit() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetLimit()
	}
	return f.QueryFilter.GetLimit()
}

// GetOffset implements BaseFilter interface
func (f *HotelFilter) GetOffset() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOffset()
	}
	return f.QueryFilter.GetOffset()
}

// GetStatus implements BaseFilter interface
func (f *HotelFilter) GetStatus() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetStatus()
	}
	return f.QueryFilter.GetStatus()
}

// GetSort implements BaseFilter interface
func (f *HotelFilter) GetSort() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetSort()
	}
	return f.QueryFilter.GetSort()
}

// GetOrder implements BaseFilter interface
func (f *HotelFilter) GetOrder() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOrder()
	}
	return f.QueryFilter.GetOrder()
}

// GetExpand implements BaseFilter interface
func (f *HotelFilter) GetExpand() Expand {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetExpand()
	}
	return f.QueryFilter.GetExpand()
}

func (f *HotelFilter) IsUnlimited() bool {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().IsUnlimited()
	}
	return f.QueryFilter.IsUnlimited()
}
