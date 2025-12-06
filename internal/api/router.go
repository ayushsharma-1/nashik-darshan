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
	Review   *v1.ReviewHandler
	Hotel    *v1.HotelHandler
	Event    *v1.EventHandler
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
		v1Place.GET("/slug/:slug", handlers.Place.GetBySlug)
		// More specific routes must come before less specific ones
		v1Place.GET("/:id/images", handlers.Place.GetImages)
		v1Place.GET("/:id", handlers.Place.Get)

		v1Place.Use(middleware.AuthenticateMiddleware(cfg, logger))
		v1Place.POST("", handlers.Place.Create)
		v1Place.PUT("/:id", handlers.Place.Update)
		v1Place.DELETE("/:id", handlers.Place.Delete)
		v1Place.POST("/:id/images", handlers.Place.AddImage)
		v1Place.PUT("/:id/categories", handlers.Place.AssignCategories)
	}

	// Place image routes (authenticated only)
	v1PlaceImage := v1Router.Group("/places/images")
	v1PlaceImage.Use(middleware.AuthenticateMiddleware(cfg, logger))
	{
		v1PlaceImage.PUT("/:image_id", handlers.Place.UpdateImage)
		v1PlaceImage.DELETE("/:image_id", handlers.Place.DeleteImage)
	}

	// Feed routes (public)
	v1Router.POST("/feed", handlers.Place.GetFeed)

	// Engagement tracking routes
	v1Router.POST("/places/:id/view", handlers.Place.IncrementViewCount) // Public for analytics

	// Review routes
	v1Review := v1Router.Group("/reviews")
	{
		// Public review routes
		v1Review.GET("", handlers.Review.ListReviews)
		v1Review.GET("/:id", handlers.Review.GetReview)
		v1Review.GET("/stats/:entityType/:entityId", handlers.Review.GetRatingStats)

		// Authenticated review routes
		v1Review.Use(middleware.AuthenticateMiddleware(cfg, logger))
		v1Review.POST("", handlers.Review.CreateReview)
		v1Review.PUT("/:id", handlers.Review.UpdateReview)
		v1Review.DELETE("/:id", handlers.Review.DeleteReview)
	}

	// Hotel routes
	v1Hotel := v1Router.Group("/hotels")
	{
		v1Hotel.GET("", handlers.Hotel.List)
		v1Hotel.GET("/slug/:slug", handlers.Hotel.GetBySlug)
		v1Hotel.GET("/:id", handlers.Hotel.Get)

		v1Hotel.Use(middleware.AuthenticateMiddleware(cfg, logger))
		v1Hotel.POST("", handlers.Hotel.Create)
		v1Hotel.PUT("/:id", handlers.Hotel.Update)
		v1Hotel.DELETE("/:id", handlers.Hotel.Delete)
	}

	// Event routes
	v1Event := v1Router.Group("/events")
	{
		// Public event routes (specific paths BEFORE wildcard paths)
		v1Event.GET("", handlers.Event.List) // Supports expand=true with from_date/to_date for occurrence expansion
		v1Event.GET("/slug/:slug", handlers.Event.GetBySlug)

		// Event-specific routes with :id (must come before /:id to avoid conflicts)
		v1Event.POST("/:id/view", handlers.Event.IncrementView)             // Public for analytics
		v1Event.POST("/:id/interested", handlers.Event.IncrementInterested) // Public for user engagement

		// Generic get by ID (must come AFTER specific routes)
		v1Event.GET("/:id", handlers.Event.Get)

		// Authenticated event routes
		v1Event.Use(middleware.AuthenticateMiddleware(cfg, logger))
		v1Event.POST("", handlers.Event.Create)
		v1Event.PUT("/:id", handlers.Event.Update)
		v1Event.DELETE("/:id", handlers.Event.Delete)

		// Occurrence routes under /events/occurrences for consistency
		v1Event.GET("/occurrences/:id", handlers.Event.GetOccurrence)       // Public
		v1Event.POST("/occurrences", handlers.Event.CreateOccurrence)       // Authenticated
		v1Event.PUT("/occurrences/:id", handlers.Event.UpdateOccurrence)    // Authenticated
		v1Event.DELETE("/occurrences/:id", handlers.Event.DeleteOccurrence) // Authenticated
		v1Event.GET("/:id/occurrences", handlers.Event.ListOccurrences)     // Public - list occurrences for specific event
	}

	return router
}
