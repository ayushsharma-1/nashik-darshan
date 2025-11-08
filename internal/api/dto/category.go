package dto

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/domain/category"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/samber/lo"
)

type CreateCategoryRequest struct {
	Name        string         `json:"name" binding:"required,min=1,max=255"`
	Slug        string         `json:"slug" binding:"required,min=1"`
	Description string         `json:"description,omitempty"`
	Metdata     types.Metadata `json:"metadata,omitempty"`
}

// Validate validates the CreateCategoryRequest
func (req *CreateCategoryRequest) Validate() error {
	// Validate struct tags
	if err := validator.ValidateRequest(req); err != nil {
		return err
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
		ID:          types.GenerateUUIDWithPrefix(types.UUID_PREFIX_CATEGORY),
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
		cat.Description = *req.Description
	}
	cat.UpdatedBy = types.GetUserID(ctx)
}
