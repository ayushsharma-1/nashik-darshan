package v1

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/service"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type CategoryHandler struct {
	categoryService service.CategoryService
}

func NewCategoryHandler(categoryService service.CategoryService) *CategoryHandler {
	return &CategoryHandler{categoryService: categoryService}
}

// @Summary Create a new category
// @Description Create a new category with the provided details
// @Tags Category
// @Accept json
// @Produce json
// @Param request body dto.CreateCategoryRequest true "Create category request"
// @Success 201 {object} dto.CategoryResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /categories [post]
// @Security Authorization
func (h *CategoryHandler) Create(c *gin.Context) {
	var req dto.CreateCategoryRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	category, err := h.categoryService.Create(c.Request.Context(), &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, category)
}

// @Summary Get category by ID
// @Description Get a category by its ID
// @Tags Category
// @Accept json
// @Produce json
// @Param id path string true "Category ID"
// @Success 200 {object} dto.CategoryResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /categories/{id} [get]
func (h *CategoryHandler) Get(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("category ID is required").
			WithHint("Please provide a valid category ID").
			Mark(ierr.ErrValidation))
		return
	}

	category, err := h.categoryService.Get(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, category)
}

// @Summary Get category by slug
// @Description Get a category by its slug
// @Tags Category
// @Accept json
// @Produce json
// @Param slug path string true "Category slug"
// @Success 200 {object} dto.CategoryResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /categories/slug/{slug} [get]
func (h *CategoryHandler) GetBySlug(c *gin.Context) {
	slug := c.Param("slug")
	if slug == "" {
		c.Error(ierr.NewError("category slug is required").
			WithHint("Please provide a valid category slug").
			Mark(ierr.ErrValidation))
		return
	}

	category, err := h.categoryService.GetBySlug(c.Request.Context(), slug)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, category)
}

// @Summary Update a category
// @Description Update an existing category
// @Tags Category
// @Accept json
// @Produce json
// @Param id path string true "Category ID"
// @Param request body dto.UpdateCategoryRequest true "Update category request"
// @Success 200 {object} dto.CategoryResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /categories/{id} [put]
// @Security Authorization
func (h *CategoryHandler) Update(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("category ID is required").
			WithHint("Please provide a valid category ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdateCategoryRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	category, err := h.categoryService.Update(c.Request.Context(), id, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, category)
}

// @Summary Delete a category
// @Description Soft delete a category
// @Tags Category
// @Accept json
// @Produce json
// @Param id path string true "Category ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /categories/{id} [delete]
// @Security Authorization
func (h *CategoryHandler) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("category ID is required").
			WithHint("Please provide a valid category ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.categoryService.Delete(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary List categories
// @Description Get a paginated list of categories with filtering and pagination
// @Tags Category
// @Accept json
// @Produce json
// @Param limit query int false "Limit"
// @Param offset query int false "Offset"
// @Param status query string false "Status"
// @Param sort query string false "Sort field"
// @Param order query string false "Sort order (asc/desc)"
// @Param slug query []string false "Filter by slugs"
// @Param name query []string false "Filter by names"
// @Success 200 {object} dto.ListCategoriesResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /categories [get]
func (h *CategoryHandler) List(c *gin.Context) {
	var filter types.CategoryFilter
	if err := c.ShouldBindQuery(&filter); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the query parameters").
			Mark(ierr.ErrValidation))
		return
	}

	// Initialize filter components if nil
	if filter.QueryFilter == nil {
		filter.QueryFilter = types.NewDefaultQueryFilter()
	}
	if filter.TimeRangeFilter == nil {
		filter.TimeRangeFilter = &types.TimeRangeFilter{}
	}

	if err := filter.Validate(); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Invalid filter parameters").
			Mark(ierr.ErrValidation))
		return
	}

	response, err := h.categoryService.List(c.Request.Context(), &filter)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, response)
}
