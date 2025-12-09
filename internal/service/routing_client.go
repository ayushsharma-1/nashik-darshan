package service

import (
	"context"
	"fmt"
	"time"

	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/logger"
	"github.com/omkar273/nashikdarshan/internal/types"
	"googlemaps.github.io/maps"
)

// RoutingClient interface for getting route information
type RoutingClient interface {
	// GetDistanceMatrix retrieves distance and time between multiple locations
	GetDistanceMatrix(
		ctx context.Context,
		origins []types.Location,
		destinations []types.Location,
		mode types.TransportMode,
	) (*DistanceMatrix, error)

	// GetDirections retrieves turn-by-turn directions between two locations
	GetDirections(
		ctx context.Context,
		origin types.Location,
		destination types.Location,
		mode types.TransportMode,
	) (string, error)
}

// GoogleMapsClient implements RoutingClient using Google Maps API
type GoogleMapsClient struct {
	client  *maps.Client
	log     logger.Logger
	timeout time.Duration
}

// NewGoogleMapsClient creates a new Google Maps routing client
func NewGoogleMapsClient(apiKey string, timeoutSeconds int, log *logger.Logger) (RoutingClient, error) {
	if apiKey == "" {
		return nil, ierr.NewError("Google Maps API key is required").
			WithHint("Please set CAYGNUS_ROUTING_API_KEY environment variable").
			Mark(ierr.ErrInternal)
	}

	c, err := maps.NewClient(maps.WithAPIKey(apiKey))
	if err != nil {
		return nil, ierr.WithError(err).
			WithHint("Failed to initialize Google Maps client").
			Mark(ierr.ErrInternal)
	}

	timeout := 30 * time.Second
	if timeoutSeconds > 0 {
		timeout = time.Duration(timeoutSeconds) * time.Second
	}

	return &GoogleMapsClient{
		client:  c,
		log:     *log,
		timeout: timeout,
	}, nil
}

// GetDistanceMatrix retrieves distance and time matrix between locations
func (g *GoogleMapsClient) GetDistanceMatrix(
	ctx context.Context,
	origins []types.Location,
	destinations []types.Location,
	mode types.TransportMode,
) (*DistanceMatrix, error) {
	g.log.Debugw("fetching distance matrix",
		"origins_count", len(origins),
		"destinations_count", len(destinations),
		"transport_mode", mode,
	)

	// Set timeout
	ctx, cancel := context.WithTimeout(ctx, g.timeout)
	defer cancel()

	// Convert locations to string format
	originStrs := make([]string, len(origins))
	for i, loc := range origins {
		originStrs[i] = fmt.Sprintf("%s,%s", loc.Latitude.String(), loc.Longitude.String())
	}

	destStrs := make([]string, len(destinations))
	for i, loc := range destinations {
		destStrs[i] = fmt.Sprintf("%s,%s", loc.Latitude.String(), loc.Longitude.String())
	}

	// Build request
	req := &maps.DistanceMatrixRequest{
		Origins:      originStrs,
		Destinations: destStrs,
		Mode:         g.convertTransportMode(mode),
		Units:        maps.UnitsMetric,
	}

	// Call Google Maps API
	resp, err := g.client.DistanceMatrix(ctx, req)
	if err != nil {
		g.log.Errorw("google maps distance matrix api failed",
			"error", err,
			"origins_count", len(origins),
			"destinations_count", len(destinations),
		)
		return nil, ierr.WithError(err).
			WithHint("Failed to fetch distance matrix from Google Maps").
			Mark(ierr.ErrIntegration)
	}

	// Parse response into matrix
	matrix := NewDistanceMatrix(len(origins), len(destinations))
	for i, row := range resp.Rows {
		for j, element := range row.Elements {
			if element.Status != "OK" {
				g.log.Warnw("distance matrix element failed",
					"status", element.Status,
					"origin_index", i,
					"destination_index", j,
				)
				continue
			}

			info := RouteInfo{
				DistanceKm:        float64(element.Distance.Meters) / 1000.0,
				TravelTimeMinutes: int(element.Duration.Minutes()),
			}
			matrix.Set(i, j, info)
		}
	}

	g.log.Infow("fetched distance matrix successfully",
		"origins_count", len(origins),
		"destinations_count", len(destinations),
	)

	return matrix, nil
}

// GetDirections retrieves turn-by-turn directions between two locations
func (g *GoogleMapsClient) GetDirections(
	ctx context.Context,
	origin types.Location,
	destination types.Location,
	mode types.TransportMode,
) (string, error) {
	g.log.Debugw("fetching directions",
		"origin_lat", origin.Latitude,
		"origin_lng", origin.Longitude,
		"dest_lat", destination.Latitude,
		"dest_lng", destination.Longitude,
		"transport_mode", mode,
	)

	// Set timeout
	ctx, cancel := context.WithTimeout(ctx, g.timeout)
	defer cancel()

	// Build request
	req := &maps.DirectionsRequest{
		Origin:      fmt.Sprintf("%s,%s", origin.Latitude.String(), origin.Longitude.String()),
		Destination: fmt.Sprintf("%s,%s", destination.Latitude.String(), destination.Longitude.String()),
		Mode:        g.convertTransportMode(mode),
		Units:       maps.UnitsMetric,
	}

	// Call Google Maps API
	routes, _, err := g.client.Directions(ctx, req)
	if err != nil {
		g.log.Errorw("google maps directions api failed",
			"error", err,
		)
		return "", ierr.WithError(err).
			WithHint("Failed to fetch directions from Google Maps").
			Mark(ierr.ErrIntegration)
	}

	if len(routes) == 0 {
		g.log.Warnw("no routes found")
		return "", nil
	}

	// Get summary of first route
	if len(routes[0].Legs) > 0 && len(routes[0].Legs[0].Steps) > 0 {
		firstStep := routes[0].Legs[0].Steps[0]
		g.log.Debugw("directions fetched successfully",
			"distance_km", float64(routes[0].Legs[0].Distance.Meters)/1000.0,
			"duration_minutes", int(routes[0].Legs[0].Duration.Minutes()),
		)
		return firstStep.HTMLInstructions, nil
	}

	return "", nil
}

// convertTransportMode converts our TransportMode to Google Maps Mode
func (g *GoogleMapsClient) convertTransportMode(mode types.TransportMode) maps.Mode {
	switch mode {
	case types.TransportModeWalking:
		return maps.TravelModeWalking
	case types.TransportModeDriving:
		return maps.TravelModeDriving
	case types.TransportModeTaxi:
		return maps.TravelModeDriving // Taxi uses driving mode
	default:
		g.log.Warnw("unknown transport mode, defaulting to driving", "mode", mode)
		return maps.TravelModeDriving
	}
}

// DistanceMatrix stores distances and times between locations
type DistanceMatrix struct {
	data [][]RouteInfo
	rows int
	cols int
}

// RouteInfo contains distance and travel time information
type RouteInfo struct {
	DistanceKm        float64 // Distance in kilometers
	TravelTimeMinutes int     // Travel time in minutes
}

// NewDistanceMatrix creates a new distance matrix
func NewDistanceMatrix(rows, cols int) *DistanceMatrix {
	data := make([][]RouteInfo, rows)
	for i := range data {
		data[i] = make([]RouteInfo, cols)
	}
	return &DistanceMatrix{
		data: data,
		rows: rows,
		cols: cols,
	}
}

// Set sets the route info at the given row and column
func (m *DistanceMatrix) Set(row, col int, info RouteInfo) {
	if row >= 0 && row < m.rows && col >= 0 && col < m.cols {
		m.data[row][col] = info
	}
}

// Get retrieves the route info at the given row and column
func (m *DistanceMatrix) Get(row, col int) RouteInfo {
	if row >= 0 && row < m.rows && col >= 0 && col < m.cols {
		return m.data[row][col]
	}
	return RouteInfo{}
}

// GetDistanceBetweenLocations gets distance between two specific locations
// originIdx is the index in the origins array, destIdx is the index in destinations array
func (m *DistanceMatrix) GetDistanceBetweenLocations(originIdx, destIdx int) float64 {
	return m.Get(originIdx, destIdx).DistanceKm
}

// GetTravelTimeBetweenLocations gets travel time between two specific locations
func (m *DistanceMatrix) GetTravelTimeBetweenLocations(originIdx, destIdx int) int {
	return m.Get(originIdx, destIdx).TravelTimeMinutes
}

// GetRows returns the number of rows (origins) in the matrix
func (m *DistanceMatrix) GetRows() int {
	return m.rows
}

// GetCols returns the number of columns (destinations) in the matrix
func (m *DistanceMatrix) GetCols() int {
	return m.cols
}

// FindNearestDestination finds the nearest destination from a given origin
// Returns the index of the nearest destination and the distance
func (m *DistanceMatrix) FindNearestDestination(originIdx int, excludeIndices map[int]bool) (int, float64) {
	nearestIdx := -1
	minDistance := float64(^uint(0) >> 1) // Max float

	for destIdx := 0; destIdx < m.cols; destIdx++ {
		if excludeIndices[destIdx] {
			continue
		}

		info := m.Get(originIdx, destIdx)
		if info.DistanceKm > 0 && info.DistanceKm < minDistance {
			minDistance = info.DistanceKm
			nearestIdx = destIdx
		}
	}

	return nearestIdx, minDistance
}

// LocationIndex represents a mapping between location and its index in the matrix
type LocationIndex struct {
	Location types.Location
	Index    int
}

// CreateLocationIndexMap creates a map of locations to their indices
func CreateLocationIndexMap(locations []types.Location) map[string]int {
	indexMap := make(map[string]int)
	for i, loc := range locations {
		key := locationKey(loc)
		indexMap[key] = i
	}
	return indexMap
}

// locationKey creates a unique key for a location
func locationKey(loc types.Location) string {
	return fmt.Sprintf("%s,%s", loc.Latitude.String(), loc.Longitude.String())
}

// FindLocationIndex finds the index of a location in the locations array
func FindLocationIndex(locations []types.Location, target types.Location) int {
	targetKey := locationKey(target)
	for i, loc := range locations {
		if locationKey(loc) == targetKey {
			return i
		}
	}
	return -1
}

// CalculateTotalDistance calculates the total distance for a route
func CalculateTotalDistance(matrix *DistanceMatrix, routeIndices []int) float64 {
	totalDistance := 0.0
	for i := 0; i < len(routeIndices)-1; i++ {
		distance := matrix.GetDistanceBetweenLocations(routeIndices[i], routeIndices[i+1])
		totalDistance += distance
	}
	return totalDistance
}

// CalculateTotalTravelTime calculates the total travel time for a route
func CalculateTotalTravelTime(matrix *DistanceMatrix, routeIndices []int) int {
	totalTime := 0
	for i := 0; i < len(routeIndices)-1; i++ {
		time := matrix.GetTravelTimeBetweenLocations(routeIndices[i], routeIndices[i+1])
		totalTime += time
	}
	return totalTime
}
