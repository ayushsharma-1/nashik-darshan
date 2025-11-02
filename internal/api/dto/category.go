package dto

import (
	"context"
	"strings"

	"github.com/omkar273/nashikdarshan/internal/domain/category"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
)

type CreateCategoryRequest struct {
	Name        string  `json:"name" binding:"required,min=1,max=255"`
	Slug        string  `json:"slug" binding:"required,min=1"`
	Description *string `json:"description,omitempty"`
}

// Validate validates the CreateCategoryRequest
func (req *CreateCategoryRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate name is not just whitespace
	name := strings.TrimSpace(req.Name)
	if name == "" {
		return ierr.NewError("name is required").
			WithHint("name cannot be empty or just whitespace").
			Mark(ierr.ErrValidation)
	}

	// Validate slug format
	slug := strings.TrimSpace(req.Slug)
	if slug == "" {
		return ierr.NewError("slug is required").
			WithHint("slug cannot be empty").
			Mark(ierr.ErrValidation)
	}

	// Slug should be lowercase and URL-friendly
	if strings.ToLower(slug) != slug {
		return ierr.NewError("invalid slug format").
			WithHint("slug must be lowercase").
			Mark(ierr.ErrValidation)
	}

	return nil
}

type UpdateCategoryRequest struct {
	Name        *string `json:"name,omitempty" binding:"omitempty,min=1,max=255"`
	Slug        *string `json:"slug,omitempty" binding:"omitempty,min=1"`
	Description *string `json:"description,omitempty"`
}

// Validate validates the UpdateCategoryRequest
func (req *UpdateCategoryRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
	}

	// Validate name if provided
	if req.Name != nil {
		name := strings.TrimSpace(*req.Name)
		if name == "" {
			return ierr.NewError("name cannot be empty").
				WithHint("name must contain at least one non-whitespace character").
				Mark(ierr.ErrValidation)
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

		// Slug should be lowercase and URL-friendly
		if strings.ToLower(slug) != slug {
			return ierr.NewError("invalid slug format").
				WithHint("slug must be lowercase").
				Mark(ierr.ErrValidation)
		}
	}

	return nil
}

type CategoryResponse struct {
	*category.Category
}

// ListCategoriesResponse represents a paginated list of categories
type ListCategoriesResponse = types.ListResponse[*CategoryResponse]

// NewListCategoriesResponse creates a new paginated list response for categories
func NewListCategoriesResponse(categories []*category.Category, total, limit, offset int) *ListCategoriesResponse {
	items := lo.Map(categories, func(cat *category.Category, _ int) *CategoryResponse {
		return &CategoryResponse{Category: cat}
	})

	response := types.NewListResponse(items, total, limit, offset)
	return &response
}

func (req *CreateCategoryRequest) ToCategory(ctx context.Context) *category.Category {
	baseModel := types.GetDefaultBaseModel(ctx)
	return &category.Category{
		Name:        req.Name,
		Slug:        req.Slug,
		Description: req.Description,
		BaseModel:   baseModel,
	}
}

func (req *UpdateCategoryRequest) ApplyToCategory(ctx context.Context, cat *category.Category) {
	if req.Name != nil {
		cat.Name = *req.Name
	}
	if req.Slug != nil {
		cat.Slug = *req.Slug
	}
	if req.Description != nil {
		cat.Description = req.Description
	}
	cat.UpdatedBy = types.GetUserID(ctx)
}
