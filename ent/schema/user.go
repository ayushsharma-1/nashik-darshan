package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	baseMixin "github.com/omkar273/codegeeky/ent/mixin"
	"github.com/omkar273/codegeeky/internal/types"
)

type User struct {
	ent.Schema
}

// Mixin of the User.
func (User) Mixin() []ent.Mixin {
return []ent.Mixin{
		baseMixin.BaseMixin{},
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
	return []ent.Edge{}
}

// Indexes of the User.
func (User) Indexes() []ent.Index {
	return []ent.Index{
		index.Fields("email", "phone").
			Unique(),
		index.Fields("email").
			Unique(),
		index.Fields("phone").
			Unique(),
	}
}
