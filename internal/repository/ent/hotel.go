package ent

import (
	"context"
	"sort"
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/hotel"
	domain "github.com/omkar273/nashikdarshan/internal/domain/hotel"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

type HotelRepository struct {
	client    postgres.IClient
	log       logger.Logger
	queryOpts HotelQueryOptions
}

func NewHotelRepository(client postgres.IClient, logger *logger.Logger) domain.Repository {
	return &HotelRepository{
		client:    client,
		log:       *logger,
		queryOpts: HotelQueryOptions{},
	}
}

func (r *HotelRepository) Create(ctx context.Context, h *domain.Hotel) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating hotel",
		"hotel_id", h.ID,
		"slug", h.Slug,
		"name", h.Name,
		"star_rating", h.StarRating,
	)

	now := time.Now().UTC()
	create := client.Hotel.Create().
		SetID(h.ID).
		SetSlug(h.Slug).
		SetName(h.Name).
		SetStarRating(h.StarRating).
		SetRoomCount(h.RoomCount).
		SetLatitude(h.Location.Latitude).
		SetLongitude(h.Location.Longitude).
		SetStatus(string(h.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

	if h.Description != nil {
		create = create.SetDescription(*h.Description)
	}
	if h.CheckInTime != nil {
		create = create.SetCheckInTime(*h.CheckInTime)
	}
	if h.CheckOutTime != nil {
		create = create.SetCheckOutTime(*h.CheckOutTime)
	}
	if len(h.Address) > 0 {
		create = create.SetAddress(h.Address)
	}
	if h.Phone != nil {
		create = create.SetPhone(*h.Phone)
	}
	if h.Email != nil {
		create = create.SetEmail(*h.Email)
	}
	if h.Website != nil {
		create = create.SetWebsite(*h.Website)
	}
	if h.PrimaryImageURL != nil {
		create = create.SetPrimaryImageURL(*h.PrimaryImageURL)
	}
	if h.ThumbnailURL != nil {
		create = create.SetThumbnailURL(*h.ThumbnailURL)
	}
	if h.PriceMin != nil {
		create = create.SetPriceMin(*h.PriceMin)
	}
	if h.PriceMax != nil {
		create = create.SetPriceMax(*h.PriceMax)
	}
	if h.Currency != nil {
		create = create.SetCurrency(*h.Currency)
	}

	_, err := create.Save(ctx)

	if err != nil {
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Hotel with this slug already exists").
				WithReportableDetails(map[string]any{
					"hotel_id": h.ID,
					"slug":     h.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to create hotel").
			WithReportableDetails(map[string]any{
				"hotel_id": h.ID,
				"slug":     h.Slug,
				"name":     h.Name,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *HotelRepository) Get(ctx context.Context, id string) (*domain.Hotel, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting hotel", "hotel_id", id)

	entHotel, err := client.Hotel.Query().
		Where(hotel.ID(id)).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Hotel with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"hotel_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get hotel").
			WithReportableDetails(map[string]any{
				"hotel_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entHotel), nil
}

func (r *HotelRepository) GetBySlug(ctx context.Context, slug string) (*domain.Hotel, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting hotel by slug", "slug", slug)

	entHotel, err := client.Hotel.Query().
		Where(
			hotel.Slug(slug),
			hotel.Status(string(types.StatusPublished)),
		).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Hotel with slug %s was not found", slug).
				WithReportableDetails(map[string]any{
					"slug": slug,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get hotel by slug").
			WithReportableDetails(map[string]any{
				"slug": slug,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entHotel), nil
}

func (r *HotelRepository) List(ctx context.Context, filter *types.HotelFilter) ([]*domain.Hotel, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("listing hotels",
		"limit", filter.GetLimit(),
		"offset", filter.GetOffset(),
	)

	query := client.Hotel.Query()
	query = r.queryOpts.ApplyBaseFilters(ctx, query, filter)
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	hotels, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to list hotels").
			Mark(ierr.ErrDatabase)
	}

	// Convert to domain models
	domainHotels := domain.FromEntList(hotels)

	// If geospatial query, apply distance filtering and sorting
	hasGeospatialQuery := filter != nil && filter.Latitude != nil && filter.Longitude != nil && filter.RadiusM != nil
	if hasGeospatialQuery {
		lat0 := *filter.Latitude
		lng0 := *filter.Longitude
		radiusM := *filter.RadiusM

		// Calculate distances and filter by exact radius
		type hotelWithDistance struct {
			hotel    *domain.Hotel
			distance float64
		}

		hotelsWithDist := make([]hotelWithDistance, 0, len(domainHotels))
		for _, h := range domainHotels {
			dist := haversineDistance(lat0, lng0, h.Location.Latitude, h.Location.Longitude)
			if dist <= radiusM.InexactFloat64() {
				hotelsWithDist = append(hotelsWithDist, hotelWithDistance{
					hotel:    h,
					distance: dist,
				})
			}
		}

		// Sort by distance ASC, then ID ASC
		sort.Slice(hotelsWithDist, func(i, j int) bool {
			if hotelsWithDist[i].distance != hotelsWithDist[j].distance {
				return hotelsWithDist[i].distance < hotelsWithDist[j].distance
			}
			return hotelsWithDist[i].hotel.ID < hotelsWithDist[j].hotel.ID
		})

		// Apply pagination (offset and limit)
		offset := filter.GetOffset()
		limit := filter.GetLimit()
		start := offset
		end := offset + limit
		if start > len(hotelsWithDist) {
			start = len(hotelsWithDist)
		}
		if end > len(hotelsWithDist) {
			end = len(hotelsWithDist)
		}

		// Extract hotels
		result := make([]*domain.Hotel, 0, end-start)
		for i := start; i < end; i++ {
			result = append(result, hotelsWithDist[i].hotel)
		}

		return result, nil
	}

	return domainHotels, nil
}

func (r *HotelRepository) ListAll(ctx context.Context, filter *types.HotelFilter) ([]*domain.Hotel, error) {
	if filter == nil {
		filter = types.NewNoLimitHotelFilter()
	}

	if filter.QueryFilter == nil {
		filter.QueryFilter = types.NewNoLimitQueryFilter()
	}

	hotels, err := r.List(ctx, filter)
	if err != nil {
		return nil, err
	}
	return hotels, nil
}

func (r *HotelRepository) Count(ctx context.Context, filter *types.HotelFilter) (int, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("counting hotels")

	query := client.Hotel.Query()
	query = r.queryOpts.ApplyBaseFilters(ctx, query, filter)
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithHint("Failed to count hotels").
			Mark(ierr.ErrDatabase)
	}

	return count, nil
}

func (r *HotelRepository) Update(ctx context.Context, h *domain.Hotel) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating hotel",
		"hotel_id", h.ID,
		"slug", h.Slug,
		"name", h.Name,
	)

	// Note: Slug is immutable and cannot be updated
	update := client.Hotel.UpdateOneID(h.ID).
		SetName(h.Name).
		SetStarRating(h.StarRating).
		SetRoomCount(h.RoomCount).
		SetLatitude(h.Location.Latitude).
		SetLongitude(h.Location.Longitude).
		SetStatus(string(h.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if h.Description != nil {
		update = update.SetDescription(*h.Description)
	} else {
		update = update.ClearDescription()
	}
	if h.CheckInTime != nil {
		update = update.SetCheckInTime(*h.CheckInTime)
	} else {
		update = update.ClearCheckInTime()
	}
	if h.CheckOutTime != nil {
		update = update.SetCheckOutTime(*h.CheckOutTime)
	} else {
		update = update.ClearCheckOutTime()
	}
	if len(h.Address) > 0 {
		update = update.SetAddress(h.Address)
	} else {
		update = update.ClearAddress()
	}
	if h.Phone != nil {
		update = update.SetPhone(*h.Phone)
	} else {
		update = update.ClearPhone()
	}
	if h.Email != nil {
		update = update.SetEmail(*h.Email)
	} else {
		update = update.ClearEmail()
	}
	if h.Website != nil {
		update = update.SetWebsite(*h.Website)
	} else {
		update = update.ClearWebsite()
	}
	if h.PrimaryImageURL != nil {
		update = update.SetPrimaryImageURL(*h.PrimaryImageURL)
	} else {
		update = update.ClearPrimaryImageURL()
	}
	if h.ThumbnailURL != nil {
		update = update.SetThumbnailURL(*h.ThumbnailURL)
	} else {
		update = update.ClearThumbnailURL()
	}
	if h.PriceMin != nil {
		update = update.SetPriceMin(*h.PriceMin)
	}
	if h.PriceMax != nil {
		update = update.SetPriceMax(*h.PriceMax)
	}
	if h.Currency != nil {
		update = update.SetCurrency(*h.Currency)
	}

	_, err := update.Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Hotel with ID %s was not found", h.ID).
				WithReportableDetails(map[string]any{
					"hotel_id": h.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Hotel with this slug already exists").
				WithReportableDetails(map[string]any{
					"hotel_id": h.ID,
					"slug":     h.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to update hotel").
			WithReportableDetails(map[string]any{
				"hotel_id": h.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *HotelRepository) Delete(ctx context.Context, h *domain.Hotel) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting hotel",
		"hotel_id", h.ID,
	)

	_, err := client.Hotel.UpdateOneID(h.ID).
		SetStatus(string(types.StatusArchived)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Hotel with ID %s was not found", h.ID).
				WithReportableDetails(map[string]any{
					"hotel_id": h.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete hotel").
			WithReportableDetails(map[string]any{
				"hotel_id": h.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// Engagement methods

func (r *HotelRepository) IncrementViewCount(ctx context.Context, hotelID string) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("incrementing view count", "hotel_id", hotelID)

	now := time.Now().UTC()
	_, err := client.Hotel.UpdateOneID(hotelID).
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

func (r *HotelRepository) UpdateRating(ctx context.Context, hotelID string, newRating decimal.Decimal) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating hotel rating",
		"hotel_id", hotelID,
		"new_rating", newRating.String())

	// Get current hotel to calculate new average
	currentHotel, err := client.Hotel.Get(ctx, hotelID)
	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to get hotel for rating update").
			Mark(ierr.ErrDatabase)
	}

	// Calculate new rating average
	currentCount := currentHotel.RatingCount
	currentAvg := currentHotel.RatingAvg

	newCount := currentCount + 1
	newAvg := currentAvg.Mul(decimal.NewFromInt(int64(currentCount))).
		Add(newRating).
		Div(decimal.NewFromInt(int64(newCount)))

	now := time.Now().UTC()
	_, err = client.Hotel.UpdateOneID(hotelID).
		SetRatingAvg(newAvg).
		SetRatingCount(newCount).
		SetUpdatedAt(now).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		return ierr.WithError(err).
			WithHint("Failed to update hotel rating").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *HotelRepository) UpdatePopularityScore(ctx context.Context, hotelID string, score decimal.Decimal) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating popularity score",
		"hotel_id", hotelID,
		"score", score.String())

	now := time.Now().UTC()
	_, err := client.Hotel.UpdateOneID(hotelID).
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

// HotelQuery type alias for better readability
type HotelQuery = *ent.HotelQuery

// HotelQueryOptions implements query options for hotel queries
type HotelQueryOptions struct {
	QueryOptionsHelper
}

// Ensure HotelQueryOptions implements EntityQueryOptions interface
var _ EntityQueryOptions[HotelQuery, *types.HotelFilter] = (*HotelQueryOptions)(nil)

func (o HotelQueryOptions) ApplyStatusFilter(query HotelQuery, status string) HotelQuery {
	if status == "" {
		return query.Where(hotel.StatusNotIn(string(types.StatusDeleted)))
	}
	return query.Where(hotel.Status(status))
}

func (o HotelQueryOptions) ApplySortFilter(query HotelQuery, field string, order string) HotelQuery {
	field, order = o.ValidateSort(field, order)
	fieldName := o.GetFieldName(field)
	if order == types.OrderDesc {
		return query.Order(ent.Desc(fieldName))
	}
	return query.Order(ent.Asc(fieldName))
}

func (o HotelQueryOptions) ApplyPaginationFilter(query HotelQuery, limit int, offset int) HotelQuery {
	limit, offset = o.ValidatePagination(limit, offset)
	return query.Offset(offset).Limit(limit)
}

func (o HotelQueryOptions) GetFieldName(field string) string {
	switch field {
	case "created_at":
		return hotel.FieldCreatedAt
	case "updated_at":
		return hotel.FieldUpdatedAt
	case "name":
		return hotel.FieldName
	case "slug":
		return hotel.FieldSlug
	case "star_rating":
		return hotel.FieldStarRating
	case "price_min":
		return hotel.FieldPriceMin
	case "price_max":
		return hotel.FieldPriceMax
	default:
		return field
	}
}

func (o HotelQueryOptions) ApplyBaseFilters(
	_ context.Context,
	query HotelQuery,
	filter *types.HotelFilter,
) HotelQuery {
	if filter == nil {
		return query.Where(hotel.StatusNotIn(string(types.StatusDeleted)))
	}

	// Apply status filter
	query = o.ApplyStatusFilter(query, filter.GetStatus())

	// Apply pagination
	if !filter.IsUnlimited() {
		query = o.ApplyPaginationFilter(query, filter.GetLimit(), filter.GetOffset())
	}

	// Apply sorting - skip if geospatial ordering will be applied
	hasGeospatialOrdering := filter.Latitude != nil && filter.Longitude != nil && filter.RadiusM != nil
	if !hasGeospatialOrdering {
		query = o.ApplySortFilter(query, filter.GetSort(), filter.GetOrder())
	}

	return query
}

func (o HotelQueryOptions) ApplyEntityQueryOptions(
	_ context.Context,
	f *types.HotelFilter,
	query HotelQuery,
) HotelQuery {
	if f == nil {
		return query
	}

	// Apply slug filter if specified
	if len(f.Slug) > 0 {
		query = query.Where(hotel.SlugIn(f.Slug...))
	}

	// Apply star rating filter if specified
	if len(f.StarRating) > 0 {
		query = query.Where(hotel.StarRatingIn(f.StarRating...))
	}

	// Apply price range filters
	if f.MinPrice != nil {
		query = query.Where(hotel.PriceMinGTE(*f.MinPrice))
	}
	if f.MaxPrice != nil {
		query = query.Where(hotel.PriceMaxLTE(*f.MaxPrice))
	}

	// Apply search query if specified
	if f.SearchQuery != nil && *f.SearchQuery != "" {
		query = query.Where(
			hotel.Or(
				hotel.NameContainsFold(*f.SearchQuery),
				hotel.SlugContainsFold(*f.SearchQuery),
				hotel.DescriptionContainsFold(*f.SearchQuery),
			),
		)
	}

	// Apply geospatial filters if specified
	if f.Latitude != nil && f.Longitude != nil && f.RadiusM != nil {
		lat0 := *f.Latitude
		lng0 := *f.Longitude
		radiusM := *f.RadiusM

		// Step 1: Bounding box prefilter
		minLat, maxLat, minLng, maxLng := calculateBoundingBox(lat0, lng0, radiusM)

		query = query.Where(
			hotel.And(
				hotel.LatitudeGTE(minLat),
				hotel.LatitudeLTE(maxLat),
				hotel.LongitudeGTE(minLng),
				hotel.LongitudeLTE(maxLng),
			),
		)
	}

	// Apply time range filters if specified
	if f.TimeRangeFilter != nil {
		if f.StartTime != nil {
			query = query.Where(hotel.CreatedAtGTE(*f.StartTime))
		}
		if f.EndTime != nil {
			query = query.Where(hotel.CreatedAtLTE(*f.EndTime))
		}
	}

	// Apply trending filter (last viewed after)
	if f.LastViewedAfter != nil {
		query = query.Where(hotel.LastViewedAtGTE(*f.LastViewedAfter))
	}

	return query
}
