package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	baseMixin "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type User struct {
	ent.Schema
}

// Mixin of the User.
func (User) Mixin() []ent.Mixin {
	return []ent.Mixin{
		baseMixin.BaseMixin{},
		baseMixin.MetadataMixin{},
	}
}

func (User) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			DefaultFunc(func() string {
				return types.GenerateUUIDWithPrefix(types.UUID_PREFIX_USER)
			}).
			Immutable(),
		field.String("name").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			NotEmpty(),
		field.String("email").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			NotEmpty(),
		field.String("phone").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			Nillable(),

		field.String("role").
			SchemaType(map[string]string{
				"postgres": "varchar(255)",
			}).
			Default(string(types.UserRoleUser)).
			NotEmpty(),
	}
}

func (User) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("itineraries", Itinerary.Type),
	}
}

func (User) Indexes() []ent.Index {
	return []ent.Index{
		// Partial unique index for email - only when email is not empty
		index.Fields("email").
			Unique().
			Annotations(
				entsql.IndexWhere("email IS NOT NULL AND email != ''"),
			),
		// Partial unique index for phone - only when phone is not null and not empty
		index.Fields("phone").
			Unique().
			Annotations(
				entsql.IndexWhere("phone IS NOT NULL AND phone != ''"),
			),
		// Partial unique index for email and phone combination - only when both are not empty
		index.Fields("email", "phone").
			Unique().
			Annotations(
				entsql.IndexWhere("(email IS NOT NULL AND email != '') AND (phone IS NOT NULL AND phone != '')"),
			),
	}
}
