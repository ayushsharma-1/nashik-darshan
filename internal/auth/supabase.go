package auth

import (
	"context"

	"github.com/nedpals/supabase-go"
	"github.com/omkar273/codegeeky/internal/api/dto"
	"github.com/omkar273/codegeeky/internal/config"
	"github.com/omkar273/codegeeky/internal/domain/auth"
	"github.com/omkar273/codegeeky/internal/domain/user"
	ierr "github.com/omkar273/codegeeky/internal/errors"
	"github.com/omkar273/codegeeky/internal/logger"
	"github.com/omkar273/codegeeky/internal/types"
)

type SupabaseProvider struct {
	supabase *supabase.Client
	logger   *logger.Logger
}

// NewSupabaseProvider creates a new Supabase authentication provider
func NewSupabaseProvider(cfg *config.Configuration, logger *logger.Logger) Provider {
	client := supabase.CreateClient(cfg.Supabase.URL, cfg.Supabase.SecretKey)
	if client == nil {
		logger.Fatal("failed to create supabase client")
		return nil
	}

	return &SupabaseProvider{
		supabase: client,
		logger:   logger,
	}
}

func (p *SupabaseProvider) GetProvider() types.AuthProvider {
	return types.AuthProviderSupabase
}

// ValidateToken validates a JWT token using Supabase SDK and returns the claims
func (p *SupabaseProvider) ValidateToken(ctx context.Context, token string) (*auth.Claims, error) {
	if token == "" {
		return nil, ierr.NewError("token is required").
			WithHint("Please provide a valid access token").
			Mark(ierr.ErrValidation)
	}

	supabaseUser, err := p.supabase.Auth.User(ctx, token)
	if err != nil {
		p.logger.Error("Failed to validate token", "error", err)
		return nil, ierr.NewErrorf("invalid or expired token: %w", err).
			WithHint("Please provide a valid access token").
			Mark(ierr.ErrValidation)
	}

	claims := &auth.Claims{
		UserID: supabaseUser.ID,
		Email:  supabaseUser.Email,
	}

	p.logger.Debug("Token validated", "user_id", claims.UserID, "email", claims.Email)
	return claims, nil
}

// SignUp validates a user signup through Supabase token validation
func (p *SupabaseProvider) SignUp(ctx context.Context, req *dto.SignupRequest) (*dto.SignupResponse, error) {
	if req.AccessToken == "" {
		return nil, ierr.NewError("access token is required").
			WithHint("Please provide a valid access token").
			Mark(ierr.ErrPermissionDenied)
	}

	claims, err := p.ValidateToken(ctx, req.AccessToken)
	if err != nil {
		return nil, err
	}

	// Validate email match if provided
	if req.Email != "" && claims.Email != req.Email {
		p.logger.Error("Email mismatch", "claim_email", claims.Email, "request_email", req.Email)
		return nil, ierr.NewError("email mismatch").
			WithHint("The email in the token does not match the provided email").
			Mark(ierr.ErrPermissionDenied)
	}

	return &dto.SignupResponse{
		ID:          claims.UserID,
		AccessToken: req.AccessToken,
	}, nil
}

// GetUser retrieves user information from Supabase by token
func (p *SupabaseProvider) GetUser(ctx context.Context, userToken string) (*user.User, error) {
	supabaseUser, err := p.supabase.Auth.User(ctx, userToken)
	if err != nil {
		p.logger.Error("Failed to get user", "error", err)
		return nil, ierr.NewErrorf("failed to get user: %w", err).
			WithHint("Failed to retrieve user information").
			Mark(ierr.ErrInternal)
	}

	return &user.User{
		ID:    supabaseUser.ID,
		Email: supabaseUser.Email,
		Phone: "",
		BaseModel: types.BaseModel{
			CreatedAt: supabaseUser.CreatedAt,
			UpdatedAt: supabaseUser.UpdatedAt,
		},
	}, nil
}

// UpdateUser updates user information in Supabase
func (p *SupabaseProvider) UpdateUser(ctx context.Context, userToken string, updateData map[string]interface{}) (*user.User, error) {
	supabaseUser, err := p.supabase.Auth.UpdateUser(ctx, userToken, updateData)
	if err != nil {
		p.logger.Error("Failed to update user", "error", err)
		return nil, ierr.NewErrorf("failed to update user: %w", err).
			WithHint("Failed to update user information").
			Mark(ierr.ErrInternal)
	}

	return &user.User{
		ID:    supabaseUser.ID,
		Email: supabaseUser.Email,
		Phone: "",
		BaseModel: types.BaseModel{
			CreatedAt: supabaseUser.CreatedAt,
			UpdatedAt: supabaseUser.UpdatedAt,
		},
	}, nil
}

// Close cleans up resources used by the provider
func (p *SupabaseProvider) Close() error {
	p.logger.Info("Supabase provider closed")
	return nil
}
