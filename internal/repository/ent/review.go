package ent

import (
	"context"
	"fmt"
	"time"

	"entgo.io/ent/dialect/sql"
	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/review"
	reviewDomain "github.com/omkar273/nashikdarshan/internal/domain/review"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

type ReviewRepository struct {
	client    postgres.IClient
	log       logger.Logger
	queryOpts ReviewQueryOptions
}

// NewReviewRepository creates a new review repository
func NewReviewRepository(client postgres.IClient, logger *logger.Logger) reviewDomain.Repository {
	return &ReviewRepository{
		client:    client,
		log:       *logger,
		queryOpts: ReviewQueryOptions{},
	}
}

// Create creates a new review
func (r *ReviewRepository) Create(ctx context.Context, rev *reviewDomain.Review) (*reviewDomain.Review, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating review",
		"review_id", rev.ID,
		"entity_type", rev.EntityType,
		"entity_id", rev.EntityID,
		"user_id", rev.UserID,
		"rating", rev.Rating,
	)

	now := time.Now().UTC()
	create := client.Review.Create().
		SetID(rev.ID).
		SetEntityType(string(rev.EntityType)).
		SetEntityID(rev.EntityID).
		SetUserID(rev.UserID).
		SetRating(rev.Rating).
		SetStatus(string(rev.Status)).
		SetCreatedAt(now).
		SetUpdatedAt(now).
		SetCreatedBy(types.GetUserID(ctx)).
		SetUpdatedBy(types.GetUserID(ctx))

	if rev.Title != nil {
		create = create.SetTitle(*rev.Title)
	}
	if rev.Content != nil {
		create = create.SetContent(*rev.Content)
	}
	if len(rev.Tags) > 0 {
		// Filter out empty strings to avoid PostgreSQL array issues
		validTags := []string{}
		for _, tag := range rev.Tags {
			if tag != "" {
				validTags = append(validTags, tag)
			}
		}
		if len(validTags) > 0 {
			create = create.SetTags(validTags)
		}
	}
	if len(rev.Images) > 0 {
		create = create.SetImages(rev.Images)
	}

	entReview, err := create.Save(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithMessage("failed to create review").
			Mark(ierr.ErrDatabase)
	}

	return reviewDomain.FromEnt(entReview), nil
}

// GetByID gets a review by ID
func (r *ReviewRepository) GetByID(ctx context.Context, id string) (*reviewDomain.Review, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting review by ID", "review_id", id)

	entReview, err := client.Review.
		Query().
		Where(review.ID(id)).
		First(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.NewError("review not found").
				WithHint(fmt.Sprintf("review with id %s not found", id)).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithMessage("failed to get review").
			Mark(ierr.ErrDatabase)
	}

	return reviewDomain.FromEnt(entReview), nil
}

// Update updates a review (only if user is the creator)
func (r *ReviewRepository) Update(ctx context.Context, id string, rev *reviewDomain.Review) (*reviewDomain.Review, error) {
	client := r.client.Querier(ctx)
	userID := types.GetUserID(ctx)

	r.log.Debugw("updating review", "review_id", id, "user_id", userID)

	query := client.Review.UpdateOneID(id).
		Where(review.UserID(userID)). // Ensure only creator can update
		SetUpdatedBy(userID)

	if rev.Rating.IsPositive() {
		query = query.SetRating(rev.Rating)
	}
	if rev.Title != nil {
		query = query.SetTitle(*rev.Title)
	}
	if rev.Content != nil {
		query = query.SetContent(*rev.Content)
	}
	if len(rev.Tags) > 0 {
		// Filter out empty strings to avoid PostgreSQL array issues
		validTags := []string{}
		for _, tag := range rev.Tags {
			if tag != "" {
				validTags = append(validTags, tag)
			}
		}
		if len(validTags) > 0 {
			query = query.SetTags(validTags)
		}
	}
	if len(rev.Images) > 0 {
		query = query.SetImages(rev.Images)
	}

	entReview, err := query.Save(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.NewError("review not found or access denied").
				WithHint("Review not found or you don't have permission to update it").
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithMessage("failed to update review").
			Mark(ierr.ErrDatabase)
	}

	return reviewDomain.FromEnt(entReview), nil
}

// Delete deletes a review (only if user is the creator)
func (r *ReviewRepository) Delete(ctx context.Context, id string) error {
	client := r.client.Querier(ctx)
	userID := types.GetUserID(ctx)

	r.log.Debugw("deleting review", "review_id", id, "user_id", userID)

	// Delete only if the review belongs to the user
	_, err := client.Review.
		Delete().
		Where(review.ID(id), review.UserID(userID)).
		Exec(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("review not found").
				WithHint(fmt.Sprintf("review with id %s not found", id)).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithMessage("failed to delete review").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// List lists reviews with filtering
func (r *ReviewRepository) List(ctx context.Context, filter *types.ReviewFilter) ([]*reviewDomain.Review, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("listing reviews",
		"limit", filter.GetLimit(),
		"offset", filter.GetOffset(),
		"status", filter.GetStatus(),
	)

	query := client.Review.Query()

	// Apply filters using query options
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	entReviews, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithMessage("failed to list reviews").
			Mark(ierr.ErrDatabase)
	}

	return reviewDomain.FromEntList(entReviews), nil
}

// Count counts reviews with filtering
func (r *ReviewRepository) Count(ctx context.Context, filter *types.ReviewFilter) (int, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("counting reviews", "status", filter.GetStatus())

	query := client.Review.Query()

	// Apply filters (without pagination)
	countFilter := *filter
	countFilter.QueryFilter = &types.QueryFilter{
		Status: filter.QueryFilter.Status,
		// Don't include limit/offset for counting
	}
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, &countFilter, query)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithMessage("failed to count reviews").
			Mark(ierr.ErrDatabase)
	}

	return count, nil
}

// GetAverageRating gets the average rating for an entity
func (r *ReviewRepository) GetAverageRating(ctx context.Context, entityType types.ReviewEntityType, entityID string) (decimal.Decimal, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting average rating",
		"entity_type", entityType,
		"entity_id", entityID,
	)

	var avgRating sql.NullFloat64
	err := client.Review.Query().
		Where(
			review.EntityType(string(entityType)),
			review.EntityID(entityID),
			review.Status(string(types.StatusPublished)),
		).
		Aggregate(ent.Mean(review.FieldRating)).
		Scan(ctx, &avgRating)

	if err != nil {
		return decimal.Zero, ierr.WithError(err).
			WithMessage("failed to get average rating").
			WithMessage("database operation failed").
			Mark(ierr.ErrDatabase)
	}

	if !avgRating.Valid {
		return decimal.Zero, nil
	}

	return decimal.NewFromFloat(avgRating.Float64), nil
}

// GetRatingDistribution gets the rating distribution for an entity
func (r *ReviewRepository) GetRatingDistribution(ctx context.Context, entityType types.ReviewEntityType, entityID string) (map[int]int, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting rating distribution",
		"entity_type", entityType,
		"entity_id", entityID,
	)

	var results []struct {
		Rating int `json:"rating"`
		Count  int `json:"count"`
	}

	err := client.Review.Query().
		Where(
			review.EntityType(string(entityType)),
			review.EntityID(entityID),
			review.Status(string(types.StatusPublished)),
		).
		GroupBy(review.FieldRating).
		Aggregate(ent.Count()).
		Scan(ctx, &results)

	if err != nil {
		return nil, ierr.WithError(err).
			WithMessage("failed to get rating distribution").
			Mark(ierr.ErrDatabase)
	}

	distribution := make(map[int]int)
	for _, result := range results {
		distribution[result.Rating] = result.Count
	}

	return distribution, nil
}

// GetRatingStats gets comprehensive rating statistics for an entity
func (r *ReviewRepository) GetRatingStats(ctx context.Context, entityType types.ReviewEntityType, entityID string) (*reviewDomain.RatingStats, error) {
	// Get average rating and total count
	avgRating, err := r.GetAverageRating(ctx, entityType, entityID)
	if err != nil {
		return nil, err
	}

	statusPublished := types.StatusPublished
	totalReviews, err := r.Count(ctx, &types.ReviewFilter{
		QueryFilter: &types.QueryFilter{Status: &statusPublished},
		EntityType:  entityType,
		EntityID:    &entityID,
	})
	if err != nil {
		return nil, err
	}

	// Get rating distribution
	distribution, err := r.GetRatingDistribution(ctx, entityType, entityID)
	if err != nil {
		return nil, err
	}

	// Get additional stats
	trueValue := true
	verifiedCount, _ := r.Count(ctx, &types.ReviewFilter{
		QueryFilter: &types.QueryFilter{Status: &statusPublished},
		EntityType:  entityType,
		EntityID:    &entityID,
		IsVerified:  &trueValue,
	})

	withImagesCount, _ := r.Count(ctx, &types.ReviewFilter{
		QueryFilter: &types.QueryFilter{Status: &statusPublished},
		EntityType:  entityType,
		EntityID:    &entityID,
		HasImages:   &trueValue,
	})

	withContentCount, _ := r.Count(ctx, &types.ReviewFilter{
		QueryFilter: &types.QueryFilter{Status: &statusPublished},
		EntityType:  entityType,
		EntityID:    &entityID,
		HasContent:  &trueValue,
	})

	return &reviewDomain.RatingStats{
		EntityType:         entityType,
		EntityID:           entityID,
		AverageRating:      avgRating,
		TotalReviews:       totalReviews,
		RatingDistribution: distribution,
		FiveStarCount:      distribution[5],
		FourStarCount:      distribution[4],
		ThreeStarCount:     distribution[3],
		TwoStarCount:       distribution[2],
		OneStarCount:       distribution[1],
		VerifiedReviews:    verifiedCount,
		ReviewsWithImages:  withImagesCount,
		ReviewsWithContent: withContentCount,
	}, nil
}

// SetFeatured sets the featured status of a review
func (r *ReviewRepository) SetFeatured(ctx context.Context, reviewID string, featured bool) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("setting featured status",
		"review_id", reviewID,
		"featured", featured,
	)

	_, err := client.Review.UpdateOneID(reviewID).
		SetIsFeatured(featured).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("review not found").
				WithHint(fmt.Sprintf("review with id %s not found", reviewID)).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithMessage("failed to set featured status").
			WithMessage("database operation failed").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// SetVerified sets the verified status of a review
func (r *ReviewRepository) SetVerified(ctx context.Context, reviewID string, verified bool) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("setting verified status",
		"review_id", reviewID,
		"verified", verified,
	)

	_, err := client.Review.UpdateOneID(reviewID).
		SetIsVerified(verified).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.NewError("review not found").
				WithHint(fmt.Sprintf("review with id %s not found", reviewID)).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithMessage("failed to set verified status").
			WithMessage("database operation failed").
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// GetAverageRatingByTimeRange gets average rating within a time range - uses core query logic with time filters
func (r *ReviewRepository) GetAverageRatingByTimeRange(ctx context.Context, entityType types.ReviewEntityType, entityID string, filter *types.TimeRangeFilter) (decimal.Decimal, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting average rating by time range",
		"entity_type", entityType,
		"entity_id", entityID,
	)

	// Build query with entity constraints
	query := client.Review.Query().
		Where(
			review.EntityType(string(entityType)),
			review.EntityID(entityID),
			review.Status(string(types.StatusPublished)),
		)

	// Apply time range filter if provided
	if filter != nil {
		if filter.StartTime != nil {
			query = query.Where(review.CreatedAtGTE(*filter.StartTime))
		}
		if filter.EndTime != nil {
			query = query.Where(review.CreatedAtLTE(*filter.EndTime))
		}
	}

	var avgRating sql.NullFloat64
	err := query.Aggregate(ent.Mean(review.FieldRating)).Scan(ctx, &avgRating)

	if err != nil {
		return decimal.Zero, ierr.WithError(err).
			WithMessage("failed to get average rating by time range").
			Mark(ierr.ErrDatabase)
	}

	if !avgRating.Valid {
		return decimal.Zero, nil
	}

	return decimal.NewFromFloat(avgRating.Float64), nil
}

// ReviewQueryOptions implements query options for review entities
type ReviewQueryOptions struct {
	QueryOptionsHelper
}

// ApplyStatusFilter applies status filtering to review queries
func (opts ReviewQueryOptions) ApplyStatusFilter(query *ent.ReviewQuery, status string) *ent.ReviewQuery {
	if status == "" {
		status = opts.GetDefaultStatus()
	}
	return query.Where(review.Status(status))
}

// ApplySortFilter applies sorting to review queries
func (opts ReviewQueryOptions) ApplySortFilter(query *ent.ReviewQuery, field string, order string) *ent.ReviewQuery {
	field, order = opts.ValidateSort(field, order)

	switch field {
	case "rating":
		if order == types.OrderAsc {
			return query.Order(ent.Asc(review.FieldRating))
		}
		return query.Order(ent.Desc(review.FieldRating))
	case "helpful_count":
		if order == types.OrderAsc {
			return query.Order(ent.Asc(review.FieldHelpfulCount))
		}
		return query.Order(ent.Desc(review.FieldHelpfulCount))
	case "updated_at":
		if order == types.OrderAsc {
			return query.Order(ent.Asc(review.FieldUpdatedAt))
		}
		return query.Order(ent.Desc(review.FieldUpdatedAt))
	case "created_at":
	default:
		if order == types.OrderAsc {
			return query.Order(ent.Asc(review.FieldCreatedAt))
		}
		return query.Order(ent.Desc(review.FieldCreatedAt))
	}

	// Default to created_at desc
	return query.Order(ent.Desc(review.FieldCreatedAt))
}

// ApplyPaginationFilter applies pagination to review queries
func (opts ReviewQueryOptions) ApplyPaginationFilter(query *ent.ReviewQuery, limit int, offset int) *ent.ReviewQuery {
	limit, offset = opts.ValidatePagination(limit, offset)
	return query.Limit(limit).Offset(offset)
}

// GetFieldName returns the database field name for a given field
func (opts ReviewQueryOptions) GetFieldName(field string) string {
	switch field {
	case "rating":
		return review.FieldRating
	case "helpful_count":
		return review.FieldHelpfulCount
	case "created_at":
		return review.FieldCreatedAt
	case "updated_at":
		return review.FieldUpdatedAt
	case "entity_type":
		return review.FieldEntityType
	case "entity_id":
		return review.FieldEntityID
	case "user_id":
		return review.FieldUserID
	default:
		return review.FieldCreatedAt
	}
}

// ApplyBaseFilters applies common filters to review queries
func (opts ReviewQueryOptions) ApplyBaseFilters(ctx context.Context, query *ent.ReviewQuery, filter types.BaseFilter) *ent.ReviewQuery {
	// Apply status filter
	query = opts.ApplyStatusFilter(query, filter.GetStatus())

	// Apply sorting
	query = opts.ApplySortFilter(query, filter.GetSort(), filter.GetOrder())

	// Apply pagination (only if not unlimited)
	if !filter.IsUnlimited() {
		query = opts.ApplyPaginationFilter(query, filter.GetLimit(), filter.GetOffset())
	}

	return query
}

// ApplyEntityQueryOptions applies entity-specific filters to review queries
func (opts ReviewQueryOptions) ApplyEntityQueryOptions(ctx context.Context, filter *types.ReviewFilter, query *ent.ReviewQuery) *ent.ReviewQuery {
	// Apply base filters first
	query = opts.ApplyBaseFilters(ctx, query, filter)

	// Apply review-specific filters
	if filter.EntityType != "" {
		query = query.Where(review.EntityType(string(filter.EntityType)))
	}

	if filter.EntityID != nil {
		query = query.Where(review.EntityID(*filter.EntityID))
	}

	if filter.UserID != nil {
		query = query.Where(review.UserID(*filter.UserID))
	}

	// Rating filters
	if filter.MinRating != nil {
		query = query.Where(review.RatingGTE(decimal.NewFromFloat(*filter.MinRating)))
	}
	if filter.MaxRating != nil {
		query = query.Where(review.RatingLTE(decimal.NewFromFloat(*filter.MaxRating)))
	}

	// Content filters
	if filter.HasImages != nil && *filter.HasImages {
		query = query.Where(func(s *sql.Selector) {
			s.Where(sql.GT("array_length(images, 1)", 0))
		})
	}
	if filter.HasContent != nil && *filter.HasContent {
		query = query.Where(review.ContentNotNil())
	}
	if filter.IsVerified != nil {
		query = query.Where(review.IsVerified(*filter.IsVerified))
	}
	if filter.IsFeatured != nil {
		query = query.Where(review.IsFeatured(*filter.IsFeatured))
	}
	if filter.MinHelpfulVotes != nil {
		query = query.Where(review.HelpfulCountGTE(*filter.MinHelpfulVotes))
	}

	// Time range filters
	if filter.TimeRangeFilter != nil {
		if filter.StartTime != nil {
			query = query.Where(review.CreatedAtGTE(*filter.StartTime))
		}
		if filter.EndTime != nil {
			query = query.Where(review.CreatedAtLTE(*filter.EndTime))
		}
	}

	return query
}
