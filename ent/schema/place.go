package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	baseMixin "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/omkar273/nashikdarshan/internal/types"
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
			NotEmpty(),
		field.Strings("categories").
			SchemaType(map[string]string{
				"postgres": "text[]",
			}).
			Optional(),
		field.JSON("address", map[string]interface{}{}).
			SchemaType(map[string]string{
				"postgres": "jsonb",
			}).
			Optional(),
		// location will be handled as a string in ent, but stored as geography(Point,4326) in postgres
		field.String("location").
			SchemaType(map[string]string{
				"postgres": "geography(Point,4326)",
			}).
			NotEmpty(),
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
		field.Strings("amenities").
			SchemaType(map[string]string{
				"postgres": "text[]",
			}).
			Optional(),
	}
}

func (Place) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("images", PlaceImage.Type),
	}
}

func (Place) Indexes() []ent.Index {
	return []ent.Index{
		// Unique slug
		index.Fields("slug", "status").
			Unique(),
	}
}
