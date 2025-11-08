package dto

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/domain/place"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
)

// Use domain Location type
type Location = place.Location

// CreatePlaceRequest represents a request to create a place
type CreatePlaceRequest struct {
	Slug             string            `json:"slug" binding:"required,min=1"`
	Title            string            `json:"title" binding:"required,min=1"`
	Subtitle         *string           `json:"subtitle,omitempty"`
	ShortDescription *string           `json:"short_description,omitempty"`
	LongDescription  *string           `json:"long_description,omitempty"`
	PlaceType        string            `json:"place_type" binding:"required"`
	Categories       []string          `json:"categories,omitempty"`
	Address          map[string]string `json:"address,omitempty"`
	Location         Location          `json:"location" binding:"required"`
	PrimaryImageURL  *string           `json:"primary_image_url,omitempty"`
	ThumbnailURL     *string           `json:"thumbnail_url,omitempty"`
	Amenities        []string          `json:"amenities,omitempty"`
}

// Validate validates the CreatePlaceRequest
func (req *CreatePlaceRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
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
	Slug             *string           `json:"slug,omitempty" binding:"omitempty,min=1"`
	Title            *string           `json:"title,omitempty" binding:"omitempty,min=1"`
	Subtitle         *string           `json:"subtitle,omitempty"`
	ShortDescription *string           `json:"short_description,omitempty"`
	LongDescription  *string           `json:"long_description,omitempty"`
	PlaceType        *string           `json:"place_type,omitempty"`
	Categories       []string          `json:"categories,omitempty"`
	Address          map[string]string `json:"address,omitempty"`
	Location         *Location         `json:"location,omitempty"`
	PrimaryImageURL  *string           `json:"primary_image_url,omitempty"`
	ThumbnailURL     *string           `json:"thumbnail_url,omitempty"`
	Amenities        []string          `json:"amenities,omitempty"`
}

// Validate validates the UpdatePlaceRequest
func (req *UpdatePlaceRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
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
	URL      string  `json:"url" binding:"required,url"`
	Alt      *string `json:"alt,omitempty"`
	Pos      int     `json:"pos" binding:"min=0"`
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
		Categories:       req.Categories,
		Address:          req.Address,
		Location:         req.Location,
		PrimaryImageURL:  req.PrimaryImageURL,
		ThumbnailURL:     req.ThumbnailURL,
		Amenities:        req.Amenities,
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
		p.PlaceType = *req.PlaceType
	}
	if req.Categories != nil {
		p.Categories = req.Categories
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
	if req.Amenities != nil {
		p.Amenities = req.Amenities
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
