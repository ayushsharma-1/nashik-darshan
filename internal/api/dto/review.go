package dto

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/domain/review"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

// CreateReviewRequest represents the request to create a new review
type CreateReviewRequest struct {
	EntityType types.ReviewEntityType `json:"entity_type" binding:"required" validate:"required,max=50"`
	EntityID   string                 `json:"entity_id" binding:"required,min=1,max=100" validate:"required"`
	Rating     decimal.Decimal        `json:"rating" binding:"required" validate:"required,min=1,max=5"`
	Title      *string                `json:"title,omitempty" binding:"omitempty,max=255" validate:"omitempty,max=255"`
	Content    *string                `json:"content,omitempty" binding:"omitempty,max=3000" validate:"omitempty,max=3000"`
	Tags       []string               `json:"tags,omitempty" validate:"omitempty,dive,max=50"`
	Images     []string               `json:"images,omitempty" binding:"omitempty,dive,url,max=500" validate:"omitempty,dive,url"`
}

// Validate validates the CreateReviewRequest
func (r *CreateReviewRequest) Validate() error {
	// Validate entity type
	if err := r.EntityType.Validate(); err != nil {
		return err
	}

	// Validate rating range
	if r.Rating.LessThan(decimal.NewFromFloat(1.0)) || r.Rating.GreaterThan(decimal.NewFromFloat(5.0)) {
		return ierr.NewError("rating must be between 1.0 and 5.0").
			WithHint("Please provide a rating between 1.0 and 5.0").
			Mark(ierr.ErrValidation)
	}

	if len(r.Tags) > 10 {
		return ierr.NewError("maximum 10 tags allowed").
			WithHint("Please limit your review to 10 tags").
			Mark(ierr.ErrValidation)
	}

	if len(r.Images) > 5 {
		return ierr.NewError("maximum 5 images allowed").
			WithHint("Please limit your review to 5 images").
			Mark(ierr.ErrValidation)
	}

	return nil
}

// ToReview converts CreateReviewRequest to domain Review
func (r *CreateReviewRequest) ToReview(ctx context.Context) *review.Review {
	return &review.Review{
		ID:         types.GenerateUUIDWithPrefix(types.UUID_PREFIX_REVIEW),
		EntityType: r.EntityType,
		EntityID:   r.EntityID,
		Rating:     r.Rating,
		Title:      r.Title,
		Content:    r.Content,
		Tags:       r.Tags,
		Images:     r.Images,
		UserID:     types.GetUserID(ctx),
		BaseModel:  types.GetDefaultBaseModel(ctx),
	}
}

// UpdateReviewRequest represents the request to update an existing review
type UpdateReviewRequest struct {
	Rating  *decimal.Decimal `json:"rating,omitempty" validate:"omitempty,min=1,max=5"`
	Title   *string          `json:"title,omitempty" binding:"omitempty,max=255" validate:"omitempty,max=255"`
	Content *string          `json:"content,omitempty" binding:"omitempty,max=3000" validate:"omitempty,max=3000"`
	Tags    []string         `json:"tags,omitempty" validate:"omitempty,dive,max=50"`
	Images  []string         `json:"images,omitempty" binding:"omitempty,dive,url,max=500" validate:"omitempty,dive,url"`
}

// Validate validates the UpdateReviewRequest
func (r *UpdateReviewRequest) Validate() error {
	// Validate rating range if provided
	if r.Rating != nil {
		if r.Rating.LessThan(decimal.NewFromFloat(1.0)) || r.Rating.GreaterThan(decimal.NewFromFloat(5.0)) {
			return ierr.NewError("rating must be between 1.0 and 5.0").
				WithHint("Please provide a rating between 1.0 and 5.0").
				Mark(ierr.ErrValidation)
		}
	}

	// Validate tags length
	if len(r.Tags) > 10 {
		return ierr.NewError("maximum 10 tags allowed").
			WithHint("Please limit your review to 10 tags").
			Mark(ierr.ErrValidation)
	}

	// Validate images length
	if len(r.Images) > 5 {
		return ierr.NewError("maximum 5 images allowed").
			WithHint("Please limit your review to 5 images").
			Mark(ierr.ErrValidation)
	}

	return nil
}

// ReviewResponse represents the response structure for a review
type ReviewResponse struct {
	*review.Review
}

// NewReviewResponse creates a new ReviewResponse from domain Review
func NewReviewResponse(r *review.Review) *ReviewResponse {
	return &ReviewResponse{
		Review: r,
	}
}

// RatingStatsResponse represents the response structure for rating statistics
type RatingStatsResponse struct {
	*review.RatingStats
}

// NewRatingStatsResponse creates a new RatingStatsResponse from domain RatingStats
func NewRatingStatsResponse(stats *review.RatingStats) *RatingStatsResponse {
	return &RatingStatsResponse{
		RatingStats: stats,
	}
}

// GetRatingStatsRequest represents a request to get rating statistics for an entity
type GetRatingStatsRequest struct {
	EntityType types.ReviewEntityType `json:"entity_type" binding:"required"`
	EntityID   string                 `json:"entity_id" binding:"required"`
}

// Validate validates the GetRatingStatsRequest
func (r *GetRatingStatsRequest) Validate() error {
	if err := r.EntityType.Validate(); err != nil {
		return err
	}
	if r.EntityID == "" {
		return ierr.NewError("entity ID is required").
			WithHint("Please provide a valid entity ID").
			Mark(ierr.ErrValidation)
	}
	return nil
}
