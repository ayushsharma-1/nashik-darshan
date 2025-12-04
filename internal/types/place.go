package types

import (
	"time"

	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/samber/lo"
	"github.com/shopspring/decimal"
)

type PlaceType string

const (
	PlaceTypeTemple PlaceType = "temple"
)

var PlaceTypes = []string{
	string(PlaceTypeTemple),
}

// ValidateCoordinates validates latitude and longitude values
func ValidateCoordinates(latitude, longitude decimal.Decimal) error {
	// Validate latitude range (-90 to 90)
	if latitude.LessThan(decimal.NewFromInt(-90)) || latitude.GreaterThan(decimal.NewFromInt(90)) {
		return ierr.NewError("latitude must be between -90 and 90").
			WithHint("Please provide a valid latitude value").
			Mark(ierr.ErrValidation)
	}

	// Validate longitude range (-180 to 180)
	if longitude.LessThan(decimal.NewFromInt(-180)) || longitude.GreaterThan(decimal.NewFromInt(180)) {
		return ierr.NewError("longitude must be between -180 and 180").
			WithHint("Please provide a valid longitude value").
			Mark(ierr.ErrValidation)
	}

	return nil
}

type PlaceFilter struct {
	*QueryFilter
	*TimeRangeFilter

	// Custom filters
	Slug       []string `json:"slug,omitempty" form:"slug" validate:"omitempty"`
	PlaceTypes []string `json:"place_types,omitempty" form:"place_types" validate:"omitempty"`

	// Geospatial filters
	Latitude  *decimal.Decimal `json:"latitude,omitempty" form:"latitude" validate:"omitempty"`
	Longitude *decimal.Decimal `json:"longitude,omitempty" form:"longitude" validate:"omitempty"`
	RadiusM   *decimal.Decimal `json:"radius_m,omitempty" form:"radius_m" validate:"omitempty"` // radius in meters (cap: 10-15km for v1)

	// Search
	SearchQuery *string `json:"search_query,omitempty" form:"search_query" validate:"omitempty"`

	// Trending filter
	LastViewedAfter *time.Time `json:"last_viewed_after,omitempty" form:"last_viewed_after" validate:"omitempty"`
}

func (f *PlaceFilter) Validate() error {
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

	// Validate place types
	if len(f.PlaceTypes) > 0 {
		for _, pt := range f.PlaceTypes {
			if !lo.Contains(PlaceTypes, pt) {
				return ierr.NewError("invalid place_type").
					WithHint("valid place types are: hotel, apartment, attraction, restaurant, experience").
					WithReportableDetails(map[string]any{"place_type": pt}).
					Mark(ierr.ErrValidation)
			}
		}
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
		// Cap radius at 15km (15000m) for v1
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

func NewPlaceFilter() *PlaceFilter {
	return &PlaceFilter{
		QueryFilter:     NewDefaultQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

func NewNoLimitPlaceFilter() *PlaceFilter {
	return &PlaceFilter{
		QueryFilter:     NewNoLimitQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

// GetLimit implements BaseFilter interface
func (f *PlaceFilter) GetLimit() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetLimit()
	}
	return f.QueryFilter.GetLimit()
}

// GetOffset implements BaseFilter interface
func (f *PlaceFilter) GetOffset() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOffset()
	}
	return f.QueryFilter.GetOffset()
}

// GetStatus implements BaseFilter interface
func (f *PlaceFilter) GetStatus() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetStatus()
	}
	return f.QueryFilter.GetStatus()
}

// GetSort implements BaseFilter interface
func (f *PlaceFilter) GetSort() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetSort()
	}
	return f.QueryFilter.GetSort()
}

// GetOrder implements BaseFilter interface
func (f *PlaceFilter) GetOrder() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOrder()
	}
	return f.QueryFilter.GetOrder()
}

// GetExpand implements BaseFilter interface
func (f *PlaceFilter) GetExpand() Expand {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetExpand()
	}
	return f.QueryFilter.GetExpand()
}

func (f *PlaceFilter) IsUnlimited() bool {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().IsUnlimited()
	}
	return f.QueryFilter.IsUnlimited()
}

// FeedSectionType represents the type of feed section
type FeedSectionType string

const (
	SectionTypeLatest   FeedSectionType = "latest"
	SectionTypeTrending FeedSectionType = "trending"
	SectionTypePopular  FeedSectionType = "popular"
	SectionTypeNearby   FeedSectionType = "nearby"
)

// FeedSectionTypes contains all valid feed section types
var FeedSectionTypes = []string{
	string(SectionTypeLatest),
	string(SectionTypeTrending),
	string(SectionTypePopular),
	string(SectionTypeNearby),
}

func (f FeedSectionType) Validate() error {
	if !lo.Contains(FeedSectionTypes, string(f)) {
		return ierr.NewError("invalid section type").
			WithHintf("valid types are: latest, trending, popular, nearby").
			WithReportableDetails(map[string]any{"section_type": f}).
			Mark(ierr.ErrValidation)
	}
	return nil
}
