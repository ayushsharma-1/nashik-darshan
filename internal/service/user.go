package service

import (
	"context"

	"github.com/omkar273/nashikdarshan/internal/api/dto"
	"github.com/omkar273/nashikdarshan/internal/domain/user"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type UserService interface {
	Me(ctx context.Context) (*dto.MeResponse, error)
	Update(ctx context.Context, req *dto.UpdateUserRequest) (*dto.MeResponse, error)
	Create(ctx context.Context, user *user.User) (*user.User, error)
	Get(ctx context.Context, userID string) (*user.User, error)
}

type userService struct {
	ServiceParams
}

// NewUserService creates a new user service
func NewUserService(params ServiceParams) UserService {
	return &userService{
		ServiceParams: params,
	}
}

// Me returns the current user
func (s *userService) Me(ctx context.Context) (*dto.MeResponse, error) {
	userID := types.GetUserID(ctx)

	if userID == "" {
		return nil, ierr.WithError(ierr.ErrPermissionDenied).
			WithHint("User not authenticated").
			Mark(ierr.ErrPermissionDenied)
	}

	user, err := s.UserRepo.Get(ctx, userID)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to get user").
			Mark(ierr.ErrDatabase)
	}
	return &dto.MeResponse{
		User: user,
	}, nil
}

// Update updates the current user
func (s *userService) Update(ctx context.Context, req *dto.UpdateUserRequest) (*dto.MeResponse, error) {
	userID := types.GetUserID(ctx)

	if userID == "" {
		return nil, ierr.WithError(ierr.ErrPermissionDenied).
			WithHint("User not authenticated").
			Mark(ierr.ErrPermissionDenied)
	}

	user, err := s.UserRepo.Get(ctx, userID)
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to get user").
			Mark(ierr.ErrDatabase)
	}

	if req.Name != "" {
		user.Name = req.Name
	}
	if req.Phone != "" {
		user.Phone = req.Phone
	}

	err = s.UserRepo.Update(ctx, user)
	if err != nil {
		return nil, err
	}

	return &dto.MeResponse{
		User: user,
	}, nil
}

func (s *userService) Create(ctx context.Context, user *user.User) (*user.User, error) {
	err := s.UserRepo.Create(ctx, user)
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (s *userService) Get(ctx context.Context, userID string) (*user.User, error) {
	user, err := s.UserRepo.Get(ctx, userID)
	if err != nil {
		return nil, err
	}
	return user, nil
}
