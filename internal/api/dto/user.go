package dto

import "github.com/omkar273/nashikdarshan/internal/domain/user"

type MeResponse struct {
	*user.User
}

type UpdateUserRequest struct {
	Name  string `json:"name,omitempty" binding:"omitempty,min=2,max=255"`
	Phone string `json:"phone,omitempty" binding:"omitempty,min=10,max=20"`
}
