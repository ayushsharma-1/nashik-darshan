package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	mixinpkg "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/omkar273/nashikdarshan/internal/types"
)

// Visit holds the schema definition for the Visit entity.
type Visit struct {
	ent.Schema
}

// Mixin of the Visit
func (Visit) Mixin() []ent.Mixin {
	return []ent.Mixin{
		mixinpkg.BaseMixin{},
	}
}

// Fields of the Visit.
func (Visit) Fields() []ent.Field {
	return []ent.Field{
		// Identity
		field.String("id").
			Immutable().
			NotEmpty().
			DefaultFunc(func() string {
				return types.GenerateUUIDWithPrefix(types.UUID_PREFIX_VISIT)
			}).
			Comment("Unique visit identifier with prefix visit_"),

		// Relationships
		field.String("itinerary_id").
			NotEmpty().
			Comment("FK to parent itinerary"),

		field.String("place_id").
			NotEmpty().
			Comment("FK to place being visited"),

		// Sequence
		field.Int("sequence_order").
			NonNegative().
			Comment("Position in itinerary (0-indexed)"),

		// Planning
		field.Int("planned_duration_minutes").
			Positive().
			Default(60).
			Comment("Expected time to spend at this place"),

		// Routing Info (populated after optimization)
		field.Float("distance_from_previous_km").
			Optional().
			Nillable().
			Comment("Distance from previous visit in route"),

		field.Int("travel_time_from_previous_minutes").
			Optional().
			Nillable().
			Comment("Travel time from previous visit"),

		field.String("transport_mode").
			Optional().
			Nillable().
			Comment("Transport mode for this leg: WALKING, DRIVING, TAXI"),

		// Optional override notes
		field.Text("notes").
			Optional().
			Nillable().
			Comment("User notes for this visit"),
	}
}

// Edges of the Visit.
func (Visit) Edges() []ent.Edge {
	return []ent.Edge{
		// Itinerary relationship
		edge.From("itinerary", Itinerary.Type).
			Ref("visits").
			Field("itinerary_id").
			Required().
			Unique(),

		// Place relationship
		edge.From("place", Place.Type).
			Ref("visits").
			Field("place_id").
			Required().
			Unique(),
	}
}

// Indexes of the Visit.
func (Visit) Indexes() []ent.Index {
	return []ent.Index{
		// Fast lookup of visits in an itinerary, ordered
		index.Fields("itinerary_id", "sequence_order").
			Unique(),

		// Find all itineraries that visit a place
		index.Fields("place_id"),
	}
}
