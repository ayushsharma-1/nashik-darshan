package types

import (
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/samber/lo"
)

type UserRole string

const (
	UserRoleUser  UserRole = "USER"
	UserRoleAdmin UserRole = "ADMIN"
)

var UserRoles = []string{
	string(UserRoleUser),
	string(UserRoleAdmin),
}

type UserFilter struct {
	*QueryFilter
	*TimeRangeFilter

	// custom filters
	Roles  []string `json:"roles" form:"roles" validate:"omitempty"`
	Email  []string `json:"email" form:"email" validate:"omitempty,email"`
	Phone  []string `json:"phone" form:"phone" validate:"omitempty"`
	Status Status   `json:"status" form:"status" validate:"omitempty"`
}

func (f *UserFilter) Validate() error {
	if err := f.QueryFilter.Validate(); err != nil {
		return err
	}

	if err := f.TimeRangeFilter.Validate(); err != nil {
		return err
	}

	if len(f.Roles) > 0 {
		for _, role := range f.Roles {
			if !lo.Contains(UserRoles, role) {
				return ierr.NewError("invalid role").
					WithHint("valid roles are: " + string(UserRoleUser) + ", " + string(UserRoleAdmin)).
					WithReportableDetails(map[string]any{"role": role}).
					Mark(ierr.ErrValidation)
			}
		}
	}

	return nil
}

func NewUserFilter() *UserFilter {
	return &UserFilter{
		QueryFilter:     NewDefaultQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

func NewNoLimitUserFilter() *UserFilter {
	return &UserFilter{
		QueryFilter:     NewNoLimitQueryFilter(),
		TimeRangeFilter: &TimeRangeFilter{},
	}
}

// GetLimit implements BaseFilter interface
func (f *UserFilter) GetLimit() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetLimit()
	}
	return f.QueryFilter.GetLimit()
}

// GetOffset implements BaseFilter interface
func (f *UserFilter) GetOffset() int {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOffset()
	}
	return f.QueryFilter.GetOffset()
}

// GetStatus implements BaseFilter interface
func (f *UserFilter) GetStatus() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetStatus()
	}
	return f.QueryFilter.GetStatus()
}

// GetSort implements BaseFilter interface
func (f *UserFilter) GetSort() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetSort()
	}
	return f.QueryFilter.GetSort()
}

// GetOrder implements BaseFilter interface
func (f *UserFilter) GetOrder() string {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetOrder()
	}
	return f.QueryFilter.GetOrder()
}

// GetExpand implements BaseFilter interface
func (f *UserFilter) GetExpand() Expand {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().GetExpand()
	}
	return f.QueryFilter.GetExpand()
}

func (f *UserFilter) IsUnlimited() bool {
	if f.QueryFilter == nil {
		return NewDefaultQueryFilter().IsUnlimited()
	}
	return f.QueryFilter.IsUnlimited()
}
