package api

import (
	"github.com/gin-gonic/gin"
	v1 "github.com/omkar273/nashikdarshan/internal/api/v1"
	"github.com/omkar273/nashikdarshan/internal/config"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/rest/middleware"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

type Handlers struct {
	Health   *v1.HealthHandler
	Auth     *v1.AuthHandler
	User     *v1.UserHandler
	Category *v1.CategoryHandler
	Place    *v1.PlaceHandler
}

func NewRouter(handlers *Handlers, cfg *config.Configuration, logger *logger.Logger) *gin.Engine {
	router := gin.Default()
	router.Use(
		middleware.CORSMiddleware,
		middleware.RequestIDMiddleware,
		middleware.ErrorHandler(),
	)

	// Swagger documentation
	router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	// Global health check
	router.GET("/health", handlers.Health.Health)

	v1Router := router.Group("/v1")

	// Public routes
	v1Auth := v1Router.Group("/auth")
	v1Auth.Use(middleware.GuestAuthenticateMiddleware)
	v1Auth.POST("/signup", handlers.Auth.Signup)

	// Public category routes
	v1Categories := v1Router.Group("/categories")
	{
		v1Categories.GET("", handlers.Category.List)
		v1Categories.GET("/:id", handlers.Category.Get)
		v1Categories.GET("/slug/:slug", handlers.Category.GetBySlug)
	}

	// Public place routes
	v1Places := v1Router.Group("/places")
	{
		v1Places.GET("", handlers.Place.List)
		v1Places.GET("/:id", handlers.Place.Get)
		v1Places.GET("/slug/:slug", handlers.Place.GetBySlug)
		v1Places.GET("/:place_id/images", handlers.Place.GetImages)
	}

	// Authenticated routes
	v1Private := v1Router.Group("/")
	v1Private.Use(middleware.AuthenticateMiddleware(cfg, logger))
	{
		v1Private.GET("/user/me", handlers.User.Me)
		v1Private.PUT("/user", handlers.User.Update)

		// Category management routes
		v1Private.POST("/categories", handlers.Category.Create)
		v1Private.PUT("/categories/:id", handlers.Category.Update)
		v1Private.DELETE("/categories/:id", handlers.Category.Delete)

		// Place management routes
		v1Private.POST("/places", handlers.Place.Create)
		v1Private.PUT("/places/:id", handlers.Place.Update)
		v1Private.DELETE("/places/:id", handlers.Place.Delete)
		v1Private.POST("/places/:place_id/images", handlers.Place.AddImage)
		v1Private.PUT("/places/images/:image_id", handlers.Place.UpdateImage)
		v1Private.DELETE("/places/images/:image_id", handlers.Place.DeleteImage)
	}

	return router
}
