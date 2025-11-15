package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	baseMixin "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

type Hotel struct {
	ent.Schema
}

func (Hotel) Mixin() []ent.Mixin {
	return []ent.Mixin{
		baseMixin.BaseMixin{},
		baseMixin.MetadataMixin{},
	}
}

func (Hotel) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			DefaultFunc(func() string {
				return types.GenerateUUIDWithPrefix(types.UUID_PREFIX_HOTEL)
			}).
			Immutable(),
		field.String("slug").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			NotEmpty().
			Immutable(),
		field.String("name").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			NotEmpty(),
		field.String("description").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),
		field.Int("star_rating").
			SchemaType(map[string]string{
				"postgres": "integer",
			}).
			Min(1).
			Max(5).
			Default(3),
		field.Int("room_count").
			SchemaType(map[string]string{
				"postgres": "integer",
			}).
			Default(0).
			NonNegative(),
		field.Time("check_in_time").
			SchemaType(map[string]string{
				"postgres": "time",
			}).
			Optional(),
		field.Time("check_out_time").
			SchemaType(map[string]string{
				"postgres": "time",
			}).
			Optional(),
		field.JSON("address", map[string]string{}).
			SchemaType(map[string]string{
				"postgres": "jsonb",
			}).
			Optional(),
		field.Other("latitude", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,8)",
			}).
			Default(decimal.Zero),
		field.Other("longitude", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(11,8)",
			}).
			Default(decimal.Zero),
		field.String("phone").
			SchemaType(map[string]string{
				"postgres": "varchar(20)",
			}).
			Optional(),
		field.String("email").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			Optional(),
		field.String("website").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),
		field.String("primary_image_url").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),
		field.String("thumbnail_url").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),
		field.Other("price_min", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,2)",
			}).
			Default(decimal.Zero).
			Optional(),
		field.Other("price_max", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,2)",
			}).
			Default(decimal.Zero).
			Optional(),
		field.String("currency").
			SchemaType(map[string]string{
				"postgres": "varchar(3)",
			}).
			Default("INR").
			Optional(),
		// Engagement fields
		field.Int("view_count").
			SchemaType(map[string]string{
				"postgres": "integer",
			}).
			Default(0).
			NonNegative(),
		field.Other("rating_avg", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(3,2)",
			}).
			Default(decimal.Zero),
		field.Int("rating_count").
			SchemaType(map[string]string{
				"postgres": "integer",
			}).
			Default(0).
			NonNegative(),
		field.Time("last_viewed_at").
			SchemaType(map[string]string{
				"postgres": "timestamp with time zone",
			}).
			Optional(),
		field.Other("popularity_score", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,4)",
			}).
			Default(decimal.Zero),
	}
}

func (Hotel) Edges() []ent.Edge {
	return []ent.Edge{}
}

func (Hotel) Indexes() []ent.Index {
	return []ent.Index{
		// Unique slug
		index.Fields("slug", "status").
			Unique(),
		// Index for geospatial queries
		index.Fields("latitude", "longitude"),
		// Index for star rating filter
		index.Fields("star_rating"),
		// Index for price range queries
		index.Fields("price_min", "price_max"),
		// Indexes for feed functionality
		index.Fields("popularity_score"),
		index.Fields("view_count"),
		index.Fields("rating_avg"),
		index.Fields("last_viewed_at"),
		// Composite index for trending queries
		index.Fields("last_viewed_at", "popularity_score"),
	}
}
