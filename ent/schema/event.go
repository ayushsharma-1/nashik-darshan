package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	mixinpkg "github.com/omkar273/nashikdarshan/ent/mixin"
	"github.com/shopspring/decimal"
)

// Event holds the schema definition for the Event entity.
type Event struct {
	ent.Schema
}

// Mixin of the Event
func (Event) Mixin() []ent.Mixin {
	return []ent.Mixin{
		mixinpkg.BaseMixin{},
		mixinpkg.MetadataMixin{},
	}
}

// Fields of the Event.
func (Event) Fields() []ent.Field {
	return []ent.Field{
		// Identity
		field.String("id").
			Immutable().
			NotEmpty().
			Comment("Unique event identifier with prefix evt_"),

		field.String("slug").
			Unique().
			NotEmpty().
			Immutable().
			Comment("URL-friendly unique identifier"),

		// Core Info
		field.String("type").
			NotEmpty().
			Comment("Event category for filtering and display"),

		field.String("title").
			NotEmpty().
			MaxLen(255).
			Comment("Event name"),

		field.String("subtitle").
			Optional().
			Nillable().
			MaxLen(500).
			Comment("Brief tagline"),

		field.Text("description").
			Optional().
			Nillable().
			Comment("Detailed description with markdown support"),

		// Association
		field.String("place_id").
			Optional().
			Nillable().
			Comment("FK to place - NULL means citywide event"),

		// Validity Window
		field.Time("start_date").
			Comment("Event becomes active from this date"),

		field.Time("end_date").
			Optional().
			Nillable().
			Comment("Event expires after this date (NULL = ongoing)"),

		// Media
		field.String("cover_image_url").
			Optional().
			Nillable().
			Comment("Event banner/poster image"),

		field.JSON("images", []string{}).
			Optional().
			Comment("Additional event images"),

		// Tags
		field.JSON("tags", []string{}).
			Optional().
			Comment("Searchable tags: morning, evening, spiritual, etc"),

		// Location (for citywide events without place_id)
		field.Other("latitude", &decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,8)",
			}).
			Optional().
			Nillable().
			Comment("Latitude for standalone events"),

		field.Other("longitude", &decimal.Decimal{}).
			SchemaType(map[string]string{
				"postgres": "decimal(10,8)",
			}).
			Optional().
			Nillable().
			Comment("Longitude for standalone events"),

		field.String("location_name").
			Optional().
			Nillable().
			MaxLen(255).
			Comment("Text location for citywide events"),

		// Stats (cached for performance)
		field.Int("view_count").
			Default(0).
			NonNegative().
			Comment("Total views"),

		field.Int("interested_count").
			Default(0).
			NonNegative().
			Comment("Users who marked interested"),
	}
}

// Edges of the Event.
func (Event) Edges() []ent.Edge {
	return []ent.Edge{
		// One event has many occurrence slots
		edge.To("occurrences", EventOccurrence.Type),
	}
}

// Indexes of the Event.
func (Event) Indexes() []ent.Index {
	return []ent.Index{
		// Primary lookup - unique constraint
		index.Fields("slug").Unique(),

		// Filter combinations: Most selective field FIRST (PostgreSQL optimization)
		// Query pattern: WHERE place_id = ? AND status = ?
		index.Fields("place_id", "status"),

		// Query pattern: WHERE type = ? AND status = ?
		index.Fields("type", "status"),

		// Query pattern: WHERE status = ? AND start_date >= ? (filtering + sorting)
		// Status first because it filters more rows (published/draft/archived)
		index.Fields("status", "start_date"),

		// Date range queries: WHERE start_date >= ? AND (end_date IS NULL OR end_date <= ?)
		index.Fields("start_date", "end_date"),

		// Sorting queries with filter: WHERE status = ? ORDER BY view_count DESC
		// Status first (filter) then sort column (view_count DESC benefits from this)
		index.Fields("status", "view_count"),

		// Sorting queries with filter: WHERE status = ? ORDER BY interested_count DESC
		index.Fields("status", "interested_count"),

		// Note: For JSONB tags containment queries (@> operator), create GIN index manually:
		// CREATE INDEX idx_events_tags_gin ON events USING GIN (tags);
		//
		// Consider partial indexes for production:
		// CREATE INDEX idx_events_published ON events (start_date, view_count) WHERE status = 'PUBLISHED';
		// CREATE INDEX idx_events_active_type ON events (type, start_date) WHERE status = 'PUBLISHED';
	}
}
