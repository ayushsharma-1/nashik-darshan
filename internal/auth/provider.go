package auth

import (
	"context"

	"github.com/omkar273/codegeeky/internal/api/dto"
	"github.com/omkar273/codegeeky/internal/domain/auth"
	"github.com/omkar273/codegeeky/internal/types"
)

// AuthenticatedDetails represents authenticated user details
type AuthenticatedDetails struct {
	User         *User  `json:"user"`
	AccessToken  string `json:"access_token"`
	RefreshToken string `json:"refresh_token"`
	ExpiresIn    int    `json:"expires_in"`
	TokenType    string `json:"token_type"`
}

// User represents a user in the system
type User struct {
	ID        string                 `json:"id"`
	Email     string                 `json:"email"`
	Phone     string                 `json:"phone,omitempty"`
	Metadata  map[string]interface{} `json:"metadata,omitempty"`
	CreatedAt string                 `json:"created_at,omitempty"`
	UpdatedAt string                 `json:"updated_at,omitempty"`
}

// ProviderSignInDetails represents OAuth provider sign-in details
type ProviderSignInDetails struct {
	URL        string `json:"url"`
	Provider   string `json:"provider"`
	RedirectTo string `json:"redirect_to"`
}
   
type Provider interface {
	// Core Authentication
	GetProvider() types.AuthProvider
	ValidateToken(ctx context.Context, token string) (*auth.Claims, error)

	// User Management (for server-side operations only)
	SignUp(ctx context.Context, req *dto.SignupRequest) (*dto.SignupResponse, error)

	// User Profile Management (server-side operations)
	GetUser(ctx context.Context, userToken string) (*User, error)
	UpdateUser(ctx context.Context, userToken string, updateData map[string]interface{}) (*User, error)

	// Cleanup
	Close() error
}
