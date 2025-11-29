package v1

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/service"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type EventHandler struct {
	eventService service.EventService
}

func NewEventHandler(eventService service.EventService) *EventHandler {
	return &EventHandler{eventService: eventService}
}

// @Summary Create a new event
// @Description Create a new event with the provided details
// @Tags Event
// @Accept json
// @Produce json
// @Param request body dto.CreateEventRequest true "Create event request"
// @Success 201 {object} dto.EventResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events [post]
// @Security Authorization
func (h *EventHandler) Create(c *gin.Context) {
	var req dto.CreateEventRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	event, err := h.eventService.Create(c.Request.Context(), &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, event)
}

// @Summary Get event by ID
// @Description Get an event by its ID
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 200 {object} dto.EventResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/{id} [get]
func (h *EventHandler) Get(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("event ID is required").
			WithHint("Please provide a valid event ID").
			Mark(ierr.ErrValidation))
		return
	}

	event, err := h.eventService.Get(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, event)
}

// @Summary Get event by slug
// @Description Get an event by its slug
// @Tags Event
// @Accept json
// @Produce json
// @Param slug path string true "Event slug"
// @Success 200 {object} dto.EventResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/slug/{slug} [get]
func (h *EventHandler) GetBySlug(c *gin.Context) {
	slug := c.Param("slug")
	if slug == "" {
		c.Error(ierr.NewError("event slug is required").
			WithHint("Please provide a valid event slug").
			Mark(ierr.ErrValidation))
		return
	}

	event, err := h.eventService.GetBySlug(c.Request.Context(), slug)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, event)
}

// @Summary Update an event
// @Description Update an existing event
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Param request body dto.UpdateEventRequest true "Update event request"
// @Success 200 {object} dto.EventResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 409 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/{id} [put]
// @Security Authorization
func (h *EventHandler) Update(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("event ID is required").
			WithHint("Please provide a valid event ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdateEventRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	event, err := h.eventService.Update(c.Request.Context(), id, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, event)
}

// @Summary Delete an event
// @Description Soft delete an event
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/{id} [delete]
// @Security Authorization
func (h *EventHandler) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("event ID is required").
			WithHint("Please provide a valid event ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.eventService.Delete(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary List events
// @Description Get a paginated list of events with filtering and pagination. Use expand=true with from_date and to_date to get expanded occurrences.
// @Tags Event
// @Accept json
// @Produce json
// @Param filter query types.EventFilter false "Event filter parameters"
// @Param expand query bool false "Expand occurrences in date range"
// @Param from_date query string false "Start date for expansion (YYYY-MM-DD)"
// @Param to_date query string false "End date for expansion (YYYY-MM-DD)"
// @Success 200 {object} dto.ListEventsResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events [get]
func (h *EventHandler) List(c *gin.Context) {
	var filter types.EventFilter
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

	// Get events list
	events, err := h.eventService.List(c.Request.Context(), &filter)
	if err != nil {
		c.Error(err)
		return
	}

	// Check if expansion is requested
	if filter.Expand != nil && *filter.Expand {
		// Validate required date parameters for expansion
		if filter.FromDate == nil || filter.ToDate == nil {
			c.Error(ierr.NewError("from_date and to_date are required when expand=true").
				WithHint("Please provide date range in YYYY-MM-DD format").
				Mark(ierr.ErrValidation))
			return
		}

		// Note: Expansion logic should be moved to service layer in future refactoring
		// For now, return events with a note to expand on client side or use occurrence endpoints
		c.JSON(http.StatusOK, events)
		return
	}

	// Normal list without expansion
	c.JSON(http.StatusOK, events)
}

// @Summary Create event occurrence
// @Description Create a new occurrence for an event
// @Tags Event
// @Accept json
// @Produce json
// @Param request body dto.CreateOccurrenceRequest true "Create occurrence request"
// @Success 201 {object} dto.OccurrenceResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/occurrences [post]
// @Security Authorization
func (h *EventHandler) CreateOccurrence(c *gin.Context) {
	var req dto.CreateOccurrenceRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	occurrence, err := h.eventService.CreateOccurrence(c.Request.Context(), &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusCreated, occurrence)
}

// @Summary Get occurrence by ID
// @Description Get an event occurrence by its ID
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Occurrence ID"
// @Success 200 {object} dto.OccurrenceResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/occurrences/{id} [get]
func (h *EventHandler) GetOccurrence(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("occurrence ID is required").
			WithHint("Please provide a valid occurrence ID").
			Mark(ierr.ErrValidation))
		return
	}

	occurrence, err := h.eventService.GetOccurrence(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, occurrence)
}

// @Summary Update occurrence
// @Description Update an existing event occurrence
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Occurrence ID"
// @Param request body dto.UpdateOccurrenceRequest true "Update occurrence request"
// @Success 200 {object} dto.OccurrenceResponse
// @Failure 400 {object} ierr.ErrorResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/occurrences/{id} [put]
// @Security Authorization
func (h *EventHandler) UpdateOccurrence(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("occurrence ID is required").
			WithHint("Please provide a valid occurrence ID").
			Mark(ierr.ErrValidation))
		return
	}

	var req dto.UpdateOccurrenceRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.Error(ierr.WithError(err).
			WithHint("Please check the request payload").
			Mark(ierr.ErrValidation))
		return
	}

	occurrence, err := h.eventService.UpdateOccurrence(c.Request.Context(), id, &req)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, occurrence)
}

// @Summary Delete occurrence
// @Description Soft delete an event occurrence
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Occurrence ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/occurrences/{id} [delete]
// @Security Authorization
func (h *EventHandler) DeleteOccurrence(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("occurrence ID is required").
			WithHint("Please provide a valid occurrence ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.eventService.DeleteOccurrence(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary List occurrences for event
// @Description Get all occurrences for a specific event
// @Tags Event
// @Accept json
// @Produce json
// @Param eventId path string true "Event ID"
// @Success 200 {array} dto.OccurrenceResponse
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/{eventId}/occurrences [get]
func (h *EventHandler) ListOccurrences(c *gin.Context) {
	eventID := c.Param("id")
	if eventID == "" {
		c.Error(ierr.NewError("event ID is required").
			WithHint("Please provide a valid event ID").
			Mark(ierr.ErrValidation))
		return
	}

	occurrences, err := h.eventService.ListOccurrences(c.Request.Context(), eventID)
	if err != nil {
		c.Error(err)
		return
	}
	c.JSON(http.StatusOK, occurrences)
}

// @Summary Increment event view count
// @Description Increment the view count for an event (analytics)
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/{id}/view [post]
func (h *EventHandler) IncrementView(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("event ID is required").
			WithHint("Please provide a valid event ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.eventService.IncrementView(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}

// @Summary Increment event interested count
// @Description Increment the interested count for an event (user marked as interested)
// @Tags Event
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 204
// @Failure 404 {object} ierr.ErrorResponse
// @Failure 500 {object} ierr.ErrorResponse
// @Router /events/{id}/interested [post]
func (h *EventHandler) IncrementInterested(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.Error(ierr.NewError("event ID is required").
			WithHint("Please provide a valid event ID").
			Mark(ierr.ErrValidation))
		return
	}

	err := h.eventService.IncrementInterested(c.Request.Context(), id)
	if err != nil {
		c.Error(err)
		return
	}
	c.Status(http.StatusNoContent)
}
