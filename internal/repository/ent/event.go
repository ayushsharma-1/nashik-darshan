package ent

import (
	"context"
	"encoding/json"
	"time"

	entsql "entgo.io/ent/dialect/sql"
	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/event"
	"github.com/omkar273/nashikdarshan/ent/eventoccurrence"
	"github.com/omkar273/nashikdarshan/ent/predicate"
	domain "github.com/omkar273/nashikdarshan/internal/domain/event"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type EventRepository struct {
	client    postgres.IClient
	log       logger.Logger
	queryOpts EventQueryOptions
}

func NewEventRepository(client postgres.IClient, log *logger.Logger) domain.Repository {
	return &EventRepository{
		client:    client,
		log:       *log,
		queryOpts: EventQueryOptions{},
	}
}

// ========== Event CRUD ==========

func (r *EventRepository) Create(ctx context.Context, e *domain.Event) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating event",
		"event_id", e.ID,
		"slug", e.Slug,
		"title", e.Title,
		"type", e.Type,
	)

	now := time.Now().UTC()
	create := client.Event.Create().
		SetID(e.ID).
		SetSlug(e.Slug).
		SetType(string(e.Type)).
		SetTitle(e.Title).
		SetStartDate(e.StartDate).
		SetStatus(string(e.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

	if e.Subtitle != nil {
		create = create.SetSubtitle(*e.Subtitle)
	}
	if e.Description != nil {
		create = create.SetDescription(*e.Description)
	}
	if e.PlaceID != nil {
		create = create.SetPlaceID(*e.PlaceID)
	}
	if e.EndDate != nil {
		create = create.SetEndDate(*e.EndDate)
	}
	if e.CoverImageURL != nil {
		create = create.SetCoverImageURL(*e.CoverImageURL)
	}
	if len(e.Images) > 0 {
		create = create.SetImages(e.Images)
	}
	if len(e.Tags) > 0 {
		create = create.SetTags(e.Tags)
	}
	if e.Metadata != nil {
		create = create.SetMetadata(e.Metadata.ToMap())
	}
	if e.Latitude != nil {
		create = create.SetLatitude(e.Latitude)
	}
	if e.Longitude != nil {
		create = create.SetLongitude(e.Longitude)
	}
	if e.LocationName != nil {
		create = create.SetLocationName(*e.LocationName)
	}
	if e.ViewCount > 0 {
		create = create.SetViewCount(e.ViewCount)
	}
	if e.InterestedCount > 0 {
		create = create.SetInterestedCount(e.InterestedCount)
	}

	_, err := create.Save(ctx)

	if err != nil {
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Event with this slug already exists").
				WithReportableDetails(map[string]any{
					"event_id": e.ID,
					"slug":     e.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to create event").
			WithReportableDetails(map[string]any{
				"event_id": e.ID,
				"slug":     e.Slug,
				"title":    e.Title,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *EventRepository) Get(ctx context.Context, id string) (*domain.Event, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting event", "event_id", id)

	entEvent, err := client.Event.Query().
		Where(event.ID(id)).
		WithOccurrences().
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Event with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"event_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get event").
			WithReportableDetails(map[string]any{
				"event_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entEvent), nil
}

func (r *EventRepository) GetBySlug(ctx context.Context, slug string) (*domain.Event, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting event by slug", "slug", slug)

	entEvent, err := client.Event.Query().
		Where(
			event.Slug(slug),
			event.StatusEQ(string(types.StatusPublished)),
		).
		WithOccurrences().
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Event with slug %s was not found", slug).
				WithReportableDetails(map[string]any{
					"slug": slug,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get event by slug").
			WithReportableDetails(map[string]any{
				"slug": slug,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entEvent), nil
}

func (r *EventRepository) List(ctx context.Context, filter *types.EventFilter) ([]*domain.Event, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("listing events",
		"limit", filter.GetLimit(),
		"offset", filter.GetOffset(),
	)

	query := client.Event.Query()

	// Apply entity-specific filters first
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	// Apply common query options (status, pagination, sorting)
	query = ApplyQueryOptions(ctx, query, filter, r.queryOpts)

	events, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to list events").
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEntList(events), nil
}

func (r *EventRepository) Count(ctx context.Context, filter *types.EventFilter) (int, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("counting events", "filter", filter)

	query := client.Event.Query()

	// Apply base filters (status only, no pagination/sorting)
	query = ApplyBaseFilters(ctx, query, filter, r.queryOpts)

	// Apply entity-specific filters (note: original didn't apply these, adding for consistency)
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithHint("Failed to count events").
			WithReportableDetails(map[string]any{
				"filter": filter,
			}).
			Mark(ierr.ErrDatabase)
	}

	return count, nil
}

func (r *EventRepository) Update(ctx context.Context, e *domain.Event) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating event",
		"event_id", e.ID,
		"slug", e.Slug,
	)

	update := client.Event.UpdateOneID(e.ID).
		SetType(string(e.Type)).
		SetTitle(e.Title).
		SetStartDate(e.StartDate).
		SetStatus(string(e.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if e.Subtitle != nil {
		update = update.SetSubtitle(*e.Subtitle)
	} else {
		update = update.ClearSubtitle()
	}
	if e.Description != nil {
		update = update.SetDescription(*e.Description)
	} else {
		update = update.ClearDescription()
	}
	if e.PlaceID != nil {
		update = update.SetPlaceID(*e.PlaceID)
	} else {
		update = update.ClearPlaceID()
	}
	if e.EndDate != nil {
		update = update.SetEndDate(*e.EndDate)
	} else {
		update = update.ClearEndDate()
	}
	if e.CoverImageURL != nil {
		update = update.SetCoverImageURL(*e.CoverImageURL)
	} else {
		update = update.ClearCoverImageURL()
	}
	if len(e.Images) > 0 {
		update = update.SetImages(e.Images)
	} else {
		update = update.ClearImages()
	}
	if len(e.Tags) > 0 {
		update = update.SetTags(e.Tags)
	} else {
		update = update.ClearTags()
	}
	if e.Metadata != nil {
		update = update.SetMetadata(e.Metadata.ToMap())
	} else {
		update = update.ClearMetadata()
	}
	if e.Latitude != nil {
		update = update.SetLatitude(e.Latitude)
	} else {
		update = update.ClearLatitude()
	}
	if e.Longitude != nil {
		update = update.SetLongitude(e.Longitude)
	} else {
		update = update.ClearLongitude()
	}
	if e.LocationName != nil {
		update = update.SetLocationName(*e.LocationName)
	} else {
		update = update.ClearLocationName()
	}

	// Note: Stats (ViewCount, InterestedCount) are updated via separate methods

	_, err := update.Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Event with ID %s was not found", e.ID).
				WithReportableDetails(map[string]any{
					"event_id": e.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Event with this slug already exists").
				WithReportableDetails(map[string]any{
					"event_id": e.ID,
					"slug":     e.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to update event").
			WithReportableDetails(map[string]any{
				"event_id": e.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *EventRepository) Delete(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting event (soft)", "event_id", id)

	_, err := client.Event.UpdateOneID(id).
		SetStatus(string(types.StatusArchived)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Event with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"event_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete event").
			WithReportableDetails(map[string]any{
				"event_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// ========== EventOccurrence CRUD ==========

func (r *EventRepository) CreateOccurrence(ctx context.Context, occ *domain.EventOccurrence) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating event occurrence",
		"occurrence_id", occ.ID,
		"event_id", occ.EventID,
		"recurrence_type", occ.RecurrenceType,
	)

	now := time.Now().UTC()
	create := client.EventOccurrence.Create().
		SetID(occ.ID).
		SetEventID(occ.EventID).
		SetRecurrenceType(string(occ.RecurrenceType)).
		SetStatus(string(occ.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

	if occ.StartTime != nil {
		create = create.SetStartTime(*occ.StartTime)
	}
	if occ.EndTime != nil {
		create = create.SetEndTime(*occ.EndTime)
	}
	if occ.DurationMinutes != nil {
		create = create.SetDurationMinutes(*occ.DurationMinutes)
	}
	if occ.DayOfWeek != nil {
		create = create.SetDayOfWeek(*occ.DayOfWeek)
	}
	if occ.DayOfMonth != nil {
		create = create.SetDayOfMonth(*occ.DayOfMonth)
	}
	if occ.MonthOfYear != nil {
		create = create.SetMonthOfYear(*occ.MonthOfYear)
	}
	if len(occ.ExceptionDates) > 0 {
		create = create.SetExceptionDates(occ.ExceptionDates)
	}
	if occ.Metadata != nil {
		create = create.SetMetadata(occ.Metadata.ToMap())
	}

	_, err := create.Save(ctx)

	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to create event occurrence").
			WithReportableDetails(map[string]any{
				"occurrence_id": occ.ID,
				"event_id":      occ.EventID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *EventRepository) GetOccurrence(ctx context.Context, id string) (*domain.EventOccurrence, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting event occurrence", "occurrence_id", id)

	entOcc, err := client.EventOccurrence.Query().
		Where(eventoccurrence.ID(id)).
		WithEvent().
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Event occurrence with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"occurrence_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get event occurrence").
			WithReportableDetails(map[string]any{
				"occurrence_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.OccurrenceFromEnt(entOcc), nil
}

func (r *EventRepository) ListOccurrences(ctx context.Context, filter *types.OccurrenceFilter) ([]*domain.EventOccurrence, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("listing occurrences",
		"event_id", filter.EventID,
		"limit", filter.GetLimit(),
		"offset", filter.GetOffset(),
	)

	query := client.EventOccurrence.Query()

	// Apply status filter (default: only published)
	if filter.Status != nil {
		query = query.Where(eventoccurrence.StatusEQ(string(*filter.Status)))
	} else {
		query = query.Where(eventoccurrence.StatusEQ(string(types.StatusPublished)))
	}

	// Filter by event ID if specified
	if filter.EventID != nil {
		query = query.Where(eventoccurrence.EventID(*filter.EventID))
	}

	// Apply pagination
	query = query.
		Offset(filter.GetOffset()).
		Limit(filter.GetLimit())

	// Apply sorting (default: by ID for consistent ordering)
	query = query.Order(ent.Asc(eventoccurrence.FieldID))

	occurrences, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to list event occurrences").
			WithReportableDetails(map[string]any{
				"event_id": filter.EventID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.OccurrenceFromEntList(occurrences), nil
}

// ListOccurrencesByEvent lists occurrences for a specific event
// Deprecated: Use ListOccurrences with filter instead
func (r *EventRepository) ListOccurrencesByEvent(ctx context.Context, eventID string) ([]*domain.EventOccurrence, error) {
	// Delegate to ListOccurrences with filter
	filter := &types.OccurrenceFilter{
		QueryFilter: types.NewDefaultQueryFilter(),
		EventID:     &eventID,
	}
	return r.ListOccurrences(ctx, filter)
}

func (r *EventRepository) UpdateOccurrence(ctx context.Context, occ *domain.EventOccurrence) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating event occurrence",
		"occurrence_id", occ.ID,
		"event_id", occ.EventID,
	)

	update := client.EventOccurrence.UpdateOneID(occ.ID).
		SetRecurrenceType(string(occ.RecurrenceType)).
		SetStatus(string(occ.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if occ.StartTime != nil {
		update = update.SetStartTime(*occ.StartTime)
	} else {
		update = update.ClearStartTime()
	}
	if occ.EndTime != nil {
		update = update.SetEndTime(*occ.EndTime)
	} else {
		update = update.ClearEndTime()
	}
	if occ.DurationMinutes != nil {
		update = update.SetDurationMinutes(*occ.DurationMinutes)
	} else {
		update = update.ClearDurationMinutes()
	}
	if occ.DayOfWeek != nil {
		update = update.SetDayOfWeek(*occ.DayOfWeek)
	} else {
		update = update.ClearDayOfWeek()
	}
	if occ.DayOfMonth != nil {
		update = update.SetDayOfMonth(*occ.DayOfMonth)
	} else {
		update = update.ClearDayOfMonth()
	}
	if occ.MonthOfYear != nil {
		update = update.SetMonthOfYear(*occ.MonthOfYear)
	} else {
		update = update.ClearMonthOfYear()
	}
	if len(occ.ExceptionDates) > 0 {
		update = update.SetExceptionDates(occ.ExceptionDates)
	} else {
		update = update.ClearExceptionDates()
	}
	if occ.Metadata != nil {
		update = update.SetMetadata(occ.Metadata.ToMap())
	} else {
		update = update.ClearMetadata()
	}

	_, err := update.Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Event occurrence with ID %s was not found", occ.ID).
				WithReportableDetails(map[string]any{
					"occurrence_id": occ.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to update event occurrence").
			WithReportableDetails(map[string]any{
				"occurrence_id": occ.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *EventRepository) DeleteOccurrence(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting event occurrence (soft)", "occurrence_id", id)

	_, err := client.EventOccurrence.UpdateOneID(id).
		SetStatus(string(types.StatusArchived)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Event occurrence with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"occurrence_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete event occurrence").
			WithReportableDetails(map[string]any{
				"occurrence_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// ========== Stats Methods ==========

func (r *EventRepository) IncrementViewCount(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("incrementing event view count", "event_id", id)

	_, err := client.Event.UpdateOneID(id).
		AddViewCount(1).
		SetUpdatedAt(time.Now().UTC()).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Event with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"event_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to increment view count").
			WithReportableDetails(map[string]any{
				"event_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *EventRepository) IncrementInterestedCount(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("incrementing event interested count", "event_id", id)

	_, err := client.Event.UpdateOneID(id).
		AddInterestedCount(1).
		SetUpdatedAt(time.Now().UTC()).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Event with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"event_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to increment interested count").
			WithReportableDetails(map[string]any{
				"event_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// ========== Query Options ==========

// EventQuery type alias for better readability
type EventQuery = *ent.EventQuery

// EventQueryOptions implements query options for event queries
type EventQueryOptions struct{}

// Ensure EventQueryOptions implements BaseQueryOptions interface
var _ BaseQueryOptions[EventQuery] = (*EventQueryOptions)(nil)

func (o EventQueryOptions) ApplyStatusFilter(query EventQuery, status string) EventQuery {
	if status == "" {
		// By default, exclude archived and deleted items from queries
		// Archived can be restored, deleted is permanent
		return query.Where(event.StatusNotIn(string(types.StatusArchived), string(types.StatusDeleted)))
	}
	return query.Where(event.Status(status))
}

func (o EventQueryOptions) ApplySortFilter(query EventQuery, field string, order string) EventQuery {
	// Validate order
	if order != types.OrderAsc && order != types.OrderDesc {
		order = types.OrderDesc
	}
	// Default field if empty
	if field == "" {
		field = "created_at"
	}

	fieldName := o.GetFieldName(field)

	// Apply sorting with secondary sort by ID for consistency
	if order == types.OrderDesc {
		return query.Order(ent.Desc(fieldName), ent.Asc(event.FieldID))
	}
	return query.Order(ent.Asc(fieldName), ent.Asc(event.FieldID))
}

func (o EventQueryOptions) ApplyPaginationFilter(query EventQuery, limit int, offset int) EventQuery {
	// Validate pagination values
	if limit <= 0 {
		limit = 20 // Default limit
	}
	if offset < 0 {
		offset = 0
	}
	if limit > 1000 {
		limit = 1000
	}

	return query.Offset(offset).Limit(limit)
}

func (o EventQueryOptions) GetFieldName(field string) string {
	switch field {
	case "created_at":
		return event.FieldCreatedAt
	case "updated_at":
		return event.FieldUpdatedAt
	case "date_asc", "start_date":
		return event.FieldStartDate
	case "date_desc", "end_date":
		return event.FieldStartDate
	case "views_desc", "view_count":
		return event.FieldViewCount
	case "interested_desc", "interested_count":
		return event.FieldInterestedCount
	case "title":
		return event.FieldTitle
	default:
		return event.FieldStartDate // Default to start date
	}
}

func (o EventQueryOptions) ApplyEntityQueryOptions(
	_ context.Context,
	f *types.EventFilter,
	query EventQuery,
) EventQuery {
	if f == nil {
		return query
	}

	// Type filter
	if f.Type != nil {
		query = query.Where(event.TypeEQ(string(*f.Type)))
	}

	// Place filter
	if f.PlaceID != nil {
		query = query.Where(event.PlaceID(*f.PlaceID))
	}

	// Date range filter - using FromDate and ToDate from filter (string format)
	if f.FromDate != nil {
		// Parse ISO date string to time.Time
		fromDate, err := time.Parse("2006-01-02", *f.FromDate)
		if err == nil {
			query = query.Where(event.StartDateGTE(fromDate))
		}
	}
	if f.ToDate != nil {
		toDate, err := time.Parse("2006-01-02", *f.ToDate)
		if err == nil {
			query = query.Where(event.Or(
				event.EndDateIsNil(),
				event.EndDateLTE(toDate),
			))
		}
	}

	// Tags filter - check if event has any of the requested tags
	// PostgreSQL JSONB @> operator: checks if left array contains right array element
	if len(f.Tags) > 0 {
		// Build OR predicates for each tag
		tagPredicates := make([]predicate.Event, 0, len(f.Tags))
		for _, tag := range f.Tags {
			// Convert single tag to JSON array format: ["tag"]
			tagJSON, err := json.Marshal([]string{tag})
			if err == nil {
				// Use SQL function syntax: tags @> '["tag"]'::jsonb
				tagPredicates = append(tagPredicates, predicate.Event(func(s *entsql.Selector) {
					s.Where(entsql.P(func(b *entsql.Builder) {
						b.WriteString("tags @> ")
						b.WriteString("'")
						b.WriteString(string(tagJSON))
						b.WriteString("'::jsonb")
					}))
				}))
			}
		}
		// Apply OR condition - event must have at least one of the tags
		if len(tagPredicates) > 0 {
			query = query.Where(event.Or(tagPredicates...))
		}
	}

	return query
}
