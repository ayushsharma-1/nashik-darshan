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

	// Authenticated routes
	v1Private := v1Router.Group("/")
	v1Private.Use(middleware.AuthenticateMiddleware(cfg, logger))
	{
		v1Private.GET("/user/me", handlers.User.Me)
		v1Private.PUT("/user", handlers.User.Update)
	}

	// Category routes
	v1Category := v1Router.Group("/categories")
	{
		v1Category.GET("", handlers.Category.List)
		v1Category.GET("/:id", handlers.Category.Get)
		v1Category.GET("/slug/:slug", handlers.Category.GetBySlug)

		v1Category.Use(middleware.AuthenticateMiddleware(cfg, logger))
		v1Category.POST("", handlers.Category.Create)
		v1Category.PUT("/:id", handlers.Category.Update)
		v1Category.DELETE("/:id", handlers.Category.Delete)
	}

	// Place routes
	v1Place := v1Router.Group("/places")
	{
		v1Place.GET("", handlers.Place.List)
		v1Place.GET("/:id", handlers.Place.Get)
		v1Place.GET("/slug/:slug", handlers.Place.GetBySlug)
		v1Place.GET("/:place_id/images", handlers.Place.GetImages)

		v1Place.Use(middleware.AuthenticateMiddleware(cfg, logger))
		v1Place.POST("", handlers.Place.Create)
		v1Place.PUT("/:id", handlers.Place.Update)
		v1Place.DELETE("/:id", handlers.Place.Delete)
		v1Place.POST("/:place_id/images", handlers.Place.AddImage)
	}

	// Place image routes (authenticated only)
	v1PlaceImage := v1Router.Group("/places/images")
	v1PlaceImage.Use(middleware.AuthenticateMiddleware(cfg, logger))
	{
		v1PlaceImage.PUT("/:image_id", handlers.Place.UpdateImage)
		v1PlaceImage.DELETE("/:image_id", handlers.Place.DeleteImage)
	}

	return router
}
