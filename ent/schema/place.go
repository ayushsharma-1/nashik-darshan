package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	baseMixin "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

type Place struct {
	ent.Schema
}

func (Place) Mixin() []ent.Mixin {
	return []ent.Mixin{
		baseMixin.BaseMixin{},
		baseMixin.MetadataMixin{},
	}
}

func (Place) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			DefaultFunc(func() string {
				return types.GenerateUUIDWithPrefix(types.UUID_PREFIX_PLACE)
			}).
			Immutable(),

		field.String("slug").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Immutable().
			NotEmpty(),

		field.String("title").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			NotEmpty(),

		field.String("subtitle").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),

		field.String("short_description").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),

		field.String("long_description").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Optional(),

		field.String("place_type").
			SchemaType(map[string]string{
				"postgres": "text",
			}).
			Immutable().
			NotEmpty(),

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

		// Engagement fields for feed functionality
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

		// Itinerary Planning
		field.Int("avg_visit_minutes").
			SchemaType(map[string]string{
				"postgres": "integer",
			}).
			Default(60).
			Comment("Average time visitors spend at this place"),

		field.JSON("opening_hours", map[string]string{}).
			SchemaType(map[string]string{
				"postgres": "jsonb",
			}).
			Optional().
			Comment("Opening hours by day: {monday: '9:00-18:00', ...}"),
	}
}

func (Place) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("images", PlaceImage.Type),
		edge.From("category", Category.Type).
			Ref("places"),
		edge.To("visits", Visit.Type),
	}
}

func (Place) Indexes() []ent.Index {
	return []ent.Index{
		// TODO: Add indexes
	}
}
