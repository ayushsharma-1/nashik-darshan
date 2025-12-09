package service

import (
	"strings"

	"github.com/omkar273/nashikdarshan/internal/config"
	"github.com/omkar273/nashikdarshan/internal/logger"
)

// NewRoutingClient creates a new routing client based on configuration
func NewRoutingClient(cfg *config.Configuration, log *logger.Logger) (RoutingClient, error) {
	provider := strings.ToLower(strings.TrimSpace(cfg.Routing.Provider))
	switch provider {
	case "google_maps":
		return NewGoogleMapsClient(cfg.Routing.APIKey, cfg.Routing.Timeout, log)
	case "", "none", "noop", "local":
		log.Infow("routing disabled or set to noop - using local routing client",
			"provider", cfg.Routing.Provider,
		)
		return NewNoopRoutingClient(cfg.Routing.Timeout, log), nil
	default:
		log.Warnw("unknown routing provider, falling back to noop routing client",
			"provider", cfg.Routing.Provider,
		)
		return NewNoopRoutingClient(cfg.Routing.Timeout, log), nil
	}
}
