package service

import (
	"context"
	"fmt"
	"math"
	"time"

	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/types"
)

// NewNoopRoutingClient returns a routing client that computes straight-line distances
// and estimates travel time. Useful for environments without an external routing provider.
func NewNoopRoutingClient(timeoutSeconds int, log *logger.Logger) RoutingClient {
	timeout := 30 * time.Second
	if timeoutSeconds > 0 {
		timeout = time.Duration(timeoutSeconds) * time.Second
	}

	return &noopRoutingClient{
		timeout: timeout,
		log:     *log,
	}
}

type noopRoutingClient struct {
	timeout time.Duration
	log     logger.Logger
}

// haversineDistanceKm computes great-circle distance between two coordinates in kilometers
func haversineDistanceKm(a, b types.Location) float64 {
	// parse decimal strings to float64 via String() -> assume they are valid
	lat1, _ := a.Latitude.Float64()
	lng1, _ := a.Longitude.Float64()
	lat2, _ := b.Latitude.Float64()
	lng2, _ := b.Longitude.Float64()

	const R = 6371.0 // Earth radius km
	dLat := (lat2 - lat1) * math.Pi / 180.0
	dLon := (lng2 - lng1) * math.Pi / 180.0
	rlat1 := lat1 * math.Pi / 180.0
	rlat2 := lat2 * math.Pi / 180.0

	aH := math.Sin(dLat/2)*math.Sin(dLat/2) + math.Cos(rlat1)*math.Cos(rlat2)*math.Sin(dLon/2)*math.Sin(dLon/2)
	c := 2 * math.Atan2(math.Sqrt(aH), math.Sqrt(1-aH))
	return R * c
}

// estimateTravelTimeMinutes uses average speeds depending on transport mode
func estimateTravelTimeMinutes(distanceKm float64, mode types.TransportMode) int {
	// average speeds (km/h)
	var speed float64 = 40.0
	switch mode {
	case types.TransportModeWalking:
		speed = 5.0
	case types.TransportModeDriving, types.TransportModeTaxi:
		speed = 40.0
	}
	if speed <= 0 {
		speed = 40.0
	}
	hours := distanceKm / speed
	minutes := int(hours * 60)
	if minutes < 1 {
		minutes = 1
	}
	return minutes
}

// GetDistanceMatrix builds a distance matrix using haversine distances and estimated times
func (n *noopRoutingClient) GetDistanceMatrix(
	ctx context.Context,
	origins []types.Location,
	destinations []types.Location,
	mode types.TransportMode,
) (*DistanceMatrix, error) {
	// simple timeout
	ctx, cancel := context.WithTimeout(ctx, n.timeout)
	defer cancel()

	rows := len(origins)
	cols := len(destinations)
	matrix := NewDistanceMatrix(rows, cols)

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			d := haversineDistanceKm(origins[i], destinations[j])
			t := estimateTravelTimeMinutes(d, mode)
			matrix.Set(i, j, RouteInfo{DistanceKm: d, TravelTimeMinutes: t})
		}
	}

	return matrix, nil
}

// GetDirections returns a short textual direction using straight-line info
func (n *noopRoutingClient) GetDirections(
	ctx context.Context,
	origin types.Location,
	destination types.Location,
	mode types.TransportMode,
) (string, error) {
	// not a real directions provider
	d := haversineDistanceKm(origin, destination)
	minutes := estimateTravelTimeMinutes(d, mode)
	return fmt.Sprintf("Estimated %.2f km, ~%d minutes (straight-line)", d, minutes), nil
}
