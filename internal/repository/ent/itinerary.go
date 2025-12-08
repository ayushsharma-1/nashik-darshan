package ent

import (
	"context"
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/itinerary"
	"github.com/omkar273/nashikdarshan/ent/predicate"
	"github.com/omkar273/nashikdarshan/ent/visit"
	domain "github.com/omkar273/nashikdarshan/internal/domain/itinerary"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type ItineraryRepository struct {
	client postgres.IClient
	log    logger.Logger
}

func NewItineraryRepository(client postgres.IClient, log *logger.Logger) domain.Repository {
	return &ItineraryRepository{
		client: client,
		log:    *log,
	}
}

// ========== Itinerary CRUD ==========

// Create creates a new itinerary with visits in a transaction
func (r *ItineraryRepository) Create(ctx context.Context, itin *domain.Itinerary) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating itinerary",
		"itinerary_id", itin.ID,
		"user_id", itin.UserID,
		"title", itin.Title,
		"visits_count", len(itin.Visits),
	)

	// Start transaction
	tx, err := client.Tx(ctx)
	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to start database transaction").
			Mark(ierr.ErrDatabase)
	}

	now := time.Now().UTC()

	// Create itinerary
	create := tx.Itinerary.Create().
		SetID(itin.ID).
		SetUserID(itin.UserID).
		SetTitle(itin.Title).
		SetPlannedDate(itin.PlannedDate).
		SetStartLatitude(itin.StartLocation.Latitude).
		SetStartLongitude(itin.StartLocation.Longitude).
		SetPreferredTransportMode(string(itin.TransportMode)).
		SetIsOptimized(itin.IsOptimized).
		SetStatus(string(itin.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

	if itin.Description != nil {
		create = create.SetDescription(*itin.Description)
	}
	if itin.TotalDistanceKm != nil {
		create = create.SetTotalDistanceKm(*itin.TotalDistanceKm)
	}
	if itin.TotalDurationMinutes != nil {
		create = create.SetTotalDurationMinutes(*itin.TotalDurationMinutes)
	}
	if itin.TotalVisitTimeMinutes != nil {
		create = create.SetTotalVisitTimeMinutes(*itin.TotalVisitTimeMinutes)
	}
	if itin.Metadata != nil {
		create = create.SetMetadata(itin.Metadata)
	}

	_, err = create.Save(ctx)
	if err != nil {
		tx.Rollback()
		return ierr.WithError(err).
			WithHint("Failed to create itinerary").
			Mark(ierr.ErrDatabase)
	}

	// Create visits
	for _, v := range itin.Visits {
		visitCreate := tx.Visit.Create().
			SetID(v.ID).
			SetItineraryID(itin.ID).
			SetPlaceID(v.PlaceID).
			SetSequenceOrder(v.SequenceOrder).
			SetPlannedDurationMinutes(v.PlannedDurationMinutes).
			SetStatus(string(v.Status)).
			SetCreatedAt(now).
			SetUpdatedAt(now).
			SetCreatedBy(types.GetUserID(ctx)).
			SetUpdatedBy(types.GetUserID(ctx))

		if v.DistanceFromPreviousKm != nil {
			visitCreate = visitCreate.SetDistanceFromPreviousKm(*v.DistanceFromPreviousKm)
		}
		if v.TravelTimeFromPreviousMinutes != nil {
			visitCreate = visitCreate.SetTravelTimeFromPreviousMinutes(*v.TravelTimeFromPreviousMinutes)
		}
		if v.TransportMode != nil {
			visitCreate = visitCreate.SetTransportMode(string(*v.TransportMode))
		}
		if v.Notes != nil {
			visitCreate = visitCreate.SetNotes(*v.Notes)
		}

		_, err := visitCreate.Save(ctx)
		if err != nil {
			tx.Rollback()
			return ierr.WithError(err).
				WithHint("Failed to create visit").
				WithReportableDetails(map[string]interface{}{
					"visit_id": v.ID,
					"place_id": v.PlaceID,
					"order":    v.SequenceOrder,
				}).
				Mark(ierr.ErrDatabase)
		}
	}

	// Commit transaction
	if err := tx.Commit(); err != nil {
		return ierr.WithError(err).
			WithHint("Failed to commit transaction").
			Mark(ierr.ErrDatabase)
	}

	r.log.Infow("created itinerary successfully",
		"itinerary_id", itin.ID,
		"visits_count", len(itin.Visits),
	)

	return nil
}

// Get retrieves an itinerary by ID without visits
func (r *ItineraryRepository) Get(ctx context.Context, id string) (*domain.Itinerary, error) {
	client := r.client.Querier(ctx)

	e, err := client.Itinerary.Query().
		Where(itinerary.ID(id)).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.NewError("Itinerary not found").
				WithHint("Please check the itinerary ID").
				WithReportableDetails(map[string]interface{}{
					"itinerary_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to fetch itinerary").
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(e), nil
}

// GetWithVisits retrieves itinerary with all visits and place details
func (r *ItineraryRepository) GetWithVisits(ctx context.Context, id string) (*domain.Itinerary, error) {
	client := r.client.Querier(ctx)

	e, err := client.Itinerary.Query().
		Where(itinerary.ID(id)).
		WithVisits(func(q *ent.VisitQuery) {
			q.Order(ent.Asc(visit.FieldSequenceOrder)).
				WithPlace()
		}).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.NewError("Itinerary not found").
				WithHint("Please check the itinerary ID").
				WithReportableDetails(map[string]interface{}{
					"itinerary_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to fetch itinerary with visits").
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(e), nil
}

// List retrieves itineraries based on filter
func (r *ItineraryRepository) List(ctx context.Context, filter *types.ItineraryFilter) ([]*domain.Itinerary, error) {
	client := r.client.Querier(ctx)

	query := client.Itinerary.Query()

	// Apply filters
	query = r.applyFilters(query, filter)

	// Apply pagination and sorting
	if filter != nil && filter.QueryFilter != nil {
		if filter.Limit != nil {
			query = query.Limit(*filter.Limit)
		}
		if filter.Offset != nil {
			query = query.Offset(*filter.Offset)
		}

		// Apply sorting
		if filter.Sort != nil {
			orderFunc := ent.Asc
			if filter.Order != nil && *filter.Order == "desc" {
				orderFunc = ent.Desc
			}

			switch *filter.Sort {
			case "planned_date":
				query = query.Order(orderFunc(itinerary.FieldPlannedDate))
			case "created_at":
				query = query.Order(orderFunc(itinerary.FieldCreatedAt))
			case "title":
				query = query.Order(orderFunc(itinerary.FieldTitle))
			default:
				query = query.Order(ent.Desc(itinerary.FieldCreatedAt))
			}
		} else {
			query = query.Order(ent.Desc(itinerary.FieldCreatedAt))
		}
	}

	itineraries, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to list itineraries").
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEntList(itineraries), nil
}

// Count returns the total count of itineraries matching the filter
func (r *ItineraryRepository) Count(ctx context.Context, filter *types.ItineraryFilter) (int, error) {
	client := r.client.Querier(ctx)

	query := client.Itinerary.Query()
	query = r.applyFilters(query, filter)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithHint("Failed to count itineraries").
			Mark(ierr.ErrDatabase)
	}

	return count, nil
}

// Update updates an existing itinerary
func (r *ItineraryRepository) Update(ctx context.Context, itin *domain.Itinerary) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating itinerary",
		"itinerary_id", itin.ID,
		"title", itin.Title,
	)

	update := client.Itinerary.UpdateOneID(itin.ID).
		SetTitle(itin.Title).
		SetPlannedDate(itin.PlannedDate).
		SetStartLatitude(itin.StartLocation.Latitude).
		SetStartLongitude(itin.StartLocation.Longitude).
		SetPreferredTransportMode(string(itin.TransportMode)).
		SetIsOptimized(itin.IsOptimized).
		SetStatus(string(itin.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if itin.Description != nil {
		update = update.SetDescription(*itin.Description)
	}
	if itin.TotalDistanceKm != nil {
		update = update.SetTotalDistanceKm(*itin.TotalDistanceKm)
	}
	if itin.TotalDurationMinutes != nil {
		update = update.SetTotalDurationMinutes(*itin.TotalDurationMinutes)
	}
	if itin.TotalVisitTimeMinutes != nil {
		update = update.SetTotalVisitTimeMinutes(*itin.TotalVisitTimeMinutes)
	}
	if itin.Metadata != nil {
		update = update.SetMetadata(itin.Metadata)
	}

	_, err := update.Save(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("Itinerary not found").
				WithHint("Please check the itinerary ID").
				WithReportableDetails(map[string]interface{}{
					"itinerary_id": itin.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to update itinerary").
			Mark(ierr.ErrDatabase)
	}

	r.log.Infow("updated itinerary successfully", "itinerary_id", itin.ID)
	return nil
}

// Delete deletes an itinerary and its visits (cascade)
func (r *ItineraryRepository) Delete(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting itinerary", "itinerary_id", id)

	err := client.Itinerary.DeleteOneID(id).Exec(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("Itinerary not found").
				WithHint("Please check the itinerary ID").
				WithReportableDetails(map[string]interface{}{
					"itinerary_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete itinerary").
			Mark(ierr.ErrDatabase)
	}

	r.log.Infow("deleted itinerary successfully", "itinerary_id", id)
	return nil
}

// ========== Visit Operations ==========

// CreateVisits creates multiple visits
func (r *ItineraryRepository) CreateVisits(ctx context.Context, visits []*domain.Visit) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating visits", "count", len(visits))

	now := time.Now().UTC()
	for _, v := range visits {
		create := client.Visit.Create().
			SetID(v.ID).
			SetItineraryID(v.ItineraryID).
			SetPlaceID(v.PlaceID).
			SetSequenceOrder(v.SequenceOrder).
			SetPlannedDurationMinutes(v.PlannedDurationMinutes).
			SetStatus(string(v.Status)).
			SetCreatedAt(now).
			SetUpdatedAt(now).
			SetCreatedBy(types.GetUserID(ctx)).
			SetUpdatedBy(types.GetUserID(ctx))

		if v.DistanceFromPreviousKm != nil {
			create = create.SetDistanceFromPreviousKm(*v.DistanceFromPreviousKm)
		}
		if v.TravelTimeFromPreviousMinutes != nil {
			create = create.SetTravelTimeFromPreviousMinutes(*v.TravelTimeFromPreviousMinutes)
		}
		if v.TransportMode != nil {
			create = create.SetTransportMode(string(*v.TransportMode))
		}
		if v.Notes != nil {
			create = create.SetNotes(*v.Notes)
		}

		_, err := create.Save(ctx)
		if err != nil {
			return ierr.WithError(err).
				WithHint("Failed to create visit").
				WithReportableDetails(map[string]interface{}{
					"visit_id": v.ID,
					"place_id": v.PlaceID,
				}).
				Mark(ierr.ErrDatabase)
		}
	}

	r.log.Infow("created visits successfully", "count", len(visits))
	return nil
}

// GetVisits retrieves all visits for an itinerary
func (r *ItineraryRepository) GetVisits(ctx context.Context, itineraryID string) ([]*domain.Visit, error) {
	client := r.client.Querier(ctx)

	visits, err := client.Visit.Query().
		Where(visit.ItineraryID(itineraryID)).
		Order(ent.Asc(visit.FieldSequenceOrder)).
		WithPlace().
		All(ctx)

	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to fetch visits").
			Mark(ierr.ErrDatabase)
	}

	return domain.VisitFromEntList(visits), nil
}

// UpdateVisit updates an existing visit
func (r *ItineraryRepository) UpdateVisit(ctx context.Context, v *domain.Visit) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating visit", "visit_id", v.ID)

	update := client.Visit.UpdateOneID(v.ID).
		SetSequenceOrder(v.SequenceOrder).
		SetPlannedDurationMinutes(v.PlannedDurationMinutes).
		SetStatus(string(v.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if v.DistanceFromPreviousKm != nil {
		update = update.SetDistanceFromPreviousKm(*v.DistanceFromPreviousKm)
	}
	if v.TravelTimeFromPreviousMinutes != nil {
		update = update.SetTravelTimeFromPreviousMinutes(*v.TravelTimeFromPreviousMinutes)
	}
	if v.TransportMode != nil {
		update = update.SetTransportMode(string(*v.TransportMode))
	}
	if v.Notes != nil {
		update = update.SetNotes(*v.Notes)
	}

	_, err := update.Save(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("Visit not found").
				WithHint("Please check the visit ID").
				WithReportableDetails(map[string]interface{}{
					"visit_id": v.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to update visit").
			Mark(ierr.ErrDatabase)
	}

	r.log.Infow("updated visit successfully", "visit_id", v.ID)
	return nil
}

// DeleteVisit deletes a visit
func (r *ItineraryRepository) DeleteVisit(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting visit", "visit_id", id)

	err := client.Visit.DeleteOneID(id).Exec(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("Visit not found").
				WithHint("Please check the visit ID").
				WithReportableDetails(map[string]interface{}{
					"visit_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete visit").
			Mark(ierr.ErrDatabase)
	}

	r.log.Infow("deleted visit successfully", "visit_id", id)
	return nil
}

// ========== Helper Functions ==========

// applyFilters applies filters to the query
func (r *ItineraryRepository) applyFilters(query *ent.ItineraryQuery, filter *types.ItineraryFilter) *ent.ItineraryQuery {
	if filter == nil {
		return query
	}

	var predicates []predicate.Itinerary

	// Filter by user ID
	if filter.UserID != nil {
		predicates = append(predicates, itinerary.UserID(*filter.UserID))
	}

	// Filter by transport mode
	if filter.TransportMode != nil {
		predicates = append(predicates, itinerary.PreferredTransportMode(string(*filter.TransportMode)))
	}

	// Filter by date range
	if filter.FromDate != nil {
		predicates = append(predicates, itinerary.PlannedDateGTE(parseDate(*filter.FromDate)))
	}
	if filter.ToDate != nil {
		predicates = append(predicates, itinerary.PlannedDateLTE(parseDate(*filter.ToDate)))
	}

	// Apply base filter (status)
	if filter.QueryFilter != nil && filter.QueryFilter.Status != nil {
		predicates = append(predicates, itinerary.Status(string(*filter.QueryFilter.Status)))
	}

	if len(predicates) > 0 {
		query = query.Where(predicates...)
	}

	return query
}

// parseDate parses ISO date string to time.Time
func parseDate(dateStr string) time.Time {
	t, err := time.Parse("2006-01-02", dateStr)
	if err != nil {
		return time.Time{}
	}
	return t
}
