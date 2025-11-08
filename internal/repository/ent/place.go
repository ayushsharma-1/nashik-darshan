package ent

import (
	"context"
	"fmt"
	"time"

	entsql "entgo.io/ent/dialect/sql"
	"github.com/lib/pq"
	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/place"
	"github.com/omkar273/nashikdarshan/ent/placeimage"
	"github.com/omkar273/nashikdarshan/ent/predicate"
	domain "github.com/omkar273/nashikdarshan/internal/domain/place"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type PlaceRepository struct {
	client    postgres.IClient
	log       logger.Logger
	queryOpts PlaceQueryOptions
}

func NewPlaceRepository(client postgres.IClient, logger *logger.Logger) domain.Repository {
	return &PlaceRepository{
		client:    client,
		log:       *logger,
		queryOpts: PlaceQueryOptions{},
	}
}

func (r *PlaceRepository) Create(ctx context.Context, p *domain.Place) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating place",
		"place_id", p.ID,
		"slug", p.Slug,
		"title", p.Title,
		"place_type", p.PlaceType,
	)

	create := client.Place.Create().
		SetID(p.ID).
		SetSlug(p.Slug).
		SetTitle(p.Title).
		SetPlaceType(p.PlaceType).
		SetLocation(p.Location).
		SetStatus(string(p.Status)).
		SetCreatedAt(p.CreatedAt).
		SetUpdatedAt(p.UpdatedAt).
		SetCreatedBy(p.CreatedBy).
		SetUpdatedBy(p.UpdatedBy)

	if p.Subtitle != nil {
		create = create.SetSubtitle(*p.Subtitle)
	}
	if p.ShortDescription != nil {
		create = create.SetShortDescription(*p.ShortDescription)
	}
	if p.LongDescription != nil {
		create = create.SetLongDescription(*p.LongDescription)
	}
	if len(p.Categories) > 0 {
		create = create.SetCategories(p.Categories)
	}
	if p.Address != nil && len(p.Address) > 0 {
		create = create.SetAddress(p.Address)
	}
	if p.PrimaryImageURL != nil {
		create = create.SetPrimaryImageURL(*p.PrimaryImageURL)
	}
	if p.ThumbnailURL != nil {
		create = create.SetThumbnailURL(*p.ThumbnailURL)
	}
	if len(p.Amenities) > 0 {
		create = create.SetAmenities(p.Amenities)
	}

	_, err := create.Save(ctx)

	if err != nil {
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Place with this slug already exists").
				WithReportableDetails(map[string]any{
					"place_id": p.ID,
					"slug":     p.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to create place").
			WithReportableDetails(map[string]any{
				"place_id": p.ID,
				"slug":     p.Slug,
				"title":    p.Title,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *PlaceRepository) Get(ctx context.Context, id string) (*domain.Place, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting place", "place_id", id)

	entPlace, err := client.Place.Query().
		Where(place.ID(id)).
		WithImages().
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Place with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"place_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get place").
			WithReportableDetails(map[string]any{
				"place_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entPlace), nil
}

func (r *PlaceRepository) GetBySlug(ctx context.Context, slug string) (*domain.Place, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting place by slug", "slug", slug)

	entPlace, err := client.Place.Query().
		Where(place.Slug(slug)).
		WithImages().
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Place with slug %s was not found", slug).
				WithReportableDetails(map[string]any{
					"slug": slug,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get place by slug").
			WithReportableDetails(map[string]any{
				"slug": slug,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entPlace), nil
}

func (r *PlaceRepository) List(ctx context.Context, filter *types.PlaceFilter) ([]*domain.Place, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("listing places",
		"limit", filter.GetLimit(),
		"offset", filter.GetOffset(),
	)

	query := client.Place.Query()
	query = r.queryOpts.ApplyBaseFilters(ctx, query, filter)
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	// Load images if expand includes images
	if filter != nil && filter.GetExpand().Has("images") {
		query = query.WithImages()
	}

	places, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to list places").
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEntList(places), nil
}

func (r *PlaceRepository) ListAll(ctx context.Context, filter *types.PlaceFilter) ([]*domain.Place, error) {
	if filter == nil {
		filter = types.NewNoLimitPlaceFilter()
	}

	if filter.QueryFilter == nil {
		filter.QueryFilter = types.NewNoLimitQueryFilter()
	}

	places, err := r.List(ctx, filter)
	if err != nil {
		return nil, err
	}
	return places, nil
}

func (r *PlaceRepository) Count(ctx context.Context, filter *types.PlaceFilter) (int, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("counting places")

	query := client.Place.Query()
	query = r.queryOpts.ApplyBaseFilters(ctx, query, filter)
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithHint("Failed to count places").
			Mark(ierr.ErrDatabase)
	}

	return count, nil
}

func (r *PlaceRepository) Update(ctx context.Context, p *domain.Place) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating place",
		"place_id", p.ID,
		"slug", p.Slug,
		"title", p.Title,
	)

	update := client.Place.UpdateOneID(p.ID).
		SetSlug(p.Slug).
		SetTitle(p.Title).
		SetPlaceType(p.PlaceType).
		SetLocation(p.Location).
		SetStatus(string(p.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if p.Subtitle != nil {
		update = update.SetSubtitle(*p.Subtitle)
	} else {
		update = update.ClearSubtitle()
	}
	if p.ShortDescription != nil {
		update = update.SetShortDescription(*p.ShortDescription)
	} else {
		update = update.ClearShortDescription()
	}
	if p.LongDescription != nil {
		update = update.SetLongDescription(*p.LongDescription)
	} else {
		update = update.ClearLongDescription()
	}
	if len(p.Categories) > 0 {
		update = update.SetCategories(p.Categories)
	} else {
		update = update.ClearCategories()
	}
	if p.Address != nil && len(p.Address) > 0 {
		update = update.SetAddress(p.Address)
	} else {
		update = update.ClearAddress()
	}
	if p.PrimaryImageURL != nil {
		update = update.SetPrimaryImageURL(*p.PrimaryImageURL)
	} else {
		update = update.ClearPrimaryImageURL()
	}
	if p.ThumbnailURL != nil {
		update = update.SetThumbnailURL(*p.ThumbnailURL)
	} else {
		update = update.ClearThumbnailURL()
	}
	if len(p.Amenities) > 0 {
		update = update.SetAmenities(p.Amenities)
	} else {
		update = update.ClearAmenities()
	}

	_, err := update.Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Place with ID %s was not found", p.ID).
				WithReportableDetails(map[string]any{
					"place_id": p.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Place with this slug already exists").
				WithReportableDetails(map[string]any{
					"place_id": p.ID,
					"slug":     p.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to update place").
			WithReportableDetails(map[string]any{
				"place_id": p.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *PlaceRepository) Delete(ctx context.Context, p *domain.Place) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting place",
		"place_id", p.ID,
	)

	_, err := client.Place.UpdateOneID(p.ID).
		SetStatus(string(types.StatusDeleted)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Place with ID %s was not found", p.ID).
				WithReportableDetails(map[string]any{
					"place_id": p.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete place").
			WithReportableDetails(map[string]any{
				"place_id": p.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *PlaceRepository) AddImage(ctx context.Context, image *domain.PlaceImage) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("adding place image",
		"image_id", image.ID,
		"place_id", image.PlaceID,
	)

	create := client.PlaceImage.Create().
		SetID(image.ID).
		SetPlaceID(image.PlaceID).
		SetURL(image.URL).
		SetPos(image.Pos).
		SetStatus(string(image.Status)).
		SetCreatedAt(image.CreatedAt).
		SetUpdatedAt(image.UpdatedAt).
		SetCreatedBy(image.CreatedBy).
		SetUpdatedBy(image.UpdatedBy)

	if image.Alt != "" {
		create = create.SetAlt(image.Alt)
	}
	if image.Metadata != nil && len(image.Metadata.ToMap()) > 0 {
		create = create.SetMetadata(image.Metadata.ToMap())
	}

	_, err := create.Save(ctx)

	if err != nil {
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Place image with this ID already exists").
				WithReportableDetails(map[string]any{
					"image_id": image.ID,
					"place_id": image.PlaceID,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to add place image").
			WithReportableDetails(map[string]any{
				"image_id": image.ID,
				"place_id": image.PlaceID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *PlaceRepository) GetImages(ctx context.Context, placeID string) ([]*domain.PlaceImage, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting place images", "place_id", placeID)

	images, err := client.PlaceImage.Query().
		Where(placeimage.PlaceID(placeID)).
		Order(ent.Asc(placeimage.FieldPos)).
		All(ctx)

	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to get place images").
			WithReportableDetails(map[string]any{
				"place_id": placeID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEntImageList(images), nil
}

func (r *PlaceRepository) UpdateImage(ctx context.Context, image *domain.PlaceImage) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating place image",
		"image_id", image.ID,
		"place_id", image.PlaceID,
	)

	update := client.PlaceImage.UpdateOneID(image.ID).
		SetURL(image.URL).
		SetPos(image.Pos).
		SetStatus(string(image.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if image.Alt != "" {
		update = update.SetAlt(image.Alt)
	} else {
		update = update.ClearAlt()
	}
	if image.Metadata != nil {
		update = update.SetMetadata(image.Metadata.ToMap())
	}

	_, err := update.Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Place image with ID %s was not found", image.ID).
				WithReportableDetails(map[string]any{
					"image_id": image.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to update place image").
			WithReportableDetails(map[string]any{
				"image_id": image.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *PlaceRepository) DeleteImage(ctx context.Context, imageID string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting place image", "image_id", imageID)

	_, err := client.PlaceImage.UpdateOneID(imageID).
		SetStatus(string(types.StatusDeleted)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Place image with ID %s was not found", imageID).
				WithReportableDetails(map[string]any{
					"image_id": imageID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete place image").
			WithReportableDetails(map[string]any{
				"image_id": imageID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// PlaceQuery type alias for better readability
type PlaceQuery = *ent.PlaceQuery

// PlaceQueryOptions implements query options for place queries
type PlaceQueryOptions struct {
	QueryOptionsHelper
}

// Ensure PlaceQueryOptions implements EntityQueryOptions interface
var _ EntityQueryOptions[PlaceQuery, *types.PlaceFilter] = (*PlaceQueryOptions)(nil)

func (o PlaceQueryOptions) ApplyStatusFilter(query PlaceQuery, status string) PlaceQuery {
	if status == "" {
		return query.Where(place.StatusNotIn(string(types.StatusDeleted)))
	}
	return query.Where(place.Status(status))
}

func (o PlaceQueryOptions) ApplySortFilter(query PlaceQuery, field string, order string) PlaceQuery {
	field, order = o.ValidateSort(field, order)
	fieldName := o.GetFieldName(field)
	if order == types.OrderDesc {
		return query.Order(ent.Desc(fieldName))
	}
	return query.Order(ent.Asc(fieldName))
}

func (o PlaceQueryOptions) ApplyPaginationFilter(query PlaceQuery, limit int, offset int) PlaceQuery {
	limit, offset = o.ValidatePagination(limit, offset)
	return query.Offset(offset).Limit(limit)
}

func (o PlaceQueryOptions) GetFieldName(field string) string {
	switch field {
	case "created_at":
		return place.FieldCreatedAt
	case "updated_at":
		return place.FieldUpdatedAt
	case "title":
		return place.FieldTitle
	case "slug":
		return place.FieldSlug
	case "place_type":
		return place.FieldPlaceType
	default:
		return field
	}
}

func (o PlaceQueryOptions) ApplyBaseFilters(
	_ context.Context,
	query PlaceQuery,
	filter *types.PlaceFilter,
) PlaceQuery {
	if filter == nil {
		return query.Where(place.StatusNotIn(string(types.StatusDeleted)))
	}

	// Apply status filter
	query = o.ApplyStatusFilter(query, filter.GetStatus())

	// Apply pagination
	if !filter.IsUnlimited() {
		query = o.ApplyPaginationFilter(query, filter.GetLimit(), filter.GetOffset())
	}

	// Apply sorting
	query = o.ApplySortFilter(query, filter.GetSort(), filter.GetOrder())

	return query
}

func (o PlaceQueryOptions) ApplyEntityQueryOptions(
	_ context.Context,
	f *types.PlaceFilter,
	query PlaceQuery,
) PlaceQuery {
	if f == nil {
		return query
	}

	// Apply slug filter if specified
	if len(f.Slug) > 0 {
		query = query.Where(place.SlugIn(f.Slug...))
	}

	// Apply place types filter if specified
	if len(f.PlaceTypes) > 0 {
		query = query.Where(place.PlaceTypeIn(f.PlaceTypes...))
	}

	// Apply categories filter if specified
	// PostgreSQL array overlap operator: && (returns true if arrays have any elements in common)
	if len(f.Categories) > 0 {
		// Use raw SQL predicate for array overlap
		query = query.Where(predicate.Place(func(s *entsql.Selector) {
			s.Where(entsql.ExprP("categories && ?", pq.Array(f.Categories)))
		}))
	}

	// Apply amenities filter if specified
	// PostgreSQL array overlap operator: && (returns true if arrays have any elements in common)
	if len(f.Amenities) > 0 {
		// Use raw SQL predicate for array overlap
		query = query.Where(predicate.Place(func(s *entsql.Selector) {
			s.Where(entsql.ExprP("amenities && ?", pq.Array(f.Amenities)))
		}))
	}

	// Apply rating filters if specified
	// Note: Rating is not stored in Place entity, so this would need to be handled
	// via a join with a ratings table or calculated field
	// For now, we'll skip this as it's not in the schema

	// Apply search query if specified
	if f.SearchQuery != nil && *f.SearchQuery != "" {
		query = query.Where(
			place.Or(
				place.TitleContainsFold(*f.SearchQuery),
				place.SlugContainsFold(*f.SearchQuery),
				place.ShortDescriptionContainsFold(*f.SearchQuery),
			),
		)
	}

	// Apply geospatial filters if specified
	if f.Latitude != nil && f.Longitude != nil && f.RadiusKM != nil {
		// Convert radius from km to meters for PostGIS
		radiusMeters := *f.RadiusKM * 1000

		// Create point WKT for the center location
		centerPoint := fmt.Sprintf("POINT(%f %f)", *f.Longitude, *f.Latitude)

		// Add PostGIS ST_DWithin condition to filter places within radius
		query = query.Where(predicate.Place(func(s *entsql.Selector) {
			s.Where(entsql.ExprP(
				"ST_DWithin(location::geography, ST_GeogFromText(?)::geography, ?)",
				centerPoint,
				radiusMeters,
			))
		}))

		// Add custom ordering by distance (closest first)
		// Using PostGIS distance operator <-> for efficient distance-based ordering
		query = query.Order(place.OrderOption(func(s *entsql.Selector) {
			s.OrderExpr(entsql.ExprP(
				"location::geography <-> ST_GeogFromText(?)::geography ASC",
				centerPoint,
			))
		}))
	}

	// Apply time range filters if specified
	if f.TimeRangeFilter != nil {
		if f.StartTime != nil {
			query = query.Where(place.CreatedAtGTE(*f.StartTime))
		}
		if f.EndTime != nil {
			query = query.Where(place.CreatedAtLTE(*f.EndTime))
		}
	}

	return query
}
