package v1

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/service"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type PlaceHandler struct {
	placeService service.PlaceService
}

func NewPlaceHandler(placeService service.PlaceService) *PlaceHandler {
	return &PlaceHandler{placeService: placeService}
}

// @Summary Create a new place
// @Description Create a new place with the provided details
// @Tags Place
// @Accept json
// @Produce json
// @Param request body dto.CreatePlaceRequest true "Create place request"
// @Success 201 {object} dto.PlaceResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places [post]
// @Security Authorization
func (h *PlaceHandler) Create(c *gin.Context) {
	var req dto.CreatePlaceRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	place, err := h.placeService.Create(c.Request.Context(), &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, place)
}

// @Summary Get place by ID
// @Description Get a place by its ID
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Success 200 {object} dto.PlaceResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id} [get]
func (h *PlaceHandler) Get(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	place, err := h.placeService.Get(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, place)
}

// @Summary Get place by slug
// @Description Get a place by its slug
// @Tags Place
// @Accept json
// @Produce json
// @Param slug path string true "Place slug"
// @Success 200 {object} dto.PlaceResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/slug/{slug} [get]
func (h *PlaceHandler) GetBySlug(c *gin.Context) {
	slug := c.Param("slug")
	if slug == "" {
		c.Error(ierr.NewError("place slug is required").
			WithHint("Please provide a valid place slug").
			Mark(ierr.ErrValidation))
		return
	}

	place, err := h.placeService.GetBySlug(c.Request.Context(), slug)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, place)
}

// @Summary Update a place
// @Description Update an existing place
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Param request body dto.UpdatePlaceRequest true "Update place request"
// @Success 200 {object} dto.PlaceResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id} [put]
// @Security Authorization
func (h *PlaceHandler) Update(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdatePlaceRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	place, err := h.placeService.Update(c.Request.Context(), id, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, place)
}

// @Summary Delete a place
// @Description Soft delete a place
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id} [delete]
// @Security Authorization
func (h *PlaceHandler) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.placeService.Delete(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary List places
// @Description Get a paginated list of places with filtering and pagination
// @Tags Place
// @Accept json
// @Produce json
// @Param limit query int false "Limit"
// @Param offset query int false "Offset"
// @Param status query string false "Status"
// @Param sort query string false "Sort field"
// @Param order query string false "Sort order (asc/desc)"
// @Param slug query []string false "Filter by slugs"
// @Param place_types query []string false "Filter by place types"
// @Param categories query []string false "Filter by categories"
// @Param amenities query []string false "Filter by amenities"
// @Param min_rating query number false "Minimum rating"
// @Param max_rating query number false "Maximum rating"
// @Param latitude query number false "Latitude for geospatial filtering"
// @Param longitude query number false "Longitude for geospatial filtering"
// @Param radius_km query number false "Radius in kilometers for geospatial filtering"
// @Param search_query query string false "Search query"
// @Success 200 {object} dto.ListPlacesResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places [get]
func (h *PlaceHandler) List(c *gin.Context) {
	var filter types.PlaceFilter
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

	response, err := h.placeService.List(c.Request.Context(), &filter)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, response)
}

// @Summary Add image to place
// @Description Add an image to a place
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Param request body dto.CreatePlaceImageRequest true "Create place image request"
// @Success 201 {object} dto.PlaceImageResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id}/images [post]
// @Security Authorization
func (h *PlaceHandler) AddImage(c *gin.Context) {
	placeID := c.Param("id")
	if placeID == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.CreatePlaceImageRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	image, err := h.placeService.AddImage(c.Request.Context(), placeID, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, image)
}

// @Summary Get place images
// @Description Get all images for a place
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Success 200 {array} dto.PlaceImageResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id}/images [get]
func (h *PlaceHandler) GetImages(c *gin.Context) {
	placeID := c.Param("id")
	if placeID == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	images, err := h.placeService.GetImages(c.Request.Context(), placeID)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, images)
}

// @Summary Update place image
// @Description Update an existing place image
// @Tags Place
// @Accept json
// @Produce json
// @Param image_id path string true "Image ID"
// @Param request body dto.UpdatePlaceImageRequest true "Update place image request"
// @Success 200 {object} dto.PlaceImageResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/images/{image_id} [put]
// @Security Authorization
func (h *PlaceHandler) UpdateImage(c *gin.Context) {
	imageID := c.Param("image_id")
	if imageID == "" {
		c.Error(ierr.NewError("image ID is required").
			WithHint("Please provide a valid image ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdatePlaceImageRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	image, err := h.placeService.UpdateImage(c.Request.Context(), imageID, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, image)
}

// @Summary Delete place image
// @Description Delete a place image
// @Tags Place
// @Accept json
// @Produce json
// @Param image_id path string true "Image ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/images/{image_id} [delete]
// @Security Authorization
func (h *PlaceHandler) DeleteImage(c *gin.Context) {
	imageID := c.Param("image_id")
	if imageID == "" {
		c.Error(ierr.NewError("image ID is required").
			WithHint("Please provide a valid image ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.placeService.DeleteImage(c.Request.Context(), imageID)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary Get feed data
// @Description Get feed data with multiple sections (trending, popular, latest, nearby)
// @Tags Place
// @Accept json
// @Produce json
// @Param request body dto.FeedRequest true "Feed request with sections"
// @Success 200 {object} dto.FeedResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /feed [post]
func (h *PlaceHandler) GetFeed(c *gin.Context) {
	var req dto.FeedRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	response, err := h.placeService.GetFeed(c.Request.Context(), &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, response)
}

// @Summary Increment view count for a place
// @Description Increment the view count for a specific place
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Success 204
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id}/view [post]
func (h *PlaceHandler) IncrementViewCount(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.placeService.IncrementViewCount(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary Assign categories to a place
// @Description Assign categories to a place by replacing existing category relationships
// @Tags Place
// @Accept json
// @Produce json
// @Param id path string true "Place ID"
// @Param request body dto.AssignCategoriesRequest true "Assign categories request"
// @Success 204
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /places/{id}/categories [put]
// @Security Authorization
func (h *PlaceHandler) AssignCategories(c *gin.Context) {
	placeID := c.Param("id")
	if placeID == "" {
		c.Error(ierr.NewError("place ID is required").
			WithHint("Please provide a valid place ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.AssignCategoriesRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.placeService.AssignCategories(c.Request.Context(), placeID, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}
