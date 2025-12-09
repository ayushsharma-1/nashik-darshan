package v1

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/service"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type ItineraryHandler struct {
	itineraryService service.ItineraryService
}

func NewItineraryHandler(itineraryService service.ItineraryService) *ItineraryHandler {
	return &ItineraryHandler{itineraryService: itineraryService}
}

// @Summary Create a new itinerary
// @Description Create a new optimized itinerary with route planning
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param request body dto.CreateItineraryRequest true "Create itinerary request"
// @Success 201 {object} dto.ItineraryResponse
// @Failure 400 {object} ierr.ErrorResponse "Invalid request payload or validation error"
// @Failure 404 {object} ierr.ErrorResponse "One or more places not found"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Failure 502 {object} ierr.ErrorResponse "Routing service error"
// @Router /itineraries [post]
// @Security Authorization
func (h *ItineraryHandler) Create(c *gin.Context) {
	// Get user ID from context (set by auth middleware)
	userID := types.GetUserID(c.Request.Context())
	if userID == "" {
		c.Error(ierr.NewError("User not authenticated").
			WithHint("Please login to create an itinerary").
			Mark(ierr.ErrPermissionDenied))
		return
	}

	var req dto.CreateItineraryRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	itinerary, err := h.itineraryService.Create(c.Request.Context(), userID, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, itinerary)
}

// @Summary Get itinerary by ID
// @Description Get an itinerary by its ID without visit details
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param id path string true "Itinerary ID"
// @Success 200 {object} dto.ItineraryResponse
// @Failure 404 {object} ierr.ErrorResponse "Itinerary not found"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Router /itineraries/{id} [get]
func (h *ItineraryHandler) Get(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("Itinerary ID is required").
			WithHint("Please provide a valid itinerary ID").
			Mark(ierr.ErrValidation))
		return
	}

	itinerary, err := h.itineraryService.Get(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, itinerary)
}

// @Summary Get itinerary with visits
// @Description Get an itinerary by its ID with all visit details including place information
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param id path string true "Itinerary ID"
// @Success 200 {object} dto.ItineraryResponse
// @Failure 404 {object} ierr.ErrorResponse "Itinerary not found"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Router /itineraries/{id}/details [get]
func (h *ItineraryHandler) GetWithVisits(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("Itinerary ID is required").
			WithHint("Please provide a valid itinerary ID").
			Mark(ierr.ErrValidation))
		return
	}

	itinerary, err := h.itineraryService.GetWithVisits(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, itinerary)
}

// @Summary Update an itinerary
// @Description Update an existing itinerary (does not re-optimize route)
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param id path string true "Itinerary ID"
// @Param request body dto.UpdateItineraryRequest true "Update itinerary request"
// @Success 200 {object} dto.ItineraryResponse
// @Failure 400 {object} ierr.ErrorResponse "Invalid request payload or validation error"
// @Failure 404 {object} ierr.ErrorResponse "Itinerary not found"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Router /itineraries/{id} [put]
// @Security Authorization
func (h *ItineraryHandler) Update(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("Itinerary ID is required").
			WithHint("Please provide a valid itinerary ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdateItineraryRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	itinerary, err := h.itineraryService.Update(c.Request.Context(), id, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, itinerary)
}

// @Summary Delete an itinerary
// @Description Delete an itinerary and all its visits
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param id path string true "Itinerary ID"
// @Success 204 "Successfully deleted"
// @Failure 404 {object} ierr.ErrorResponse "Itinerary not found"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Router /itineraries/{id} [delete]
// @Security Authorization
func (h *ItineraryHandler) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("Itinerary ID is required").
			WithHint("Please provide a valid itinerary ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.itineraryService.Delete(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary List itineraries
// @Description Get a paginated list of itineraries with filtering
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param limit query int false "Limit" default(20)
// @Param offset query int false "Offset" default(0)
// @Param status query string false "Status filter (published, draft, archived, deleted)"
// @Param sort query string false "Sort field" default(created_at)
// @Param order query string false "Sort order (asc/desc)" default(desc)
// @Param user_id query string false "Filter by user ID"
// @Param from_date query string false "Filter itineraries from date (YYYY-MM-DD)"
// @Param to_date query string false "Filter itineraries to date (YYYY-MM-DD)"
// @Param transport_mode query string false "Filter by transport mode (WALKING, DRIVING, TAXI)"
// @Success 200 {object} dto.ListItinerariesResponse
// @Failure 400 {object} ierr.ErrorResponse "Invalid query parameters"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Router /itineraries [get]
func (h *ItineraryHandler) List(c *gin.Context) {
	var filter types.ItineraryFilter
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

	if err := filter.Validate(); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Invalid filter parameters").
			Mark(ierr.ErrValidation))
		return
	}

	response, err := h.itineraryService.List(c.Request.Context(), &filter)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, response)
}

// @Summary Get user's itineraries
// @Description Get all itineraries for the authenticated user
// @Tags Itinerary
// @Accept json
// @Produce json
// @Param limit query int false "Limit" default(20)
// @Param offset query int false "Offset" default(0)
// @Param status query string false "Status filter"
// @Param sort query string false "Sort field" default(created_at)
// @Param order query string false "Sort order (asc/desc)" default(desc)
// @Success 200 {object} dto.ListItinerariesResponse
// @Failure 401 {object} ierr.ErrorResponse "User not authenticated"
// @Failure 400 {object} ierr.ErrorResponse "Invalid query parameters"
// @Failure 500 {object} ierr.ErrorResponse "Internal server error"
// @Router /itineraries/me [get]
// @Security Authorization
func (h *ItineraryHandler) GetMyItineraries(c *gin.Context) {
	// Get user ID from context (set by auth middleware)
	userID := types.GetUserID(c.Request.Context())
	if userID == "" {
		c.Error(ierr.NewError("User not authenticated").
			WithHint("Please login to view your itineraries").
			Mark(ierr.ErrPermissionDenied))
		return
	}

	var filter types.ItineraryFilter
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

	// Force filter by user ID
	filter.UserID = &userID

	if err := filter.Validate(); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Invalid filter parameters").
			Mark(ierr.ErrValidation))
		return
	}

	response, err := h.itineraryService.List(c.Request.Context(), &filter)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, response)
}
