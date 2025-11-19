package service

import (
	"github.com/omkar273/nashikdarshan/internal/config"
	"github.com/omkar273/nashikdarshan/internal/domain/category"
	"github.com/omkar273/nashikdarshan/internal/domain/hotel"
	"github.com/omkar273/nashikdarshan/internal/domain/place"
	"github.com/omkar273/nashikdarshan/internal/domain/review"
	"github.com/omkar273/nashikdarshan/internal/domain/user"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"go.uber.org/fx"
)

type ServiceParams struct {
	fx.In

	// Core dependencies
	Logger *logger.Logger
	Config *config.Configuration
	DB     postgres.IClient

	// Repository dependencies
	UserRepo     user.Repository
	CategoryRepo category.Repository
	PlaceRepo    place.Repository
	ReviewRepo   review.Repository
	HotelRepo    hotel.Repository
}
