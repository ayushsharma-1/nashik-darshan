package dto

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/domain/place"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
	"github.com/shopspring/decimal"
)

// CreatePlaceRequest represents a request to create a place
type CreatePlaceRequest struct {
	Slug             string            `json:"slug" binding:"required,min=3,max=100"`
	Title            string            `json:"title" binding:"required,min=2,max=255"`
	Subtitle         *string           `json:"subtitle,omitempty" binding:"omitempty,max=500"`
	ShortDescription *string           `json:"short_description,omitempty" binding:"omitempty,max=1000"`
	LongDescription  *string           `json:"long_description,omitempty" binding:"omitempty,max=10000"`
	PlaceType        types.PlaceType   `json:"place_type" binding:"required,min=2,max=50"`
	Address          map[string]string `json:"address,omitempty"`
	Location         types.Location    `json:"location" binding:"required"`
	PrimaryImageURL  *string           `json:"primary_image_url,omitempty" binding:"omitempty,url,max=500"`
	ThumbnailURL     *string           `json:"thumbnail_url,omitempty" binding:"omitempty,url,max=500"`
}

// Validate validates the CreatePlaceRequest
func (req *CreatePlaceRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate slug format (kebab-case)
	if err := validator.ValidateSlugFormat(req.Slug); err != nil {
		return err
	}

	// Validate location coordinates
	if err := req.Location.Validate(); err != nil {
		return err
	}

	return nil
}

// UpdatePlaceRequest represents a request to update a place
type UpdatePlaceRequest struct {
	Slug             *string           `json:"slug,omitempty" binding:"omitempty,min=3,max=100"`
	Title            *string           `json:"title,omitempty" binding:"omitempty,min=2,max=255"`
	Subtitle         *string           `json:"subtitle,omitempty" binding:"omitempty,max=500"`
	ShortDescription *string           `json:"short_description,omitempty" binding:"omitempty,max=1000"`
	LongDescription  *string           `json:"long_description,omitempty" binding:"omitempty,max=10000"`
	PlaceType        *string           `json:"place_type,omitempty" binding:"omitempty,min=2,max=50"`
	Address          map[string]string `json:"address,omitempty"`
	Location         *types.Location   `json:"location,omitempty"`
	PrimaryImageURL  *string           `json:"primary_image_url,omitempty" binding:"omitempty,url,max=500"`
	ThumbnailURL     *string           `json:"thumbnail_url,omitempty" binding:"omitempty,url,max=500"`
}

// Validate validates the UpdatePlaceRequest
func (req *UpdatePlaceRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate slug format if provided
	if req.Slug != nil && *req.Slug != "" {
		if err := validator.ValidateSlugFormat(*req.Slug); err != nil {
			return err
		}
	}

	// Validate location coordinates if provided
	if req.Location != nil {
		if err := req.Location.Validate(); err != nil {
			return err
		}
	}

	return nil
}

// PlaceResponse represents a place in the response
type PlaceResponse struct {
	*place.Place
	Images []*PlaceImageResponse `json:"images,omitempty"`
}

// PlaceImageResponse represents a place image in the response
type PlaceImageResponse struct {
	*place.PlaceImage
}

// CreatePlaceImageRequest represents a request to create a place image
type CreatePlaceImageRequest struct {
	URL      string  `json:"url" binding:"required,url,max=500"`
	Alt      *string `json:"alt,omitempty" binding:"omitempty,max=255"`
	Pos      int     `json:"pos" binding:"min=0,max=100"`
	Metadata *types.Metadata
}

// Validate validates the CreatePlaceImageRequest
func (req *CreatePlaceImageRequest) Validate() error {
	return validator.ValidateRequest(req)
}

// ToPlaceImage converts CreatePlaceImageRequest to domain PlaceImage
func (req *CreatePlaceImageRequest) ToPlaceImage(ctx context.Context, placeID string) *place.PlaceImage {
	baseModel := types.GetDefaultBaseModel(ctx)

	image := &place.PlaceImage{
		ID:        types.GenerateUUIDWithPrefix(types.UUID_PREFIX_PLACE_IMAGE),
		PlaceID:   placeID,
		URL:       req.URL,
		Pos:       req.Pos,
		BaseModel: baseModel,
	}

	if req.Alt != nil {
		image.Alt = *req.Alt
	}
	if req.Metadata != nil {
		image.Metadata = req.Metadata
	}

	return image
}

// UpdatePlaceImageRequest represents a request to update a place image
type UpdatePlaceImageRequest struct {
	URL      *string         `json:"url,omitempty" binding:"omitempty,url"`
	Alt      *string         `json:"alt,omitempty"`
	Pos      *int            `json:"pos,omitempty" binding:"omitempty,min=0"`
	Metadata *types.Metadata `json:"metadata,omitempty"`
}

// Validate validates the UpdatePlaceImageRequest
func (req *UpdatePlaceImageRequest) Validate() error {
	return validator.ValidateRequest(req)
}

// ApplyToPlaceImage applies UpdatePlaceImageRequest to domain PlaceImage
func (req *UpdatePlaceImageRequest) ApplyToPlaceImage(ctx context.Context, image *place.PlaceImage) {
	if req.URL != nil {
		image.URL = *req.URL
	}
	if req.Alt != nil {
		image.Alt = *req.Alt
	}
	if req.Pos != nil {
		image.Pos = *req.Pos
	}
	if req.Metadata != nil {
		image.Metadata = req.Metadata
	}
}

// AssignCategoriesRequest represents a request to assign categories to a place
type AssignCategoriesRequest struct {
	CategoryIDs []string `json:"category_ids" binding:"required,min=0"`
}

// Validate validates the AssignCategoriesRequest
func (req *AssignCategoriesRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	for _, id := range req.CategoryIDs {
		if id == "" {
			return ierr.NewError("category ID is required").
				WithHint("Please provide a valid category ID").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// ListPlacesResponse represents a paginated list of places
type ListPlacesResponse = types.ListResponse[*PlaceResponse]

// NewPlaceResponse creates a PlaceResponse from domain Place
func NewPlaceResponse(p *place.Place) *PlaceResponse {
	resp := &PlaceResponse{
		Place: p,
	}

	// Convert images using lo.Map
	if len(p.Images) > 0 {
		resp.Images = lo.Map(p.Images, func(img *place.PlaceImage, _ int) *PlaceImageResponse {
			return &PlaceImageResponse{PlaceImage: img}
		})
	}

	return resp
}

// ToPlace converts CreatePlaceRequest to domain Place
func (req *CreatePlaceRequest) ToPlace(ctx context.Context) (*place.Place, error) {
	baseModel := types.GetDefaultBaseModel(ctx)

	return &place.Place{
		ID:               types.GenerateUUIDWithPrefix(types.UUID_PREFIX_PLACE),
		Slug:             req.Slug,
		Title:            req.Title,
		Subtitle:         req.Subtitle,
		ShortDescription: req.ShortDescription,
		LongDescription:  req.LongDescription,
		PlaceType:        req.PlaceType,
		Address:          req.Address,
		Location:         req.Location,
		PrimaryImageURL:  req.PrimaryImageURL,
		ThumbnailURL:     req.ThumbnailURL,
		BaseModel:        baseModel,
	}, nil
}

// ApplyToPlace applies UpdatePlaceRequest to domain Place
func (req *UpdatePlaceRequest) ApplyToPlace(ctx context.Context, p *place.Place) error {
	if req.Slug != nil {
		p.Slug = *req.Slug
	}
	if req.Title != nil {
		p.Title = *req.Title
	}
	if req.Subtitle != nil {
		p.Subtitle = req.Subtitle
	}
	if req.ShortDescription != nil {
		p.ShortDescription = req.ShortDescription
	}
	if req.LongDescription != nil {
		p.LongDescription = req.LongDescription
	}
	if req.PlaceType != nil {
		p.PlaceType = types.PlaceType(*req.PlaceType)
	}
	if req.Address != nil {
		p.Address = req.Address
	}
	if req.Location != nil {
		p.Location = *req.Location
	}
	if req.PrimaryImageURL != nil {
		p.PrimaryImageURL = req.PrimaryImageURL
	}
	if req.ThumbnailURL != nil {
		p.ThumbnailURL = req.ThumbnailURL
	}
	p.UpdatedBy = types.GetUserID(ctx)
	return nil
}

// NewListPlacesResponse creates a paginated list response for places
func NewListPlacesResponse(places []*place.Place, total, limit, offset int) *ListPlacesResponse {
	items := lo.Map(places, func(p *place.Place, _ int) *PlaceResponse {
		return NewPlaceResponse(p)
	})

	response := types.NewListResponse(items, total, limit, offset)
	return &response
}

// FeedSectionRequest represents a single section request in the feed
type FeedSectionRequest struct {
	Type types.FeedSectionType `json:"type" binding:"required" validate:"required"`

	// Section-specific filters (override global filters if provided)
	*types.QueryFilter     `json:",inline,omitempty"`
	*types.TimeRangeFilter `json:",inline,omitempty"`

	// Geospatial fields (for nearby section)
	Latitude  *decimal.Decimal `json:"latitude,omitempty" validate:"omitempty"`
	Longitude *decimal.Decimal `json:"longitude,omitempty" validate:"omitempty"`
	RadiusKm  *decimal.Decimal `json:"radius_km,omitempty" validate:"omitempty,min=0.1,max=50" default:"5"`
}

// FeedRequest represents the main feed request
type FeedRequest struct {
	Sections []FeedSectionRequest `json:"sections" binding:"required,min=1,max=10" validate:"required,min=1,max=10,dive"`

	// Global filters (applied to all sections unless overridden)
	*types.QueryFilter     `json:",inline,omitempty"`
	*types.TimeRangeFilter `json:",inline,omitempty"`
}

// FeedSectionResponse represents a single section response in the feed
type FeedSectionResponse struct {
	Type       types.FeedSectionType    `json:"type"`
	Items      []*PlaceResponse         `json:"items"`
	Pagination types.PaginationResponse `json:"pagination"`
}

// FeedResponse represents the main feed response
type FeedResponse struct {
	Sections []FeedSectionResponse `json:"sections"`
}

// Validate validates the FeedRequest
func (req *FeedRequest) Validate() error {
	// Validate global filters
	if req.QueryFilter != nil {
		if err := req.QueryFilter.Validate(); err != nil {
			return err
		}
	}
	if req.TimeRangeFilter != nil {
		if err := req.TimeRangeFilter.Validate(); err != nil {
			return err
		}
	}

	// Validate each section
	for _, section := range req.Sections {
		if err := section.Validate(); err != nil {
			return err
		}
	}
	return nil
}

// Validate validates a single FeedSectionRequest
func (req *FeedSectionRequest) Validate() error {
	// Validate section type
	if err := req.Type.Validate(); err != nil {
		return err
	}

	// Validate section-specific filters
	if req.QueryFilter != nil {
		if err := req.QueryFilter.Validate(); err != nil {
			return err
		}
	}
	if req.TimeRangeFilter != nil {
		if err := req.TimeRangeFilter.Validate(); err != nil {
			return err
		}
	}

	// Validate geospatial fields for nearby section
	if req.Type == types.SectionTypeNearby {
		if req.Latitude == nil || req.Longitude == nil {
			return ierr.NewError("latitude and longitude are required for nearby section").
				WithHint("Please provide both latitude and longitude for nearby section").
				Mark(ierr.ErrValidation)
		}

		// Create location and validate coordinates
		location := types.NewLocation(*req.Latitude, *req.Longitude)
		if err := location.Validate(); err != nil {
			return err
		}

		// Validate radius if provided
		if req.RadiusKm != nil {
			if req.RadiusKm.LessThanOrEqual(decimal.Zero) {
				return ierr.NewError("radius_km must be greater than 0").
					WithHint("Please provide a positive radius value").
					Mark(ierr.ErrValidation)
			}
			if req.RadiusKm.GreaterThan(decimal.NewFromInt(50)) {
				return ierr.NewError("radius_km cannot exceed 50 kilometers").
					WithHint("Please provide a radius value within 50km limit").
					Mark(ierr.ErrValidation)
			}
		}
	}

	return nil
}

// ToPlaceFilter converts a FeedSectionRequest to a PlaceFilter, merging with global filters
func (req *FeedSectionRequest) ToPlaceFilter(globalFilter *FeedRequest) *types.PlaceFilter {
	filter := types.NewPlaceFilter()

	// Start with global filters if provided
	if globalFilter != nil {
		if globalFilter.QueryFilter != nil {
			filter.QueryFilter = globalFilter.QueryFilter
		}
		if globalFilter.TimeRangeFilter != nil {
			filter.TimeRangeFilter = globalFilter.TimeRangeFilter
		}
	}

	// Override with section-specific filters if provided
	if req.QueryFilter != nil {
		if filter.QueryFilter == nil {
			filter.QueryFilter = req.QueryFilter
		} else {
			// Merge section filters into global filters
			filter.QueryFilter.Merge(*req.QueryFilter)
		}
	}
	if req.TimeRangeFilter != nil {
		filter.TimeRangeFilter = req.TimeRangeFilter
	}

	// Ensure we have default query filter if none provided
	if filter.QueryFilter == nil {
		filter.QueryFilter = types.NewDefaultQueryFilter()
	}

	// Configure default sorting based on section type (can be overridden by filters)
	if filter.QueryFilter.Sort == nil || filter.QueryFilter.Order == nil {
		switch req.Type {
		case types.SectionTypeLatest:
			if filter.QueryFilter.Sort == nil {
				sort := "created_at"
				filter.QueryFilter.Sort = &sort
			}
			if filter.QueryFilter.Order == nil {
				order := "desc"
				filter.QueryFilter.Order = &order
			}

		case types.SectionTypeTrending, types.SectionTypePopular:
			if filter.QueryFilter.Sort == nil {
				sort := "popularity_score"
				filter.QueryFilter.Sort = &sort
			}
			if filter.QueryFilter.Order == nil {
				order := "desc"
				filter.QueryFilter.Order = &order
			}

		case types.SectionTypeNearby:
			// For nearby, we still want popularity sorting within the geographic area
			if filter.QueryFilter.Sort == nil {
				sort := "popularity_score"
				filter.QueryFilter.Sort = &sort
			}
			if filter.QueryFilter.Order == nil {
				order := "desc"
				filter.QueryFilter.Order = &order
			}
		}
	}

	// Handle geospatial fields for nearby section
	if req.Type == types.SectionTypeNearby && req.Latitude != nil && req.Longitude != nil {
		filter.Latitude = req.Latitude
		filter.Longitude = req.Longitude

		// Set default radius if not provided (5km)
		if req.RadiusKm != nil {
			radiusM := req.RadiusKm.Mul(decimal.NewFromInt(1000)) // Convert km to meters
			filter.RadiusM = &radiusM
		} else {
			defaultRadiusM := decimal.NewFromInt(5000) // 5km default
			filter.RadiusM = &defaultRadiusM
		}
	}

	return filter
}

// NewFeedResponse creates a new FeedResponse
func NewFeedResponse(sections []FeedSectionResponse) *FeedResponse {
	return &FeedResponse{
		Sections: sections,
	}
}

// NewFeedSectionResponse creates a new FeedSectionResponse
func NewFeedSectionResponse(sectionType types.FeedSectionType, places []*PlaceResponse, total, limit, offset int) FeedSectionResponse {
	return FeedSectionResponse{
		Type:       sectionType,
		Items:      places,
		Pagination: types.NewPaginationResponse(total, limit, offset),
	}
}

// NewFeedSectionResponseFromDomain creates a FeedSectionResponse from domain places
func NewFeedSectionResponseFromDomain(sectionType types.FeedSectionType, places []*place.Place, total, limit, offset int) FeedSectionResponse {
	// Convert domain places to DTOs
	placeResponses := make([]*PlaceResponse, len(places))
	for i, p := range places {
		placeResponses[i] = NewPlaceResponse(p)
	}

	return NewFeedSectionResponse(sectionType, placeResponses, total, limit, offset)
}
