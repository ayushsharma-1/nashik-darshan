package service

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/api/dto"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type HotelService interface {
	// Core operations
	Create(ctx context.Context, req *dto.CreateHotelRequest) (*dto.HotelResponse, error)
	Get(ctx context.Context, id string) (*dto.HotelResponse, error)
	GetBySlug(ctx context.Context, slug string) (*dto.HotelResponse, error)
	Update(ctx context.Context, id string, req *dto.UpdateHotelRequest) (*dto.HotelResponse, error)
	Delete(ctx context.Context, id string) error

	// List operations
	List(ctx context.Context, filter *types.HotelFilter) (*dto.ListHotelsResponse, error)
}

type hotelService struct {
	ServiceParams
}

// NewHotelService creates a new hotel service
func NewHotelService(params ServiceParams) HotelService {
	return &hotelService{
		ServiceParams: params,
	}
}

// Create creates a new hotel
func (s *hotelService) Create(ctx context.Context, req *dto.CreateHotelRequest) (*dto.HotelResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	h, err := req.ToHotel(ctx)
	if err != nil {
		return nil, err
	}

	err = s.HotelRepo.Create(ctx, h)
	if err != nil {
		return nil, err
	}

	// Return the created hotel directly (avoid read-after-write consistency issues)
	return dto.NewHotelResponse(h), nil
}

// Get retrieves a hotel by ID
func (s *hotelService) Get(ctx context.Context, id string) (*dto.HotelResponse, error) {
	h, err := s.HotelRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewHotelResponse(h), nil
}

// GetBySlug retrieves a hotel by slug
func (s *hotelService) GetBySlug(ctx context.Context, slug string) (*dto.HotelResponse, error) {
	h, err := s.HotelRepo.GetBySlug(ctx, slug)
	if err != nil {
		return nil, err
	}

	return dto.NewHotelResponse(h), nil
}

// Update updates an existing hotel
func (s *hotelService) Update(ctx context.Context, id string, req *dto.UpdateHotelRequest) (*dto.HotelResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	h, err := s.HotelRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	err = req.ApplyToHotel(ctx, h)
	if err != nil {
		return nil, err
	}

	err = s.HotelRepo.Update(ctx, h)
	if err != nil {
		return nil, err
	}

	// Return the updated hotel directly (avoid read-after-write consistency issues)
	return dto.NewHotelResponse(h), nil
}

// Delete soft deletes a hotel
func (s *hotelService) Delete(ctx context.Context, id string) error {
	h, err := s.HotelRepo.Get(ctx, id)
	if err != nil {
		return err
	}

	return s.HotelRepo.Delete(ctx, h)
}

// List retrieves a paginated list of hotels
func (s *hotelService) List(ctx context.Context, filter *types.HotelFilter) (*dto.ListHotelsResponse, error) {
	if filter == nil {
		filter = types.NewHotelFilter()
	}

	// Get hotels
	hotels, err := s.HotelRepo.List(ctx, filter)
	if err != nil {
		return nil, err
	}

	// Get total count
	total, err := s.HotelRepo.Count(ctx, filter)
	if err != nil {
		return nil, err
	}

	// Create paginated response using DTO helper
	limit := filter.GetLimit()
	offset := filter.GetOffset()
	response := dto.NewListHotelsResponse(hotels, total, limit, offset)

	return response, nil
}
