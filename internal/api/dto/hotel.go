package dto

import (
	"context"
	"time"

	"github.com/omkar273/nashikdarshan/internal/domain/hotel"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
	"github.com/shopspring/decimal"
)

// CreateHotelRequest represents a request to create a hotel
type CreateHotelRequest struct {
	Slug            string            `json:"slug" binding:"required,min=3,max=100"`
	Name            string            `json:"name" binding:"required,min=2,max=255"`
	Description     *string           `json:"description,omitempty" binding:"omitempty,max=5000"`
	StarRating      int               `json:"star_rating" binding:"required,min=1,max=5"`
	RoomCount       int               `json:"room_count" binding:"omitempty,min=0,max=10000"`
	CheckInTime     *time.Time        `json:"check_in_time,omitempty"`
	CheckOutTime    *time.Time        `json:"check_out_time,omitempty"`
	Address         map[string]string `json:"address,omitempty"`
	Location        types.Location    `json:"location" binding:"required"`
	Phone           *string           `json:"phone,omitempty" binding:"omitempty,min=10,max=20"`
	Email           *string           `json:"email,omitempty" binding:"omitempty,email,max=255"`
	Website         *string           `json:"website,omitempty" binding:"omitempty,url,max=500"`
	PrimaryImageURL *string           `json:"primary_image_url,omitempty" binding:"omitempty,url,max=500"`
	ThumbnailURL    *string           `json:"thumbnail_url,omitempty" binding:"omitempty,url,max=500"`
	PriceMin        *decimal.Decimal  `json:"price_min,omitempty"`
	PriceMax        *decimal.Decimal  `json:"price_max,omitempty"`
	Currency        *string           `json:"currency,omitempty" binding:"omitempty,len=3,uppercase"`
}

// Validate validates the CreateHotelRequest
func (req *CreateHotelRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate slug format (kebab-case: lowercase alphanumeric with hyphens)
	if err := validator.ValidateSlugFormat(req.Slug); err != nil {
		return err
	}

	// Validate location coordinates
	if err := req.Location.Validate(); err != nil {
		return err
	}

	// Validate price range
	if req.PriceMin != nil && req.PriceMax != nil {
		if req.PriceMin.GreaterThan(*req.PriceMax) {
			return ierr.NewError("price_min cannot be greater than price_max").
				WithHint("Please ensure price_min is less than or equal to price_max").
				Mark(ierr.ErrValidation)
		}
		// Validate price is not negative
		if req.PriceMin.LessThan(decimal.Zero) {
			return ierr.NewError("price_min cannot be negative").
				WithHint("Please provide a non-negative price value").
				Mark(ierr.ErrValidation)
		}
		if req.PriceMax.LessThan(decimal.Zero) {
			return ierr.NewError("price_max cannot be negative").
				WithHint("Please provide a non-negative price value").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate currency code (if provided)
	if req.Currency != nil && *req.Currency != "" {
		if err := validator.ValidateCurrencyCode(*req.Currency); err != nil {
			return err
		}
	}

	// Validate check-in/check-out times
	if req.CheckInTime != nil && req.CheckOutTime != nil {
		if !req.CheckOutTime.After(*req.CheckInTime) {
			return ierr.NewError("check_out_time must be after check_in_time").
				WithHint("Please ensure check-out time is later than check-in time").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// UpdateHotelRequest represents a request to update a hotel
// Note: Slug is immutable and cannot be updated
type UpdateHotelRequest struct {
	Name            *string           `json:"name,omitempty" binding:"omitempty,min=2,max=255"`
	Description     *string           `json:"description,omitempty" binding:"omitempty,max=5000"`
	StarRating      *int              `json:"star_rating,omitempty" binding:"omitempty,min=1,max=5"`
	RoomCount       *int              `json:"room_count,omitempty" binding:"omitempty,min=0,max=10000"`
	CheckInTime     *time.Time        `json:"check_in_time,omitempty"`
	CheckOutTime    *time.Time        `json:"check_out_time,omitempty"`
	Address         map[string]string `json:"address,omitempty"`
	Location        *types.Location   `json:"location,omitempty"`
	Phone           *string           `json:"phone,omitempty" binding:"omitempty,min=10,max=20"`
	Email           *string           `json:"email,omitempty" binding:"omitempty,email,max=255"`
	Website         *string           `json:"website,omitempty" binding:"omitempty,url,max=500"`
	PrimaryImageURL *string           `json:"primary_image_url,omitempty" binding:"omitempty,url,max=500"`
	ThumbnailURL    *string           `json:"thumbnail_url,omitempty" binding:"omitempty,url,max=500"`
	PriceMin        *decimal.Decimal  `json:"price_min,omitempty"`
	PriceMax        *decimal.Decimal  `json:"price_max,omitempty"`
	Currency        *string           `json:"currency,omitempty" binding:"omitempty,len=3,uppercase"`
}

// Validate validates the UpdateHotelRequest
func (req *UpdateHotelRequest) Validate() error {
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

	// Validate price range
	if req.PriceMin != nil && req.PriceMax != nil {
		if req.PriceMin.GreaterThan(*req.PriceMax) {
			return ierr.NewError("price_min cannot be greater than price_max").
				WithHint("Please ensure price_min is less than or equal to price_max").
				Mark(ierr.ErrValidation)
		}
		// Validate price is not negative
		if req.PriceMin.LessThan(decimal.Zero) {
			return ierr.NewError("price_min cannot be negative").
				WithHint("Please provide a non-negative price value").
				Mark(ierr.ErrValidation)
		}
		if req.PriceMax.LessThan(decimal.Zero) {
			return ierr.NewError("price_max cannot be negative").
				WithHint("Please provide a non-negative price value").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate currency code (if provided)
	if req.Currency != nil && *req.Currency != "" {
		if err := validator.ValidateCurrencyCode(*req.Currency); err != nil {
			return err
		}
	}

	// Validate check-in/check-out times
	if req.CheckInTime != nil && req.CheckOutTime != nil {
		if !req.CheckOutTime.After(*req.CheckInTime) {
			return ierr.NewError("check_out_time must be after check_in_time").
				WithHint("Please ensure check-out time is later than check-in time").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

// HotelResponse represents a hotel in the response
type HotelResponse struct {
	*hotel.Hotel
}

// ListHotelsResponse represents a paginated list of hotels
type ListHotelsResponse = types.ListResponse[*HotelResponse]

// NewHotelResponse creates a HotelResponse from domain Hotel
func NewHotelResponse(h *hotel.Hotel) *HotelResponse {
	return &HotelResponse{
		Hotel: h,
	}
}

// ToHotel converts CreateHotelRequest to domain Hotel
func (req *CreateHotelRequest) ToHotel(ctx context.Context) (*hotel.Hotel, error) {
	baseModel := types.GetDefaultBaseModel(ctx)

	return &hotel.Hotel{
		ID:              types.GenerateUUIDWithPrefix(types.UUID_PREFIX_HOTEL),
		Slug:            req.Slug,
		Name:            req.Name,
		Description:     req.Description,
		StarRating:      req.StarRating,
		RoomCount:       req.RoomCount,
		CheckInTime:     req.CheckInTime,
		CheckOutTime:    req.CheckOutTime,
		Address:         req.Address,
		Location:        req.Location,
		Phone:           req.Phone,
		Email:           req.Email,
		Website:         req.Website,
		PrimaryImageURL: req.PrimaryImageURL,
		ThumbnailURL:    req.ThumbnailURL,
		PriceMin:        req.PriceMin,
		PriceMax:        req.PriceMax,
		Currency:        req.Currency,
		BaseModel:       baseModel,
	}, nil
}

// ApplyToHotel applies UpdateHotelRequest to domain Hotel
// Note: Slug is immutable and cannot be updated
func (req *UpdateHotelRequest) ApplyToHotel(ctx context.Context, h *hotel.Hotel) error {
	if req.Name != nil {
		h.Name = *req.Name
	}
	if req.Description != nil {
		h.Description = req.Description
	}
	if req.StarRating != nil {
		h.StarRating = *req.StarRating
	}
	if req.RoomCount != nil {
		h.RoomCount = *req.RoomCount
	}
	if req.CheckInTime != nil {
		h.CheckInTime = req.CheckInTime
	}
	if req.CheckOutTime != nil {
		h.CheckOutTime = req.CheckOutTime
	}
	if req.Address != nil {
		h.Address = req.Address
	}
	if req.Location != nil {
		h.Location = *req.Location
	}
	if req.Phone != nil {
		h.Phone = req.Phone
	}
	if req.Email != nil {
		h.Email = req.Email
	}
	if req.Website != nil {
		h.Website = req.Website
	}
	if req.PrimaryImageURL != nil {
		h.PrimaryImageURL = req.PrimaryImageURL
	}
	if req.ThumbnailURL != nil {
		h.ThumbnailURL = req.ThumbnailURL
	}
	if req.PriceMin != nil {
		h.PriceMin = req.PriceMin
	}
	if req.PriceMax != nil {
		h.PriceMax = req.PriceMax
	}
	if req.Currency != nil {
		h.Currency = req.Currency
	}
	return nil
}

// NewListHotelsResponse creates a paginated list response for hotels
func NewListHotelsResponse(hotels []*hotel.Hotel, total, limit, offset int) *ListHotelsResponse {
	items := lo.Map(hotels, func(h *hotel.Hotel, _ int) *HotelResponse {
		return NewHotelResponse(h)
	})

	response := types.NewListResponse(items, total, limit, offset)
	return &response
}
