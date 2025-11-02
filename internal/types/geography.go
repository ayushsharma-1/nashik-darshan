package types

import (
	"encoding/json"
	"fmt"
	"math"

	ierr "github.com/omkar273/nashikdarshan/internal/errors"
)

// Point represents a geographic point with latitude and longitude
// This follows the GeoJSON standard for point coordinates: [longitude, latitude]
type Point struct {
	Longitude float64 `json:"longitude" binding:"required"` // X coordinate (longitude)
	Latitude  float64 `json:"latitude" binding:"required"`  // Y coordinate (latitude)
}

// GeoJSONPoint represents a GeoJSON Point geometry
// Industry standard format used by Google Maps, Mapbox, OpenStreetMap, etc.
type GeoJSONPoint struct {
	Type        string    `json:"type" binding:"required"`              // Must be "Point"
	Coordinates []float64 `json:"coordinates" binding:"required,len=2"` // [longitude, latitude]
}

// ToGeoJSON converts a Point to GeoJSON format
// This is the industry standard format used by major platforms
func (p Point) ToGeoJSON() GeoJSONPoint {
	return GeoJSONPoint{
		Type:        "Point",
		Coordinates: []float64{p.Longitude, p.Latitude},
	}
}

// PointFromGeoJSON creates a Point from GeoJSON format
func PointFromGeoJSON(gj GeoJSONPoint) (*Point, error) {
	if gj.Type != "Point" {
		return nil, ierr.NewError("invalid GeoJSON type").
			WithHint(fmt.Sprintf("expected 'Point', got '%s'", gj.Type)).
			Mark(ierr.ErrValidation)
	}
	if len(gj.Coordinates) != 2 {
		return nil, ierr.NewError("invalid coordinates").
			WithHint(fmt.Sprintf("expected 2 values, got %d", len(gj.Coordinates))).
			Mark(ierr.ErrValidation)
	}

	point := &Point{
		Longitude: gj.Coordinates[0],
		Latitude:  gj.Coordinates[1],
	}

	if !point.IsValid() {
		return nil, ierr.NewError("invalid coordinates").
			WithHint("latitude or longitude out of range").
			Mark(ierr.ErrValidation)
	}

	return point, nil
}

// UnmarshalJSON implements custom JSON unmarshaling to support both formats:
// 1. GeoJSON format: {"type": "Point", "coordinates": [lng, lat]}
// 2. Simple format: {"longitude": lng, "latitude": lat}
func (p *Point) UnmarshalJSON(data []byte) error {
	// Try GeoJSON format first
	var geoJSON GeoJSONPoint
	if err := json.Unmarshal(data, &geoJSON); err == nil && geoJSON.Type == "Point" {
		parsed, err := PointFromGeoJSON(geoJSON)
		if err != nil {
			return err
		}
		*p = *parsed
		return nil
	}

	// Fallback to simple format
	type alias struct {
		Longitude float64 `json:"longitude"`
		Latitude  float64 `json:"latitude"`
	}
	var a alias
	if err := json.Unmarshal(data, &a); err != nil {
		return err
	}

	p.Longitude = a.Longitude
	p.Latitude = a.Latitude

	if !p.IsValid() {
		return ierr.NewError("invalid coordinates").
			WithHint("latitude or longitude out of range").
			Mark(ierr.ErrValidation)
	}

	return nil
}

// MarshalJSON implements custom JSON marshaling to output GeoJSON format by default
func (p Point) MarshalJSON() ([]byte, error) {
	return json.Marshal(p.ToGeoJSON())
}

// ToWKT converts a Point to Well-Known Text format for PostGIS
// Format: POINT(longitude latitude)
// Note: WKT uses longitude first, then latitude (GeoJSON standard order)
func (p Point) ToWKT() string {
	return fmt.Sprintf("POINT(%f %f)", p.Longitude, p.Latitude)
}

// PointFromWKT parses a WKT string into a Point
// Format: POINT(longitude latitude)
func PointFromWKT(wkt string) (*Point, error) {
	var lng, lat float64
	count, err := fmt.Sscanf(wkt, "POINT(%f %f)", &lng, &lat)
	if err != nil || count != 2 {
		return nil, ierr.NewError("invalid WKT format").
			WithHint(fmt.Sprintf("expected 'POINT(longitude latitude)', got '%s'", wkt)).
			Mark(ierr.ErrValidation)
	}

	point := &Point{
		Longitude: lng,
		Latitude:  lat,
	}

	if !point.IsValid() {
		return nil, ierr.NewError("invalid coordinates in WKT").
			WithHint("latitude or longitude out of range").
			Mark(ierr.ErrValidation)
	}

	return point, nil
}

// IsValid checks if the point has valid coordinates
// Validates according to WGS84 (EPSG:4326) standard
func (p Point) IsValid() bool {
	// Latitude must be between -90 and 90 (WGS84 standard)
	if p.Latitude < -90 || p.Latitude > 90 {
		return false
	}
	// Longitude must be between -180 and 180 (WGS84 standard)
	if p.Longitude < -180 || p.Longitude > 180 {
		return false
	}
	return true
}

// Distance calculates the distance between two points in kilometers using Haversine formula
// This is a simplified version; for production, consider using a library like github.com/twpayne/go-geom
func (p Point) Distance(other Point) float64 {
	const earthRadiusKm = 6371.0 // Earth's radius in kilometers

	lat1 := p.Latitude * (3.141592653589793 / 180.0)
	lon1 := p.Longitude * (3.141592653589793 / 180.0)
	lat2 := other.Latitude * (3.141592653589793 / 180.0)
	lon2 := other.Longitude * (3.141592653589793 / 180.0)

	dlat := lat2 - lat1
	dlon := lon2 - lon1

	a := 0.5 - math.Cos(dlat)/2 + math.Cos(lat1)*math.Cos(lat2)*(1-math.Cos(dlon))/2

	return earthRadiusKm * 2 * math.Asin(math.Sqrt(a))
}
