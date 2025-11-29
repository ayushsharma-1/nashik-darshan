package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
	mixinpkg "github.com/omkar273/nashikdarshan/ent/mixin"
)

// EventOccurrence holds the schema definition for the EventOccurrence entity.
type EventOccurrence struct {
	ent.Schema
}

// Mixin of the EventOccurrence
func (EventOccurrence) Mixin() []ent.Mixin {
	return []ent.Mixin{
		mixinpkg.BaseMixin{},
		mixinpkg.MetadataMixin{},
	}
}

// Fields of the EventOccurrence.
func (EventOccurrence) Fields() []ent.Field {
	return []ent.Field{
		// Identity
		field.String("id").
			Immutable().
			NotEmpty().
			Comment("Unique occurrence identifier with prefix occ_"),

		field.String("event_id").
			NotEmpty().
			Comment("FK to parent event"),

		// Recurrence Pattern
		field.String("recurrence_type").
			NotEmpty().
			Comment("How this occurrence repeats: NONE, DAILY, WEEKLY, MONTHLY, YEARLY"),

		// Time Configuration
		field.Time("start_time").
			Optional().
			Nillable().
			Comment("Time of day (only time component used)"),

		field.Time("end_time").
			Optional().
			Nillable().
			Comment("End time of day (only time component used)"),

		field.Int("duration_minutes").
			Optional().
			Nillable().
			Comment("Auto-calculated duration"),

		// Day-specific fields (for recurrence logic)
		field.Int("day_of_week").
			Optional().
			Nillable().
			Min(0).
			Max(6).
			Comment("0=Sunday, 6=Saturday - for WEEKLY"),

		field.Int("day_of_month").
			Optional().
			Nillable().
			Min(1).
			Max(31).
			Comment("1-31 - for MONTHLY/YEARLY"),

		field.Int("month_of_year").
			Optional().
			Nillable().
			Min(1).
			Max(12).
			Comment("1-12 - for YEARLY only"),

		// Exception Dates (skip specific dates)
		field.JSON("exception_dates", []string{}).
			Optional().
			Comment("ISO dates to skip: ['2025-12-25', '2025-01-26']"),
	}
}

// Edges of the EventOccurrence.
func (EventOccurrence) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("event", Event.Type).
			Ref("occurrences").
			Field("event_id").
			Unique().
			Required(),
	}
}

// Indexes of the EventOccurrence.
func (EventOccurrence) Indexes() []ent.Index {
	return []ent.Index{
		// Primary lookup: Most selective field first (event_id narrows down rows significantly)
		// Query pattern: WHERE event_id = ? AND status = ?
		index.Fields("event_id", "status"),

		// Recurrence type queries: WHERE recurrence_type = ? AND status = ?
		// recurrence_type first (fewer distinct values but combined with status is selective)
		index.Fields("recurrence_type", "status"),

		// Weekly recurrence: WHERE day_of_week = ? AND status = ? (7 possible values)
		// Status second to further filter after day_of_week
		index.Fields("day_of_week", "status"),

		// Monthly recurrence: WHERE day_of_month = ? AND status = ? (31 possible values)
		// day_of_month first (more selective than status with 31 distinct values)
		index.Fields("day_of_month", "status"),

		// Yearly recurrence: WHERE month_of_year = ? AND day_of_month = ? AND status = ?
		// Order: month (12 values) -> day (31 values) -> status (3-4 values)
		// This follows PostgreSQL left-to-right index scan optimization
		index.Fields("month_of_year", "day_of_month", "status"),

		// Consider partial indexes for production to reduce index size:
		// CREATE INDEX idx_occ_event_published ON event_occurrences (event_id) WHERE status = 'PUBLISHED';
		// CREATE INDEX idx_occ_weekly_published ON event_occurrences (day_of_week, start_time) WHERE status = 'PUBLISHED' AND recurrence_type = 'WEEKLY';
	}
}
