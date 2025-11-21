package service

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/api/dto"
	"github.com/omkar273/nashikdarshan/internal/auth"
)

type AuthService interface {
	Signup(ctx context.Context, req *dto.SignupRequest) (*dto.SignupResponse, error)
}

type authService struct {
	ServiceParams ServiceParams
	AuthProvider  auth.Provider
}

func NewAuthService(params ServiceParams, authProvider auth.Provider) AuthService {
	return &authService{
		ServiceParams: params,
		AuthProvider:  authProvider,
	}
}

func (s *authService) Signup(ctx context.Context, req *dto.SignupRequest) (*dto.SignupResponse, error) {

	// validate access token
	if err := req.Validate(); err != nil {
		return nil, err
	}

	// check using supabase provider
	claims, err := s.AuthProvider.SignUp(ctx, req)
	if err != nil {
		return nil, err
	}

	onboardingService := NewOnboardingService(s.ServiceParams)
	userService := NewUserService(s.ServiceParams)
	// create user
	err = s.ServiceParams.DB.WithTx(ctx, func(ctx context.Context) error {

		userReq := req.ToUser(ctx)
		userReq.ID = claims.ID
		user, err := userService.Create(ctx, userReq)
		if err != nil {
			return err
		}

		err = onboardingService.Onboard(ctx, &dto.OnboardingRequest{
			User: *user,
		})

		if err != nil {
			return err
		}

		s.ServiceParams.Logger.Debugw("onboarded user", "user", claims.ID)

		return nil
	})

	if err != nil {
		return nil, err
	}

	return claims, nil
}
