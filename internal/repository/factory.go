package repository

import (
	"github.com/omkar273/nashikdarshan/internal/config"
	"github.com/omkar273/nashikdarshan/internal/domain/category"
	"github.com/omkar273/nashikdarshan/internal/domain/place"
	"github.com/omkar273/nashikdarshan/internal/domain/user"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/postgres"
	"github.com/omkar273/nashikdarshan/internal/repository/ent"
	"go.uber.org/fx"
)

type RepositoryParams struct {
	// factory params
	fx.In

	Client postgres.IClient
	Logger *logger.Logger
	Config *config.Configuration
}

func NewRepositoryParams(
	Client *postgres.Client,
	Logger *logger.Logger,
	Config *config.Configuration,
) RepositoryParams {
	return RepositoryParams{
		Client: Client,
		Logger: Logger,
	}
}

func NewUserRepository(params RepositoryParams) user.Repository {
	return ent.NewUserRepository(params.Client, params.Logger)
}

func NewCategoryRepository(params RepositoryParams) category.Repository {
	return ent.NewCategoryRepository(params.Client, params.Logger)
}

func NewPlaceRepository(params RepositoryParams) place.Repository {
	return ent.NewPlaceRepository(params.Client, params.Logger)
}
