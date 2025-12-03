package ent

import (
	"context"
	"time"

	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/ent/category"
	domain "github.com/omkar273/nashikdarshan/internal/domain/category"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type CategoryRepository struct {
	client    postgres.IClient
	log       logger.Logger
	queryOpts CategoryQueryOptions
}

func NewCategoryRepository(client postgres.IClient, logger *logger.Logger) domain.Repository {
	return &CategoryRepository{
		client:    client,
		log:       *logger,
		queryOpts: CategoryQueryOptions{},
	}
}

func (r *CategoryRepository) Create(ctx context.Context, c *domain.Category) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("creating category",
		"category_id", c.ID,
		"name", c.Name,
		"slug", c.Slug,
	)

	create := client.Category.Create().
		SetID(c.ID).
		SetName(c.Name).
		SetSlug(c.Slug).
		SetStatus(string(c.Status)).
		SetDescription(c.Description).
		SetCreatedAt(c.CreatedAt).
		SetUpdatedAt(c.UpdatedAt).
		SetCreatedBy(c.CreatedBy).
		SetUpdatedBy(c.UpdatedBy)

	// Always set metadata explicitly to avoid JSONB serialization issues
	metadataMap := make(map[string]string)
	if c.Metadata != nil && len(c.Metadata.ToMap()) > 0 {
		metadataMap = c.Metadata.ToMap()
	}
	create = create.SetMetadata(metadataMap)

	_, err := create.Save(ctx)

	if err != nil {
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Category with this slug already exists").
				WithReportableDetails(map[string]any{
					"category_id": c.ID,
					"slug":        c.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to create category").
			WithReportableDetails(map[string]any{
				"category_id": c.ID,
				"name":        c.Name,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *CategoryRepository) Get(ctx context.Context, id string) (*domain.Category, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting category", "category_id", id)

	entCategory, err := client.Category.Query().
		Where(category.ID(id)).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Category with ID %s was not found", id).
				WithReportableDetails(map[string]any{
					"category_id": id,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get category").
			WithReportableDetails(map[string]any{
				"category_id": id,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entCategory), nil
}

func (r *CategoryRepository) GetBySlug(ctx context.Context, slug string) (*domain.Category, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("getting category by slug", "slug", slug)

	entCategory, err := client.Category.Query().
		Where(
			category.Slug(slug),
			category.Status(string(types.StatusPublished)),
		).
		Only(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, ierr.WithError(err).
				WithHintf("Category with slug %s was not found", slug).
				WithReportableDetails(map[string]any{
					"slug": slug,
				}).
				Mark(ierr.ErrNotFound)
		}
		return nil, ierr.WithError(err).
			WithHint("Failed to get category by slug").
			WithReportableDetails(map[string]any{
				"slug": slug,
			}).
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEnt(entCategory), nil
}

func (r *CategoryRepository) List(ctx context.Context, filter *types.CategoryFilter) ([]*domain.Category, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("listing categories",
		"limit", filter.GetLimit(),
		"offset", filter.GetOffset(),
	)

	query := client.Category.Query()

	// Apply entity-specific filters first
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	// Apply common query options (status, pagination, sorting)
	query = ApplyQueryOptions(ctx, query, filter, r.queryOpts)

	categories, err := query.All(ctx)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to list categories").
			Mark(ierr.ErrDatabase)
	}

	return domain.FromEntList(categories), nil
}

func (r *CategoryRepository) ListAll(ctx context.Context, filter *types.CategoryFilter) ([]*domain.Category, error) {
	if filter == nil {
		filter = types.NewNoLimitCategoryFilter()
	}

	if filter.QueryFilter == nil {
		filter.QueryFilter = types.NewNoLimitQueryFilter()
	}

	categories, err := r.List(ctx, filter)
	if err != nil {
		return nil, err
	}
	return categories, nil
}

func (r *CategoryRepository) Count(ctx context.Context, filter *types.CategoryFilter) (int, error) {
	client := r.client.Querier(ctx)

	r.log.Debugw("counting categories")

	query := client.Category.Query()

	// Apply base filters (status only, no pagination/sorting)
	query = ApplyBaseFilters(ctx, query, filter, r.queryOpts)

	// Apply entity-specific filters
	query = r.queryOpts.ApplyEntityQueryOptions(ctx, filter, query)

	count, err := query.Count(ctx)
	if err != nil {
		return 0, ierr.WithError(err).
			WithHint("Failed to count categories").
			WithReportableDetails(map[string]any{
				"filter": filter,
			}).
			Mark(ierr.ErrDatabase)
	}

	return count, nil
}

func (r *CategoryRepository) Update(ctx context.Context, c *domain.Category) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("updating category",
		"category_id", c.ID,
		"name", c.Name,
	)

	update := client.Category.UpdateOneID(c.ID).
		SetName(c.Name).
		SetSlug(c.Slug).
		SetDescription(c.Description).
		SetStatus(string(c.Status)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx))

	if c.Metadata != nil {
		update = update.SetMetadata(c.Metadata.ToMap())
	}

	_, err := update.Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Category with ID %s was not found", c.ID).
				WithReportableDetails(map[string]any{
					"category_id": c.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		if ent.IsConstraintError(err) {
			return ierr.WithError(err).
				WithHint("Category with this slug already exists").
				WithReportableDetails(map[string]any{
					"category_id": c.ID,
					"slug":        c.Slug,
				}).
				Mark(ierr.ErrAlreadyExists)
		}
		return ierr.WithError(err).
			WithHint("Failed to update category").
			WithReportableDetails(map[string]any{
				"category_id": c.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

func (r *CategoryRepository) Delete(ctx context.Context, c *domain.Category) error {
	client := r.client.Querier(ctx)

	r.log.Debugw("deleting category",
		"category_id", c.ID,
	)

	_, err := client.Category.UpdateOneID(c.ID).
		SetStatus(string(types.StatusArchived)).
		SetUpdatedAt(time.Now().UTC()).
		SetUpdatedBy(types.GetUserID(ctx)).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return ierr.WithError(err).
				WithHintf("Category with ID %s was not found", c.ID).
				WithReportableDetails(map[string]any{
					"category_id": c.ID,
				}).
				Mark(ierr.ErrNotFound)
		}
		return ierr.WithError(err).
			WithHint("Failed to delete category").
			WithReportableDetails(map[string]any{
				"category_id": c.ID,
			}).
			Mark(ierr.ErrDatabase)
	}

	return nil
}

// CategoryQuery type alias for better readability
type CategoryQuery = *ent.CategoryQuery

// CategoryQueryOptions implements query options for category queries
type CategoryQueryOptions struct{}

// Ensure CategoryQueryOptions implements BaseQueryOptions interface
var _ BaseQueryOptions[CategoryQuery] = (*CategoryQueryOptions)(nil)

func (o CategoryQueryOptions) ApplyStatusFilter(query CategoryQuery, status string) CategoryQuery {
	if status == "" {
		return query.Where(category.StatusNotIn(string(types.StatusDeleted)))
	}
	return query.Where(category.Status(status))
}

func (o CategoryQueryOptions) ApplySortFilter(query CategoryQuery, field string, order string) CategoryQuery {
	// Validate order
	if order != types.OrderAsc && order != types.OrderDesc {
		order = types.OrderDesc
	}
	// Default field if empty
	if field == "" {
		field = "created_at"
	}

	fieldName := o.GetFieldName(field)
	if order == types.OrderDesc {
		return query.Order(ent.Desc(fieldName))
	}
	return query.Order(ent.Asc(fieldName))
}

func (o CategoryQueryOptions) ApplyPaginationFilter(query CategoryQuery, limit int, offset int) CategoryQuery {
	// Validate pagination values
	if limit <= 0 {
		limit = 20 // Default limit
	}
	if offset < 0 {
		offset = 0
	}
	if limit > 1000 {
		limit = 1000
	}

	return query.Offset(offset).Limit(limit)
}

func (o CategoryQueryOptions) GetFieldName(field string) string {
	switch field {
	case "created_at":
		return category.FieldCreatedAt
	case "updated_at":
		return category.FieldUpdatedAt
	case "name":
		return category.FieldName
	case "slug":
		return category.FieldSlug
	default:
		return field
	}
}

func (o CategoryQueryOptions) ApplyEntityQueryOptions(
	_ context.Context,
	f *types.CategoryFilter,
	query CategoryQuery,
) CategoryQuery {
	if f == nil {
		return query
	}

	// Apply slug filter if specified
	if len(f.Slug) > 0 {
		query = query.Where(category.SlugIn(f.Slug...))
	}

	// Apply name filter if specified
	if len(f.Name) > 0 {
		query = query.Where(category.NameIn(f.Name...))
	}

	// Apply time range filters if specified
	if f.TimeRangeFilter != nil {
		if f.StartTime != nil {
			query = query.Where(category.CreatedAtGTE(*f.StartTime))
		}
		if f.EndTime != nil {
			query = query.Where(category.CreatedAtLTE(*f.EndTime))
		}
	}

	return query
}
