package types

import (
	"fmt"

	"github.com/samber/lo"
)

type PlaceType string

const (
	PlaceTypeHotel      PlaceType = "hotel"
	PlaceTypeApartment  PlaceType = "apartment"
	PlaceTypeAttraction PlaceType = "attraction"
	PlaceTypeRestaurant PlaceType = "restaurant"
	PlaceTypeExperience PlaceType = "experience"
)

var PlaceTypes = []string{
	string(PlaceTypeHotel),
	string(PlaceTypeApartment),
	string(PlaceTypeAttraction),
	string(PlaceTypeRestaurant),
	string(PlaceTypeExperience),
}

type PlaceFilter struct {
	*QueryFilter
	*TimeRangeFilter

	// Custom filters
	Slug       []string `json:"slug,omitempty" form:"slug" validate:"omitempty"`
	PlaceTypes []string `json:"place_types,omitempty" form:"place_types" validate:"omitempty"`
	Categories []string `json:"categories,omitempty" form:"categories" validate:"omitempty"`
	Amenities  []string `json:"amenities,omitempty" form:"amenities" validate:"omitempty"`
	MinRating  *float64 `json:"min_rating,omitempty" form:"min_rating" validate:"omitempty,min=0,max=5"`
	MaxRating  *float64 `json:"max_rating,omitempty" form:"max_rating" validate:"omitempty,min=0,max=5"`
	Status     Status   `json:"status,omitempty" form:"status" validate:"omitempty"`

	// Geospatial filters
	Latitude  *float64 `json:"latitude,omitempty" form:"latitude" validate:"omitempty,latitude"`
	Longitude *float64 `json:"longitude,omitempty" form:"longitude" validate:"omitempty,longitude"`
	RadiusKM  *float64 `json:"radius_km,omitempty" form:"radius_km" validate:"omitempty,min=0"`

	// Search
	SearchQuery *string `json:"search_query,omitempty" form:"search_query" validate:"omitempty"`
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
				return fmt.Errorf("invalid place_type: %s", pt)
			}
		}
	}

	// Validate rating range
	if f.MinRating != nil && f.MaxRating != nil && *f.MinRating > *f.MaxRating {
		return fmt.Errorf("min_rating cannot be greater than max_rating")
	}

	// Validate geospatial filters
	if f.Latitude != nil || f.Longitude != nil || f.RadiusKM != nil {
		if f.Latitude == nil || f.Longitude == nil || f.RadiusKM == nil {
			return fmt.Errorf("latitude, longitude, and radius_km must all be provided for geospatial search")
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
