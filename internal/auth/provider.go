package auth

import (
	"context"

	"github.com/omkar273/codegeeky/internal/api/dto"
	"github.com/omkar273/codegeeky/internal/domain/auth"
	"github.com/omkar273/codegeeky/internal/domain/user"
	"github.com/omkar273/codegeeky/internal/types"
)

type Provider interface {
	// Core Authentication
	GetProvider() types.AuthProvider
	ValidateToken(ctx context.Context, token string) (*auth.Claims, error)

	// User Management (for server-side operations only)
	SignUp(ctx context.Context, req *dto.SignupRequest) (*dto.SignupResponse, error)

	// User Profile Management (server-side operations)
	GetUser(ctx context.Context, userToken string) (*user.User, error)
	UpdateUser(ctx context.Context, userToken string, updateData map[string]interface{}) (*user.User, error)

	// Cleanup
	Close() error
}
