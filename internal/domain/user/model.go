package user

import (
	"github.com/omkar273/codegeeky/ent"
	"github.com/omkar273/codegeeky/internal/types"
	"github.com/samber/lo"
)

type User struct {
	ID    string         `json:"id" db:"id"`
	Email string         `json:"email" db:"email"`
	Phone string         `json:"phone" db:"phone"`
	Name  string         `json:"name" db:"name"`
	Role  types.UserRole `json:"role" db:"role"`
	types.BaseModel
}

func FromEnt(user *ent.User) *User {
	return &User{
		ID:    user.ID,
		Email: user.Email,
		Phone: *user.Phone,
		Name:  user.Name,
		Role:  types.UserRole(user.Role),
		BaseModel: types.BaseModel{
			Status:    types.Status(user.Status),
			CreatedAt: user.CreatedAt,
			UpdatedAt: user.UpdatedAt,
			CreatedBy: user.CreatedBy,
			UpdatedBy: user.UpdatedBy,
		},
	}
}

func FromEntList(users []*ent.User) []*User {
	return lo.Map(users, func(user *ent.User, _ int) *User {
		return FromEnt(user)
	})
}
