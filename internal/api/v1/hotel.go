package v1

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/service"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type HotelHandler struct {
	hotelService service.HotelService
}

func NewHotelHandler(hotelService service.HotelService) *HotelHandler {
	return &HotelHandler{hotelService: hotelService}
}

// @Summary Create a new hotel
// @Description Create a new hotel with the provided details
// @Tags Hotel
// @Accept json
// @Produce json
// @Param request body dto.CreateHotelRequest true "Create hotel request"
// @Success 201 {object} dto.HotelResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /hotels [post]
// @Security Authorization
func (h *HotelHandler) Create(c *gin.Context) {
	var req dto.CreateHotelRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	hotel, err := h.hotelService.Create(c.Request.Context(), &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, hotel)
}

// @Summary Get hotel by ID
// @Description Get a hotel by its ID
// @Tags Hotel
// @Accept json
// @Produce json
// @Param id path string true "Hotel ID"
// @Success 200 {object} dto.HotelResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /hotels/{id} [get]
func (h *HotelHandler) Get(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("hotel ID is required").
			WithHint("Please provide a valid hotel ID").
			Mark(ierr.ErrValidation))
		return
	}

	hotel, err := h.hotelService.Get(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, hotel)
}

// @Summary Get hotel by slug
// @Description Get a hotel by its slug
// @Tags Hotel
// @Accept json
// @Produce json
// @Param slug path string true "Hotel slug"
// @Success 200 {object} dto.HotelResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /hotels/slug/{slug} [get]
func (h *HotelHandler) GetBySlug(c *gin.Context) {
	slug := c.Param("slug")
	if slug == "" {
		c.Error(ierr.NewError("hotel slug is required").
			WithHint("Please provide a valid hotel slug").
			Mark(ierr.ErrValidation))
		return
	}

	hotel, err := h.hotelService.GetBySlug(c.Request.Context(), slug)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, hotel)
}

// @Summary Update a hotel
// @Description Update an existing hotel
// @Tags Hotel
// @Accept json
// @Produce json
// @Param id path string true "Hotel ID"
// @Param request body dto.UpdateHotelRequest true "Update hotel request"
// @Success 200 {object} dto.HotelResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /hotels/{id} [put]
// @Security Authorization
func (h *HotelHandler) Update(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("hotel ID is required").
			WithHint("Please provide a valid hotel ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdateHotelRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	hotel, err := h.hotelService.Update(c.Request.Context(), id, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, hotel)
}

// @Summary Delete a hotel
// @Description Soft delete a hotel
// @Tags Hotel
// @Accept json
// @Produce json
// @Param id path string true "Hotel ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /hotels/{id} [delete]
// @Security Authorization
func (h *HotelHandler) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("hotel ID is required").
			WithHint("Please provide a valid hotel ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.hotelService.Delete(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary List hotels
// @Description Get a paginated list of hotels with filtering and pagination
// @Tags Hotel
// @Accept json
// @Produce json
// @Param filter query types.HotelFilter false "Hotel filter parameters"
// @Success 200 {object} dto.ListHotelsResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /hotels [get]
func (h *HotelHandler) List(c *gin.Context) {
	var filter types.HotelFilter
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

	response, err := h.hotelService.List(c.Request.Context(), &filter)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, response)
}
