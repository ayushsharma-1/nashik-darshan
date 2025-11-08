package service

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/api/dto"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type CategoryService interface {
	Create(ctx context.Context, req *dto.CreateCategoryRequest) (*dto.CategoryResponse, error)
	Get(ctx context.Context, id string) (*dto.CategoryResponse, error)
	GetBySlug(ctx context.Context, slug string) (*dto.CategoryResponse, error)
	Update(ctx context.Context, id string, req *dto.UpdateCategoryRequest) (*dto.CategoryResponse, error)
	Delete(ctx context.Context, id string) error
	List(ctx context.Context, filter *types.CategoryFilter) (*dto.ListCategoriesResponse, error)
}

type categoryService struct {
	ServiceParams
}

// NewCategoryService creates a new category service
func NewCategoryService(params ServiceParams) CategoryService {
	return &categoryService{
		ServiceParams: params,
	}
}

// Create creates a new category
func (s *categoryService) Create(ctx context.Context, req *dto.CreateCategoryRequest) (*dto.CategoryResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	cat := req.ToCategory(ctx)

	err := s.CategoryRepo.Create(ctx, cat)
	if err != nil {
		return nil, err
	}

	return &dto.CategoryResponse{
		Category: cat,
	}, nil
}

// Get retrieves a category by ID
func (s *categoryService) Get(ctx context.Context, id string) (*dto.CategoryResponse, error) {
	cat, err := s.CategoryRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	return &dto.CategoryResponse{
		Category: cat,
	}, nil
}

// GetBySlug retrieves a category by slug
func (s *categoryService) GetBySlug(ctx context.Context, slug string) (*dto.CategoryResponse, error) {
	cat, err := s.CategoryRepo.GetBySlug(ctx, slug)
	if err != nil {
		return nil, err
	}

	return &dto.CategoryResponse{
		Category: cat,
	}, nil
}

// Update updates an existing category
func (s *categoryService) Update(ctx context.Context, id string, req *dto.UpdateCategoryRequest) (*dto.CategoryResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	cat, err := s.CategoryRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	req.ApplyToCategory(ctx, cat)

	err = s.CategoryRepo.Update(ctx, cat)
	if err != nil {
		return nil, err
	}

	return &dto.CategoryResponse{
		Category: cat,
	}, nil
}

// Delete soft deletes a category
func (s *categoryService) Delete(ctx context.Context, id string) error {
	cat, err := s.CategoryRepo.Get(ctx, id)
	if err != nil {
		return err
	}

	return s.CategoryRepo.Delete(ctx, cat)
}

// List retrieves a paginated list of categories
func (s *categoryService) List(ctx context.Context, filter *types.CategoryFilter) (*dto.ListCategoriesResponse, error) {
	if filter == nil {
		filter = types.NewCategoryFilter()
	}

	// Get categories
	categories, err := s.CategoryRepo.List(ctx, filter)
	if err != nil {
		return nil, err
	}

	// Get total count
	total, err := s.CategoryRepo.Count(ctx, filter)
	if err != nil {
		return nil, err
	}

	// Create paginated response using DTO helper
	limit := filter.GetLimit()
	offset := filter.GetOffset()
	response := dto.NewListCategoriesResponse(categories, total, limit, offset)

	return response, nil
}
