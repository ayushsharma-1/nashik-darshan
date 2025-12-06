package types

// Status is a type for the status of a resource (e.g. place, event, hotel, etc.) in the Database
// This is used to track the lifecycle of a resource and to determine if it should be included in queries
// Any changes to this type should be reflected in the database schema by running migrations
type Status string

const (
	// StatusPublished is the status of a resource that is published and visible to users
	// This is the default active state for publicly visible content
	StatusPublished Status = "published"

	// StatusDraft is the status of a resource that is in draft and not yet published
	// This is used for data that is being created but not yet ready to be published
	// Draft items are typically only visible to creators/admins
	StatusDraft Status = "draft"

	// StatusArchived is the status of a resource that is archived (soft-deleted but reversible)
	// This is used for data that is no longer active but kept for historical/audit purposes
	// Archived items are excluded from default queries and not visible to regular users
	// Archived items CAN be restored back to published status
	StatusArchived Status = "archived"

	// StatusDeleted is the status of a resource that is permanently deleted
	// This is used for data that should NEVER be included in queries under any circumstances
	// Deleted items are ALWAYS excluded from queries and cannot be restored
	// Unlike archived, deleted status is irreversible - use with caution
	StatusDeleted Status = "deleted"
)
