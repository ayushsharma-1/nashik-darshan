package place

import (
	"math"
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/samber/lo"
	"github.com/shopspring/decimal"
)

type Place struct {
	ID               string            `json:"id" db:"id"`
	Slug             string            `json:"slug" db:"slug"`
	Title            string            `json:"title" db:"title"`
	Subtitle         *string           `json:"subtitle,omitempty" db:"subtitle"`
	ShortDescription *string           `json:"short_description,omitempty" db:"short_description"`
	LongDescription  *string           `json:"long_description,omitempty" db:"long_description"`
	PlaceType        types.PlaceType   `json:"place_type" db:"place_type"`
	Address          map[string]string `json:"address,omitempty" db:"address"`
	Location         types.Location    `json:"location" db:"location"`
	PrimaryImageURL  *string           `json:"primary_image_url,omitempty" db:"primary_image_url"`
	ThumbnailURL     *string           `json:"thumbnail_url,omitempty" db:"thumbnail_url"`

	// Engagement fields for feed functionality
	ViewCount       int             `json:"view_count" db:"view_count"`
	RatingAvg       decimal.Decimal `json:"rating_avg" db:"rating_avg"`
	RatingCount     int             `json:"rating_count" db:"rating_count"`
	LastViewedAt    *time.Time      `json:"last_viewed_at,omitempty" db:"last_viewed_at"`
	PopularityScore decimal.Decimal `json:"popularity_score" db:"popularity_score"`

	types.BaseModel

	// Relationships
	Images []*PlaceImage `json:"images,omitempty"`
}

type PlaceImage struct {
	ID       string          `json:"id" db:"id"`
	PlaceID  string          `json:"place_id" db:"place_id"`
	URL      string          `json:"url" db:"url"`
	Alt      string          `json:"alt,omitempty" db:"alt"`
	Pos      int             `json:"pos" db:"pos"`
	Metadata *types.Metadata `json:"metadata,omitempty" db:"metadata"`
	types.BaseModel
}

// FromEnt converts ent.Place to domain Place
func FromEnt(place *ent.Place) *Place {
	p := &Place{
		ID:               place.ID,
		Slug:             place.Slug,
		Title:            place.Title,
		Subtitle:         lo.ToPtr(place.Subtitle),
		ShortDescription: lo.ToPtr(place.ShortDescription),
		LongDescription:  lo.ToPtr(place.LongDescription),
		PlaceType:        types.PlaceType(place.PlaceType),
		Location: types.Location{
			Latitude:  place.Latitude,
			Longitude: place.Longitude,
		},
		PrimaryImageURL: lo.ToPtr(place.PrimaryImageURL),
		ThumbnailURL:    lo.ToPtr(place.ThumbnailURL),

		// Engagement fields
		ViewCount:       place.ViewCount,
		RatingAvg:       place.RatingAvg,
		RatingCount:     place.RatingCount,
		LastViewedAt:    lo.ToPtr(place.LastViewedAt),
		PopularityScore: place.PopularityScore,

		BaseModel: types.BaseModel{
			Status:    types.Status(place.Status),
			CreatedAt: place.CreatedAt,
			UpdatedAt: place.UpdatedAt,
			CreatedBy: place.CreatedBy,
			UpdatedBy: place.UpdatedBy,
		},
	}

	// Handle JSON fields - address is now map[string]string in ent after regeneration
	if place.Address != nil {
		p.Address = place.Address
	}

	// Handle edges
	if place.Edges.Images != nil {
		p.Images = FromEntImageList(place.Edges.Images)
	}

	return p
}

// FromEntList converts a list of ent.Place to domain Place
func FromEntList(places []*ent.Place) []*Place {
	return lo.Map(places, func(place *ent.Place, _ int) *Place {
		return FromEnt(place)
	})
}

// FromEntImage converts ent.PlaceImage to domain PlaceImage
func FromEntImage(image *ent.PlaceImage) *PlaceImage {
	pi := &PlaceImage{
		ID:       image.ID,
		PlaceID:  image.PlaceID,
		URL:      image.URL,
		Alt:      image.Alt,
		Pos:      image.Pos,
		Metadata: types.NewMetadataFromMap(image.Metadata),
		BaseModel: types.BaseModel{
			Status:    types.Status(image.Status),
			CreatedAt: image.CreatedAt,
			UpdatedAt: image.UpdatedAt,
			CreatedBy: image.CreatedBy,
			UpdatedBy: image.UpdatedBy,
		},
	}

	return pi
}

// FromEntImageList converts a list of ent.PlaceImage to domain PlaceImage
func FromEntImageList(images []*ent.PlaceImage) []*PlaceImage {
	return lo.Map(images, func(image *ent.PlaceImage, _ int) *PlaceImage {
		return FromEntImage(image)
	})
}

// CalculatePopularityScore calculates the popularity score for a place using engagement metrics
func (p *Place) CalculatePopularityScore() decimal.Decimal {
	// Base score: (view_count * 0.3) + (rating_avg * rating_count * 0.7)
	viewScore := decimal.NewFromInt(int64(p.ViewCount)).Mul(decimal.NewFromFloat(0.3))
	ratingScore := p.RatingAvg.Mul(decimal.NewFromInt(int64(p.RatingCount))).Mul(decimal.NewFromFloat(0.7))
	baseScore := viewScore.Add(ratingScore)

	// Time decay factor (addresses stale content)
	ageDays := time.Since(p.CreatedAt).Hours() / 24
	timeFactor := math.Max(0.1, 1.0-(ageDays/365)) // Decay over 1 year

	// Cold start boost (addresses new place visibility)
	newPlaceBoost := 1.0
	if ageDays <= 7 {
		newPlaceBoost = 1.5 // 50% boost for places created in last 7 days
	}

	// Quality threshold (addresses low-quality content)
	qualityFactor := 1.0
	if p.RatingCount >= 5 && p.RatingAvg.GreaterThanOrEqual(decimal.NewFromFloat(4.0)) {
		qualityFactor = 1.2 // 20% boost for high-quality places
	}

	// Final score calculation
	finalScore := baseScore.
		Mul(decimal.NewFromFloat(timeFactor)).
		Mul(decimal.NewFromFloat(newPlaceBoost)).
		Mul(decimal.NewFromFloat(qualityFactor))

	return finalScore
}
