package place

import (
	"github.com/omkar273/nashikdarshan/ent"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/samber/lo"
	"github.com/shopspring/decimal"
)

// Location represents a geographic location with latitude and longitude (WGS84)
type Location struct {
	Latitude  decimal.Decimal `json:"latitude"`
	Longitude decimal.Decimal `json:"longitude"`
}

// Validate validates the Location coordinates
func (l Location) Validate() error {
	// Validate latitude range (-90 to 90)
	if l.Latitude.LessThan(decimal.NewFromInt(-90)) || l.Latitude.GreaterThan(decimal.NewFromInt(90)) {
		return ierr.NewError("invalid latitude").
			WithHint("latitude must be between -90 and 90").
			Mark(ierr.ErrValidation)
	}

	// Validate longitude range (-180 to 180)
	if l.Longitude.LessThan(decimal.NewFromInt(-180)) || l.Longitude.GreaterThan(decimal.NewFromInt(180)) {
		return ierr.NewError("invalid longitude").
			WithHint("longitude must be between -180 and 180").
			Mark(ierr.ErrValidation)
	}

	return nil
}

type Place struct {
	ID               string            `json:"id" db:"id"`
	Slug             string            `json:"slug" db:"slug"`
	Title            string            `json:"title" db:"title"`
	Subtitle         *string           `json:"subtitle,omitempty" db:"subtitle"`
	ShortDescription *string           `json:"short_description,omitempty" db:"short_description"`
	LongDescription  *string           `json:"long_description,omitempty" db:"long_description"`
	PlaceType        string            `json:"place_type" db:"place_type"`
	Categories       []string          `json:"categories" db:"categories"`
	Address          map[string]string `json:"address,omitempty" db:"address"`
	Location         Location          `json:"location" db:"location"`
	PrimaryImageURL  *string           `json:"primary_image_url,omitempty" db:"primary_image_url"`
	ThumbnailURL     *string           `json:"thumbnail_url,omitempty" db:"thumbnail_url"`
	Amenities        []string          `json:"amenities" db:"amenities"`
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
		PlaceType:        place.PlaceType,
		Categories:       place.Categories,
		Location: Location{
			Latitude:  place.Latitude,
			Longitude: place.Longitude,
		},
		PrimaryImageURL: lo.ToPtr(place.PrimaryImageURL),
		ThumbnailURL:    lo.ToPtr(place.ThumbnailURL),
		Amenities:       place.Amenities,
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
		ID:      image.ID,
		PlaceID: image.PlaceID,
		URL:     image.URL,
		Alt:     image.Alt,
		Pos:     image.Pos,
		BaseModel: types.BaseModel{
			Status:    types.Status(image.Status),
			CreatedAt: image.CreatedAt,
			UpdatedAt: image.UpdatedAt,
			CreatedBy: image.CreatedBy,
			UpdatedBy: image.UpdatedBy,
		},
	}

	// Convert metadata from map[string]string to types.Metadata
	// Note: This requires ent.PlaceImage to have Metadata field after regenerating ent code
	// TODO: Uncomment after regenerating ent code with MetadataMixin included
	if len(image.Metadata) > 0 {
		pi.Metadata = types.NewMetadataFromMap(image.Metadata)
	}

	return pi
}

// FromEntImageList converts a list of ent.PlaceImage to domain PlaceImage
func FromEntImageList(images []*ent.PlaceImage) []*PlaceImage {
	return lo.Map(images, func(image *ent.PlaceImage, _ int) *PlaceImage {
		return FromEntImage(image)
	})
}
