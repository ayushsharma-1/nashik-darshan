package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	mixinpkg "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/shopspring/decimal"
)

// Itinerary holds the schema definition for the Itinerary entity.
type Itinerary struct {
	ent.Schema
}

// Mixin of the Itinerary
func (Itinerary) Mixin() []ent.Mixin {
	return []ent.Mixin{
		mixinpkg.BaseMixin{},
		mixinpkg.MetadataMixin{},
	}
}

// Fields of the Itinerary.
func (Itinerary) Fields() []ent.Field {
	return []ent.Field{
		// Identity
		field.String("id").
			Immutable().
			NotEmpty().
			DefaultFunc(func() string {
				return types.GenerateUUIDWithPrefix(types.UUID_PREFIX_ITINERARY)
			}).
			Comment("Unique itinerary identifier with prefix itin_"),

		// Ownership
		field.String("user_id").
			NotEmpty().
			Comment("FK to user who owns this itinerary"),

		// Core Info
		field.String("title").
			NotEmpty().
			MaxLen(255).
			Comment("User-defined itinerary name"),

		field.Text("description").
			Optional().
			Nillable().
			Comment("Optional description or notes"),

		// Planning Details
		field.Time("planned_date").
			Default(time.Now).
			Comment("Date for which itinerary is planned"),

		field.Other("start_latitude", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,8)",
			}).
			Comment("Starting point latitude"),

		field.Other("start_longitude", decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(11,8)",
			}).
			Comment("Starting point longitude"),

		field.String("preferred_transport_mode").
			Default(string(types.TransportModeWalking)).
			Comment("Default transport mode: WALKING, DRIVING, TAXI"),

		// Optimization Results
		field.Float("total_distance_km").
			Optional().
			Nillable().
			Comment("Total distance calculated by routing engine"),

		field.Int("total_duration_minutes").
			Optional().
			Nillable().
			Comment("Total estimated duration including travel and visits"),

		field.Int("total_visit_time_minutes").
			Optional().
			Nillable().
			Comment("Sum of all visit durations"),

		// State (status is provided by BaseMixin)
		field.Bool("is_optimized").
			Default(false).
			Comment("Whether route has been optimized"),
	}
}

// Edges of the Itinerary.
func (Itinerary) Edges() []ent.Edge {
	return []ent.Edge{
		// User relationship
		edge.From("user", User.Type).
			Ref("itineraries").
			Field("user_id").
			Required().
			Unique(),

		// Visit relationship (ordered list of places)
		edge.To("visits", Visit.Type),
	}
}

// Indexes of the Itinerary.
func (Itinerary) Indexes() []ent.Index {
	return []ent.Index{
		index.Fields("user_id", "status"),
		index.Fields("user_id", "planned_date"),
		index.Fields("status"),
	}
}
