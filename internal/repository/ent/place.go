package ent

import (
	"context"
	"math"
	"sort"
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/place"
	"github.com/omkar273/nashikdarshan/ent/placeimage"
	domain "github.com/omkar273/nashikdarshan/internal/domain/place"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

const (
	// Earth radius in meters (WGS84)
	earthRadiusM = 6371000.0
	// Meters per degree at equator
	metersPerDegreeLat = 111320.0
)

// calculateBoundingBox calculates bounding box deltas for a given center point and radius
// Returns: minLat, maxLat, minLng, maxLng
func calculateBoundingBox(lat0, lng0, radiusM decimal.Decimal) (decimal.Decimal, decimal.Decimal, decimal.Decimal, decimal.Decimal) {
	// Latitude delta (degrees) - constant regardless of location
	deltaLat := radiusM.Div(decimal.NewFromFloat(metersPerDegreeLat))

	// Longitude delta (degrees) - varies by latitude
	lat0Rad := lat0.Mul(decimal.NewFromFloat(math.Pi / 180.0))
	cosLat0 := decimal.NewFromFloat(math.Cos(lat0Rad.InexactFloat64()))
	deltaLng := radiusM.Div(decimal.NewFromFloat(metersPerDegreeLat).Mul(cosLat0))

	minLat := lat0.Sub(deltaLat)
	maxLat := lat0.Add(deltaLat)
	minLng := lng0.Sub(deltaLng)
	maxLng := lng0.Add(deltaLng)

	return minLat, maxLat, minLng, maxLng
}

// haversineDistance calculates distance between two points using Haversine formula
// Returns distance in meters
func haversineDistance(lat1, lng1, lat2, lng2 decimal.Decimal) float64 {
	lat1Rad := lat1.Mul(decimal.NewFromFloat(math.Pi / 180.0)).InexactFloat64()
	lng1Rad := lng1.Mul(decimal.NewFromFloat(math.Pi / 180.0)).InexactFloat64()
	lat2Rad := lat2.Mul(decimal.NewFromFloat(math.Pi / 180.0)).InexactFloat64()
	lng2Rad := lng2.Mul(decimal.NewFromFloat(math.Pi / 180.0)).InexactFloat64()

	dlat := lat2Rad - lat1Rad
	dlng := lng2Rad - lng1Rad

	a := math.Sin(dlat/2)*math.Sin(dlat/2) +
		math.Cos(lat1Rad)*math.Cos(lat2Rad)*
			math.Sin(dlng/2)*math.Sin(dlng/2)

	c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))

	return earthRadiusM * c
}

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

	now := time.Now().UTC()
	create := client.Place.Create().
		SetID(p.ID).
		SetSlug(p.Slug).
		SetTitle(p.Title).
		SetPlaceType(string(p.PlaceType)).
		SetLatitude(p.Location.Latitude).
		SetLongitude(p.Location.Longitude).
		SetStatus(string(p.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

	if p.Subtitle != nil {
		create = create.SetSubtitle(*p.Subtitle)
	}
	if p.ShortDescription != nil {
		create = create.SetShortDescription(*p.ShortDescription)
	}
	if p.LongDescription != nil {
		create = create.SetLongDescription(*p.LongDescription)
	}
	if len(p.Address) > 0 {
		create = create.SetAddress(p.Address)
	}
	if p.PrimaryImageURL != nil {
		create = create.SetPrimaryImageURL(*p.PrimaryImageURL)
	}
	if p.ThumbnailURL != nil {
		create = create.SetThumbnailURL(*p.ThumbnailURL)
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
		Where(
			place.Slug(slug),
			place.Status(string(types.StatusPublished)),
		).
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

	// Apply entity-specific filters first
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	// Apply common query options (status, pagination, sorting)
	query = ApplyQueryOptions(ctx, query, filter, r.queryOpts)

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

	// Convert to domain models
	domainPlaces := domain.FromEntList(places)

	// If geospatial query, apply distance filtering and sorting
	hasGeospatialQuery := filter != nil && filter.Latitude != nil && filter.Longitude != nil && filter.RadiusM != nil
	if hasGeospatialQuery {
		lat0 := *filter.Latitude
		lng0 := *filter.Longitude
		radiusM := *filter.RadiusM

		// Calculate distances and filter by exact radius
		type placeWithDistance struct {
			place    *domain.Place
			distance float64
		}

		placesWithDist := make([]placeWithDistance, 0, len(domainPlaces))
		for _, p := range domainPlaces {
			dist := haversineDistance(lat0, lng0, p.Location.Latitude, p.Location.Longitude)
			if dist <= radiusM.InexactFloat64() {
				placesWithDist = append(placesWithDist, placeWithDistance{
					place:    p,
					distance: dist,
				})
			}
		}

		// Sort by distance ASC, then ID ASC
		sort.Slice(placesWithDist, func(i, j int) bool {
			if placesWithDist[i].distance != placesWithDist[j].distance {
				return placesWithDist[i].distance < placesWithDist[j].distance
			}
			return placesWithDist[i].place.ID < placesWithDist[j].place.ID
		})

		// Apply pagination (offset and limit)
		offset := filter.GetOffset()
		limit := filter.GetLimit()
		start := offset
		end := offset + limit
		if start > len(placesWithDist) {
			start = len(placesWithDist)
		}
		if end > len(placesWithDist) {
			end = len(placesWithDist)
		}

		// Extract places
		result := make([]*domain.Place, 0, end-start)
		for i := start; i < end; i++ {
			result = append(result, placesWithDist[i].place)
		}

		return result, nil
	}

	return domainPlaces, nil
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

	// Apply base filters (status only, no pagination/sorting)
	query = ApplyBaseFilters(ctx, query, filter, r.queryOpts)

	// Apply entity-specific filters
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithHint("Failed to count places").
			WithReportableDetails(map[string]any{
				"filter": filter,
			}).
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
		SetTitle(p.Title).
		SetLatitude(p.Location.Latitude).
		SetLongitude(p.Location.Longitude).
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
	if len(p.Address) > 0 {
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
		SetStatus(string(types.StatusArchived)).
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

	now := time.Now().UTC()
	create := client.PlaceImage.Create().
		SetID(image.ID).
		SetPlaceID(image.PlaceID).
		SetURL(image.URL).
		SetPos(image.Pos).
		SetStatus(string(image.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

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

func (r *PlaceRepository) GetImage(ctx context.Context, imageID string) (*domain.PlaceImage, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting place image", "image_id", imageID)

	entImage, err := client.PlaceImage.Query().
		Where(placeimage.ID(imageID)).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Place image with ID %s was not found", imageID).
				WithReportableDetails(map[string]any{
					"image_id": imageID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get place image").
			WithReportableDetails(map[string]any{
				"image_id": imageID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEntImage(entImage), nil
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
		SetStatus(string(types.StatusArchived)).
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
type PlaceQueryOptions struct{}

// Ensure PlaceQueryOptions implements BaseQueryOptions interface
var _ BaseQueryOptions[PlaceQuery] = (*PlaceQueryOptions)(nil)

func (o PlaceQueryOptions) ApplyStatusFilter(query PlaceQuery, status string) PlaceQuery {
	if status == "" {
		return query.Where(place.StatusNotIn(string(types.StatusDeleted)))
	}
	return query.Where(place.Status(status))
}

func (o PlaceQueryOptions) ApplySortFilter(query PlaceQuery, field string, order string) PlaceQuery {
	// Validate order
	if order != types.OrderAsc && order != types.OrderDesc {
		order = types.OrderDesc
	}
	// Default field if empty
	if field == "" {
		field = "created_at"
	}

	fieldName := o.GetFieldName(field)
	if order == types.OrderDesc {
		return query.Order(ent.Desc(fieldName))
	}
	return query.Order(ent.Asc(fieldName))
}

func (o PlaceQueryOptions) ApplyPaginationFilter(query PlaceQuery, limit int, offset int) PlaceQuery {
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
	if f.Latitude != nil && f.Longitude != nil && f.RadiusM != nil {
		lat0 := *f.Latitude
		lng0 := *f.Longitude
		radiusM := *f.RadiusM

		// Step 1: Bounding box prefilter (shrink search space)
		minLat, maxLat, minLng, maxLng := calculateBoundingBox(lat0, lng0, radiusM)

		// Apply bounding box filter (convert decimal to float64 for ent predicates)
		query = query.Where(
			place.And(
				place.LatitudeGTE(minLat),
				place.LatitudeLTE(maxLat),
				place.LongitudeGTE(minLng),
				place.LongitudeLTE(maxLng),
			),
		)

		// Note: Exact distance filtering and sorting are handled in the List method
		// after fetching results, since we need to calculate Haversine distances in Go
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

	// Apply trending filter (last viewed after)
	if f.LastViewedAfter != nil {
		query = query.Where(place.LastViewedAtGTE(*f.LastViewedAfter))
	}

	return query
}

// Feed-specific methods for engagement tracking and trending queries

// IncrementViewCount increments the view count for a place and updates last_viewed_at
func (r *PlaceRepository) IncrementViewCount(ctx context.Context, placeID string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("incrementing view count", "place_id", placeID)

	now := time.Now().UTC()
	_, err := client.Place.UpdateOneID(placeID).
		AddViewCount(1).
		SetLastViewedAt(now).
		SetUpdatedAt(now).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to increment view count").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// UpdateRating updates the rating for a place (recalculates average and increments count)
func (r *PlaceRepository) UpdateRating(ctx context.Context, placeID string, newRating decimal.Decimal) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating place rating",
		"place_id", placeID,
		"new_rating", newRating.String())

	// Get current place to calculate new average
	currentPlace, err := client.Place.Get(ctx, placeID)
	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to get place for rating update").
			Mark(ierr.ErrDatabase)
	}

	// Calculate new rating average
	currentCount := currentPlace.RatingCount
	currentAvg := currentPlace.RatingAvg

	newCount := currentCount + 1
	newAvg := currentAvg.Mul(decimal.NewFromInt(int64(currentCount))).
		Add(newRating).
		Div(decimal.NewFromInt(int64(newCount)))

	now := time.Now().UTC()
	_, err = client.Place.UpdateOneID(placeID).
		SetRatingAvg(newAvg).
		SetRatingCount(newCount).
		SetUpdatedAt(now).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to update place rating").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// UpdatePopularityScore updates the popularity score for a place
func (r *PlaceRepository) UpdatePopularityScore(ctx context.Context, placeID string, score decimal.Decimal) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating popularity score",
		"place_id", placeID,
		"score", score.String())

	now := time.Now().UTC()
	_, err := client.Place.UpdateOneID(placeID).
		SetPopularityScore(score).
		SetUpdatedAt(now).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to update popularity score").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// AssignCategories assigns categories to a place by replacing existing category relationships
func (r *PlaceRepository) AssignCategories(ctx context.Context, placeID string, categoryIDs []string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("assigning categories to place",
		"place_id", placeID,
		"category_count", len(categoryIDs),
	)

	now := time.Now().UTC()

	_, err := client.Place.UpdateOneID(placeID).
		ClearCategory().
		AddCategoryIDs(categoryIDs...).
		SetUpdatedAt(now).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Place with ID %s was not found", placeID).
				WithReportableDetails(map[string]any{
					"place_id": placeID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to assign categories to place").
			WithReportableDetails(map[string]any{
				"place_id":     placeID,
				"category_ids": categoryIDs,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}
