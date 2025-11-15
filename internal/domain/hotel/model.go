package hotel

import (
	"math"
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/samber/lo"
	"github.com/shopspring/decimal"
)

type Hotel struct {
	ID              string            `json:"id" db:"id"`
	Slug            string            `json:"slug" db:"slug"`
	Name            string            `json:"name" db:"name"`
	Description     *string           `json:"description,omitempty" db:"description"`
	StarRating      int               `json:"star_rating" db:"star_rating"`
	RoomCount       int               `json:"room_count" db:"room_count"`
	CheckInTime     *time.Time        `json:"check_in_time,omitempty" db:"check_in_time"`
	CheckOutTime    *time.Time        `json:"check_out_time,omitempty" db:"check_out_time"`
	Address         map[string]string `json:"address,omitempty" db:"address"`
	Location        types.Location    `json:"location" db:"location"`
	Phone           *string           `json:"phone,omitempty" db:"phone"`
	Email           *string           `json:"email,omitempty" db:"email"`
	Website         *string           `json:"website,omitempty" db:"website"`
	PrimaryImageURL *string           `json:"primary_image_url,omitempty" db:"primary_image_url"`
	ThumbnailURL    *string           `json:"thumbnail_url,omitempty" db:"thumbnail_url"`
	PriceMin        *decimal.Decimal  `json:"price_min,omitempty" db:"price_min"`
	PriceMax        *decimal.Decimal  `json:"price_max,omitempty" db:"price_max"`
	Currency        *string           `json:"currency,omitempty" db:"currency"`

	// Engagement fields
	ViewCount       int             `json:"view_count" db:"view_count"`
	RatingAvg       decimal.Decimal `json:"rating_avg" db:"rating_avg"`
	RatingCount     int             `json:"rating_count" db:"rating_count"`
	LastViewedAt    *time.Time      `json:"last_viewed_at,omitempty" db:"last_viewed_at"`
	PopularityScore decimal.Decimal `json:"popularity_score" db:"popularity_score"`

	Metadata *types.Metadata `json:"metadata,omitempty" db:"metadata"`

	types.BaseModel
}

// FromEnt converts ent.Hotel to domain Hotel
func FromEnt(hotel *ent.Hotel) *Hotel {
	h := &Hotel{
		ID:          hotel.ID,
		Slug:        hotel.Slug,
		Name:        hotel.Name,
		Description: lo.ToPtr(hotel.Description),
		StarRating:  hotel.StarRating,
		RoomCount:   hotel.RoomCount,
		Location: types.Location{
			Latitude:  hotel.Latitude,
			Longitude: hotel.Longitude,
		},
		Phone:           lo.ToPtr(hotel.Phone),
		Email:           lo.ToPtr(hotel.Email),
		Website:         lo.ToPtr(hotel.Website),
		PrimaryImageURL: lo.ToPtr(hotel.PrimaryImageURL),
		ThumbnailURL:    lo.ToPtr(hotel.ThumbnailURL),
		PriceMin:        lo.Ternary(!hotel.PriceMin.IsZero(), &hotel.PriceMin, nil),
		PriceMax:        lo.Ternary(!hotel.PriceMax.IsZero(), &hotel.PriceMax, nil),
		Currency:        lo.ToPtr(hotel.Currency),

		// Engagement fields
		ViewCount:       hotel.ViewCount,
		RatingAvg:       hotel.RatingAvg,
		RatingCount:     hotel.RatingCount,
		LastViewedAt:    lo.ToPtr(hotel.LastViewedAt),
		PopularityScore: hotel.PopularityScore,

		BaseModel: types.BaseModel{
			Status:    types.Status(hotel.Status),
			CreatedAt: hotel.CreatedAt,
			UpdatedAt: hotel.UpdatedAt,
			CreatedBy: hotel.CreatedBy,
			UpdatedBy: hotel.UpdatedBy,
		},
	}

	// Handle JSON fields - address
	if hotel.Address != nil {
		h.Address = hotel.Address
	}

	// Handle metadata
	if len(hotel.Metadata) > 0 {
		h.Metadata = types.NewMetadataFromMap(hotel.Metadata)
	}

	// Handle time fields - check for zero value
	if !hotel.CheckInTime.IsZero() {
		h.CheckInTime = &hotel.CheckInTime
	}
	if !hotel.CheckOutTime.IsZero() {
		h.CheckOutTime = &hotel.CheckOutTime
	}

	return h
}

// FromEntList converts a list of ent.Hotel to domain Hotel
func FromEntList(hotels []*ent.Hotel) []*Hotel {
	return lo.Map(hotels, func(hotel *ent.Hotel, _ int) *Hotel {
		return FromEnt(hotel)
	})
}

// CalculatePopularityScore calculates the popularity score for a hotel using engagement metrics
func (h *Hotel) CalculatePopularityScore() decimal.Decimal {
	// Base score: (view_count * 0.3) + (rating_avg * rating_count * 0.7)
	viewScore := decimal.NewFromInt(int64(h.ViewCount)).Mul(decimal.NewFromFloat(0.3))
	ratingScore := h.RatingAvg.Mul(decimal.NewFromInt(int64(h.RatingCount))).Mul(decimal.NewFromFloat(0.7))
	baseScore := viewScore.Add(ratingScore)

	// Time decay factor (addresses stale content)
	ageDays := time.Since(h.CreatedAt).Hours() / 24
	timeFactor := math.Max(0.1, 1.0-(ageDays/365)) // Decay over 1 year

	// Cold start boost (addresses new hotel visibility)
	newHotelBoost := 1.0
	if ageDays <= 7 {
		newHotelBoost = 1.5 // 50% boost for hotels created in last 7 days
	}

	// Quality threshold (addresses low-quality content)
	qualityFactor := 1.0
	if h.RatingCount >= 5 && h.RatingAvg.GreaterThanOrEqual(decimal.NewFromFloat(4.0)) {
		qualityFactor = 1.2 // 20% boost for high-quality hotels
	}

	// Star rating boost
	starBoost := 1.0 + (float64(h.StarRating-3) * 0.1) // 10% per star above/below 3

	// Final score calculation
	finalScore := baseScore.
		Mul(decimal.NewFromFloat(timeFactor)).
		Mul(decimal.NewFromFloat(newHotelBoost)).
		Mul(decimal.NewFromFloat(qualityFactor)).
		Mul(decimal.NewFromFloat(starBoost))

	return finalScore
}
