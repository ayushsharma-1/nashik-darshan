package dto

import (
	"context"
	"strings"
	"time"

	"github.com/omkar273/nashikdarshan/internal/domain/place"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
)

// Location represents a simple location format for frontend communication
// Uses industry standard latitude/longitude naming
type Location struct {
	Latitude  float64 `json:"latitude" binding:"required"`
	Longitude float64 `json:"longitude" binding:"required"`
}

// Validate validates the Location coordinates
func (l Location) Validate() error {
	point := types.Point{
		Latitude:  l.Latitude,
		Longitude: l.Longitude,
	}

	if !point.IsValid() {
		return ierr.NewError("invalid coordinates").
			WithHint("latitude must be between -90 and 90, longitude must be between -180 and 180").
			Mark(ierr.ErrValidation)
	}

	return nil
}

// ToWKT converts Location to WKT format for PostGIS
func (l Location) ToWKT() (string, error) {
	if err := l.Validate(); err != nil {
		return "", err
	}
	point := types.Point{
		Latitude:  l.Latitude,
		Longitude: l.Longitude,
	}
	return point.ToWKT(), nil
}

// LocationFromWKT creates a Location from WKT format
func (l *Location) FromWKT(wkt string) (*Location, error) {
	point, err := types.PointFromWKT(wkt)
	if err != nil {
		return nil, err
	}

	return &Location{
		Latitude:  point.Latitude,
		Longitude: point.Longitude,
	}, nil
}

// CreatePlaceRequest represents a request to create a place
type CreatePlaceRequest struct {
	Slug             string                 `json:"slug" binding:"required,min=1"`
	Title            string                 `json:"title" binding:"required,min=1"`
	Subtitle         *string                `json:"subtitle,omitempty"`
	ShortDescription *string                `json:"short_description,omitempty"`
	LongDescription  *string                `json:"long_description,omitempty"`
	PlaceType        string                 `json:"place_type" binding:"required"`
	Categories       []string               `json:"categories,omitempty"`
	Address          map[string]interface{} `json:"address,omitempty"`
	Location         Location               `json:"location" binding:"required"`
	PrimaryImageURL  *string                `json:"primary_image_url,omitempty"`
	ThumbnailURL     *string                `json:"thumbnail_url,omitempty"`
	Amenities        []string               `json:"amenities,omitempty"`
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

	// Validate slug format (alphanumeric, hyphens, underscores)
	slug := strings.TrimSpace(req.Slug)
	if slug == "" {
		return ierr.NewError("slug is required").
			WithHint("slug cannot be empty").
			Mark(ierr.ErrValidation)
	}

	// Validate URLs if provided
	if req.PrimaryImageURL != nil && *req.PrimaryImageURL != "" {
		if !strings.HasPrefix(*req.PrimaryImageURL, "http://") && !strings.HasPrefix(*req.PrimaryImageURL, "https://") {
			return ierr.NewError("invalid primary_image_url").
				WithHint("URL must start with http:// or https://").
				Mark(ierr.ErrValidation)
		}
	}

	if req.ThumbnailURL != nil && *req.ThumbnailURL != "" {
		if !strings.HasPrefix(*req.ThumbnailURL, "http://") && !strings.HasPrefix(*req.ThumbnailURL, "https://") {
			return ierr.NewError("invalid thumbnail_url").
				WithHint("URL must start with http:// or https://").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// UpdatePlaceRequest represents a request to update a place
type UpdatePlaceRequest struct {
	Slug             *string                `json:"slug,omitempty" binding:"omitempty,min=1"`
	Title            *string                `json:"title,omitempty" binding:"omitempty,min=1"`
	Subtitle         *string                `json:"subtitle,omitempty"`
	ShortDescription *string                `json:"short_description,omitempty"`
	LongDescription  *string                `json:"long_description,omitempty"`
	PlaceType        *string                `json:"place_type,omitempty"`
	Categories       []string               `json:"categories,omitempty"`
	Address          map[string]interface{} `json:"address,omitempty"`
	Location         *Location              `json:"location,omitempty"`
	PrimaryImageURL  *string                `json:"primary_image_url,omitempty"`
	ThumbnailURL     *string                `json:"thumbnail_url,omitempty"`
	Amenities        []string               `json:"amenities,omitempty"`
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

	// Validate slug format if provided
	if req.Slug != nil {
		slug := strings.TrimSpace(*req.Slug)
		if slug == "" {
			return ierr.NewError("slug cannot be empty").
				WithHint("slug must contain at least one non-whitespace character").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate URLs if provided
	if req.PrimaryImageURL != nil && *req.PrimaryImageURL != "" {
		if !strings.HasPrefix(*req.PrimaryImageURL, "http://") && !strings.HasPrefix(*req.PrimaryImageURL, "https://") {
			return ierr.NewError("invalid primary_image_url").
				WithHint("URL must start with http:// or https://").
				Mark(ierr.ErrValidation)
		}
	}

	if req.ThumbnailURL != nil && *req.ThumbnailURL != "" {
		if !strings.HasPrefix(*req.ThumbnailURL, "http://") && !strings.HasPrefix(*req.ThumbnailURL, "https://") {
			return ierr.NewError("invalid thumbnail_url").
				WithHint("URL must start with http:// or https://").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// PlaceResponse represents a place in the response
type PlaceResponse struct {
	ID               string                 `json:"id"`
	Slug             string                 `json:"slug"`
	Title            string                 `json:"title"`
	Subtitle         *string                `json:"subtitle,omitempty"`
	ShortDescription *string                `json:"short_description,omitempty"`
	LongDescription  *string                `json:"long_description,omitempty"`
	PlaceType        string                 `json:"place_type"`
	Categories       []string               `json:"categories,omitempty"`
	Address          map[string]interface{} `json:"address,omitempty"`
	Location         *Location              `json:"location,omitempty"`
	PrimaryImageURL  *string                `json:"primary_image_url,omitempty"`
	ThumbnailURL     *string                `json:"thumbnail_url,omitempty"`
	Amenities        []string               `json:"amenities,omitempty"`
	Status           string                 `json:"status"`
	CreatedAt        time.Time              `json:"created_at"`
	UpdatedAt        time.Time              `json:"updated_at"`
	CreatedBy        string                 `json:"created_by"`
	UpdatedBy        string                 `json:"updated_by"`
	Images           []*PlaceImageResponse  `json:"images,omitempty"`
}

// PlaceImageResponse represents a place image in the response
type PlaceImageResponse struct {
	*place.PlaceImage
}

// ListPlacesResponse represents a paginated list of places
type ListPlacesResponse = types.ListResponse[*PlaceResponse]

// NewPlaceResponse creates a PlaceResponse from domain Place
func NewPlaceResponse(p *place.Place) *PlaceResponse {
	resp := &PlaceResponse{
		ID:               p.ID,
		Slug:             p.Slug,
		Title:            p.Title,
		Subtitle:         p.Subtitle,
		ShortDescription: p.ShortDescription,
		LongDescription:  p.LongDescription,
		PlaceType:        p.PlaceType,
		Categories:       p.Categories,
		Address:          p.Address,
		PrimaryImageURL:  p.PrimaryImageURL,
		ThumbnailURL:     p.ThumbnailURL,
		Amenities:        p.Amenities,
		Status:           string(p.Status),
		CreatedAt:        p.CreatedAt,
		UpdatedAt:        p.UpdatedAt,
		CreatedBy:        p.CreatedBy,
		UpdatedBy:        p.UpdatedBy,
	}

	// Convert location from WKT to simple lat/lng format
	if p.Location != "" {
		location, err := (&Location{}).FromWKT(p.Location)
		if err != nil {
			return nil
		}
		resp.Location = location
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

	// Convert location to WKT format
	locationWKT, err := req.Location.ToWKT()
	if err != nil {
		return nil, err
	}

	return &place.Place{
		Slug:             req.Slug,
		Title:            req.Title,
		Subtitle:         req.Subtitle,
		ShortDescription: req.ShortDescription,
		LongDescription:  req.LongDescription,
		PlaceType:        req.PlaceType,
		Categories:       req.Categories,
		Address:          req.Address,
		Location:         locationWKT,
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
		locationWKT, err := req.Location.ToWKT()
		if err != nil {
			return err
		}
		p.Location = locationWKT
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
