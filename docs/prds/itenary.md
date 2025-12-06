# Itinerary Planner MVP — Implementation Document

**Project:** Nashik Darshan Itinerary Planner (Minimum Viable Product)  
**Backend:** Go + ENT ORM + PostgreSQL  
**API Documentation:** Swagger/OpenAPI  
**Date:** December 6, 2025

## 📋 Table of Contents

1. [User Input Requirements](#1-user-input-requirements)
2. [System Architecture](#2-system-architecture)
3. [Database Schema (ENT)](#3-database-schema-ent)
4. [API Endpoints](#4-api-endpoints)
5. [Core Algorithm: Route Optimization](#5-core-algorithm-route-optimization)
6. [Response Structure](#6-response-structure)
7. [Implementation Steps](#7-implementation-steps)
8. [Technology Stack](#8-technology-stack)

---

## 1. User Input Requirements

### 1.1 Required Fields

| Field | Type | Description | Validation | Example |
|-------|------|-------------|------------|---------|
| `current_location` | `Location` | User's starting point | Valid lat/lng coordinates | `{lat: 19.9975, lng: 73.7898}` |
| `city` | `string` | Destination city | Non-empty, valid city name | `"Nashik"` |
| `date` | `string` | Travel date | ISO format YYYY-MM-DD, today or future | `"2025-12-20"` |
| `start_time` | `string` | Trip start time | HH:MM format (24-hour) | `"10:00"` |
| `end_time` | `string` | Trip end time | HH:MM format, must be > start_time + 2 hours | `"17:00"` |
| `selected_places` | `[]string` | Array of place IDs to visit | 1-5 place IDs, must exist in database | `["uuid-1", "uuid-2", "uuid-3"]` |

### 1.2 Optional Fields

| Field | Type | Description | Default | Example |
|-------|------|-------------|---------|---------|
| `visit_duration` | `int` | Minutes to spend at each place | `30` | `45` |
| `transport_mode` | `enum` | Travel mode: `walking`, `driving`, `taxi` | `"driving"` | `"driving"` |

### 1.3 Data Types

```go
type Location struct {
    Latitude  float64 `json:"lat" validate:"required,latitude"`
    Longitude float64 `json:"lng" validate:"required,longitude"`
}

type CreateItineraryRequest struct {
    CurrentLocation Location  `json:"current_location" validate:"required"`
    City            string    `json:"city" validate:"required,min=2"`
    Date            string    `json:"date" validate:"required,datetime=2006-01-02"`
    StartTime       string    `json:"start_time" validate:"required,len=5"`
    EndTime         string    `json:"end_time" validate:"required,len=5"`
    SelectedPlaces  []string  `json:"selected_places" validate:"required,min=1,max=5,dive,uuid4"`
    VisitDuration   int       `json:"visit_duration" validate:"omitempty,min=15,max=120"`
    TransportMode   string    `json:"transport_mode" validate:"omitempty,oneof=walking driving taxi"`
}
```

### 1.4 Validation Rules

**Server-side validation must ensure:**
1. `current_location` coordinates are valid (lat: -90 to 90, lng: -180 to 180)
2. `date` is not in the past
3. `end_time` is at least 2 hours after `start_time`
4. Each place ID in `selected_places` exists in the database
5. Number of places is between 1 and 5 (inclusive)
6. No duplicate place IDs in `selected_places`
7. `visit_duration` allows fitting all places within time window

---

## 2. System Architecture

### 2.1 High-Level Components

```
┌──────────────────────────────────────────────────────────┐
│                    Client (Web/Mobile)                    │
└────────────────────────┬─────────────────────────────────┘
                         │ HTTP/JSON
                         ▼
┌──────────────────────────────────────────────────────────┐
│              API Server (Go + Gin Framework)              │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Handlers: Validation → Business Logic → Response │  │
│  └────────────────────────────────────────────────────┘  │
└────────────────────────┬─────────────────────────────────┘
                         │
                ┌────────┼────────┐
                ▼                 ▼
┌──────────────────────┐ ┌──────────────────────┐
│  PostgreSQL + PostGIS│ │   Google Maps API    │
│  (ENT ORM managed)   │ │   (Routing Service)  │
│                      │ │                      │
│  • Users             │ │  • Distance Matrix   │
│  • Places            │ │  • Directions        │
│  • Itineraries       │ │  • Travel Times      │
│  • Visits            │ │                      │
└──────────────────────┘ └──────────────────────┘
```

### 2.2 Request Flow

```
1. Client sends POST /api/itineraries with user inputs
                    ↓
2. Server validates all input fields
                    ↓
3. Server fetches place details from database (lat/lng, names, etc.)
                    ↓
4. Server calls Google Maps Distance Matrix API
   - Get travel times between all pairs of places
   - Include starting location
                    ↓
5. Server runs Route Optimization Algorithm
   - Arrange places in optimal order (nearest-neighbor)
   - Calculate arrival/departure times
   - Check time window feasibility
                    ↓
6. Server saves itinerary + visits to database
                    ↓
7. Server returns structured JSON response with complete schedule
                    ↓
8. Client displays itinerary to user
```

---

## 3. Database Schema (ENT)

### 3.1 Entity Relationships

```
users (1) ──────< (many) itineraries (1) ──────< (many) visits (many) >────── (1) places
```

### 3.2 ENT Schema Definitions

#### User Schema (`ent/schema/user.go`)

```go
package schema

import (
    "entgo.io/ent"
    "entgo.io/ent/schema/field"
    "entgo.io/ent/schema/edge"
    "github.com/google/uuid"
)

type User struct {
    ent.Schema
}

func (User) Fields() []ent.Field {
    return []ent.Field{
        field.UUID("id", uuid.UUID{}).
            Default(uuid.New).
            Immutable(),
        field.String("name").
            NotEmpty(),
        field.String("email").
            Optional(),
        field.String("phone").
            Optional(),
        field.Time("created_at").
            Default(time.Now).
            Immutable(),
    }
}

func (User) Edges() []ent.Edge {
    return []ent.Edge{
        edge.To("itineraries", Itinerary.Type),
    }
}
```

#### Place Schema (`ent/schema/place.go`)

```go
package schema

import (
    "entgo.io/ent"
    "entgo.io/ent/schema/field"
    "entgo.io/ent/schema/index"
    "github.com/google/uuid"
)

type Place struct {
    ent.Schema
}

func (Place) Fields() []ent.Field {
    return []ent.Field{
        field.UUID("id", uuid.UUID{}).
            Default(uuid.New).
            Immutable(),
        field.String("name").
            NotEmpty(),
        field.String("city").
            Default("Nashik"),
        field.String("category").
            Optional(),
        field.String("description").
            Optional(),
        field.Float("latitude").
            Comment("Latitude coordinate"),
        field.Float("longitude").
            Comment("Longitude coordinate"),
        field.String("address").
            Optional(),
        field.Int("avg_visit_minutes").
            Default(30).
            Positive(),
        field.JSON("opening_hours", map[string]string{}).
            Optional().
            Comment("Day -> Hours mapping, e.g., Monday: 09:00-18:00"),
        field.Time("created_at").
            Default(time.Now).
            Immutable(),
    }
}

func (Place) Indexes() []ent.Index {
    return []ent.Index{
        index.Fields("city"),
        index.Fields("category"),
    }
}
```

#### Itinerary Schema (`ent/schema/itinerary.go`)

```go
package schema

import (
    "entgo.io/ent"
    "entgo.io/ent/schema/field"
    "entgo.io/ent/schema/edge"
    "github.com/google/uuid"
)

type Itinerary struct {
    ent.Schema
}

func (Itinerary) Fields() []ent.Field {
    return []ent.Field{
        field.UUID("id", uuid.UUID{}).
            Default(uuid.New).
            Immutable(),
        field.UUID("user_id", uuid.UUID{}),
        field.String("city").
            NotEmpty(),
        field.Time("trip_date").
            Comment("Date of the trip"),
        field.Time("start_time").
            Comment("Trip start time (combined date + time)"),
        field.Time("end_time").
            Comment("Trip end time (combined date + time)"),
        field.Float("start_latitude").
            Comment("Starting location latitude"),
        field.Float("start_longitude").
            Comment("Starting location longitude"),
        field.Int("visit_duration_minutes").
            Default(30).
            Comment("Default duration per place"),
        field.String("transport_mode").
            Default("driving"),
        field.String("status").
            Default("DRAFT").
            Comment("DRAFT, COMPLETED, CANCELLED"),
        field.Int("total_distance_km").
            Optional().
            Comment("Total travel distance in km"),
        field.Int("total_travel_time_minutes").
            Optional().
            Comment("Total travel time in minutes"),
        field.Time("created_at").
            Default(time.Now).
            Immutable(),
        field.Time("updated_at").
            Default(time.Now).
            UpdateDefault(time.Now),
    }
}

func (Itinerary) Edges() []ent.Edge {
    return []ent.Edge{
        edge.From("user", User.Type).
            Ref("itineraries").
            Unique().
            Required().
            Field("user_id"),
        edge.To("visits", Visit.Type).
            Annotations(entsql.Annotation{
                OnDelete: entsql.Cascade,
            }),
    }
}
```

#### Visit Schema (`ent/schema/visit.go`)

```go
package schema

import (
    "entgo.io/ent"
    "entgo.io/ent/schema/field"
    "entgo.io/ent/schema/edge"
    "github.com/google/uuid"
)

type Visit struct {
    ent.Schema
}

func (Visit) Fields() []ent.Field {
    return []ent.Field{
        field.UUID("id", uuid.UUID{}).
            Default(uuid.New).
            Immutable(),
        field.UUID("itinerary_id", uuid.UUID{}),
        field.UUID("place_id", uuid.UUID{}),
        field.Int("sequence_order").
            Positive().
            Comment("Order in which to visit (1, 2, 3...)"),
        field.Time("arrival_time").
            Comment("Expected arrival time at this place"),
        field.Time("departure_time").
            Comment("Expected departure time from this place"),
        field.Int("visit_duration_minutes").
            Positive().
            Comment("Time to spend at this place"),
        field.Int("travel_time_from_previous").
            Default(0).
            Comment("Travel time from previous location (minutes)"),
        field.Int("distance_from_previous_km").
            Default(0).
            Comment("Distance from previous location (km)"),
        field.Time("created_at").
            Default(time.Now).
            Immutable(),
    }
}

func (Visit) Edges() []ent.Edge {
    return []ent.Edge{
        edge.From("itinerary", Itinerary.Type).
            Ref("visits").
            Unique().
            Required().
            Field("itinerary_id"),
        edge.From("place", Place.Type).
            Ref("visits").
            Unique().
            Required().
            Field("place_id"),
    }
}
```

### 3.3 Database Initialization

```bash
# Generate ENT code
ent generate ./ent/schema

# Run migrations
go run cmd/server/main.go migrate
```

---

## 4. API Endpoints

### 4.1 Create Itinerary

**Endpoint:** `POST /api/itineraries`

**Request Headers:**
```
Content-Type: application/json
Authorization: Bearer <jwt_token>  // For future auth
```

**Request Body:**
```json
{
  "current_location": {
    "lat": 19.9975,
    "lng": 73.7898
  },
  "city": "Nashik",
  "date": "2025-12-20",
  "start_time": "10:00",
  "end_time": "17:00",
  "selected_places": [
    "550e8400-e29b-41d4-a716-446655440001",
    "550e8400-e29b-41d4-a716-446655440002",
    "550e8400-e29b-41d4-a716-446655440003"
  ],
  "visit_duration": 45,
  "transport_mode": "driving"
}
```

**Success Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "itinerary_id": "660e8400-e29b-41d4-a716-446655440010",
    "city": "Nashik",
    "trip_date": "2025-12-20",
    "start_time": "10:00",
    "end_time": "17:00",
    "total_places": 3,
    "total_distance_km": 15.2,
    "total_travel_time_minutes": 35,
    "total_visit_time_minutes": 135,
    "estimated_completion_time": "15:50",
    "visits": [
      {
        "sequence": 1,
        "place": {
          "id": "550e8400-e29b-41d4-a716-446655440001",
          "name": "Kalaram Temple",
          "latitude": 19.9975,
          "longitude": 73.7898,
          "address": "Old Panchavati, Nashik"
        },
        "arrival_time": "10:00",
        "departure_time": "10:45",
        "visit_duration_minutes": 45,
        "travel_time_from_previous": 0,
        "distance_from_previous_km": 0,
        "directions": "Starting point"
      },
      {
        "sequence": 2,
        "place": {
          "id": "550e8400-e29b-41d4-a716-446655440002",
          "name": "Ramkund",
          "latitude": 19.9989,
          "longitude": 73.7855,
          "address": "Panchavati, Nashik"
        },
        "arrival_time": "10:55",
        "departure_time": "11:40",
        "visit_duration_minutes": 45,
        "travel_time_from_previous": 10,
        "distance_from_previous_km": 2.3,
        "directions": "Head north on Main Road, turn left at..."
      },
      {
        "sequence": 3,
        "place": {
          "id": "550e8400-e29b-41d4-a716-446655440003",
          "name": "Pandavleni Caves",
          "latitude": 20.0204,
          "longitude": 73.7831,
          "address": "Mumbai-Agra National Highway"
        },
        "arrival_time": "12:05",
        "departure_time": "12:50",
        "visit_duration_minutes": 45,
        "travel_time_from_previous": 25,
        "distance_from_previous_km": 12.9,
        "directions": "Take Mumbai-Agra NH60, continue for 12 km..."
      }
    ],
    "route_summary": {
      "optimized": true,
      "route_type": "circular",
      "feasible": true,
      "time_buffer_minutes": 70
    }
  },
  "message": "Itinerary created successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": [
      {
        "field": "selected_places",
        "issue": "Must select between 1 and 5 places"
      },
      {
        "field": "end_time",
        "issue": "End time must be at least 2 hours after start time"
      }
    ]
  }
}
```

**Error Response (404 Not Found):**
```json
{
  "success": false,
  "error": {
    "code": "PLACE_NOT_FOUND",
    "message": "One or more selected places do not exist",
    "details": [
      {
        "place_id": "invalid-uuid",
        "issue": "Place not found in database"
      }
    ]
  }
}
```

**Error Response (422 Unprocessable Entity):**
```json
{
  "success": false,
  "error": {
    "code": "INFEASIBLE_SCHEDULE",
    "message": "Cannot fit all places within time window",
    "details": {
      "required_time_minutes": 300,
      "available_time_minutes": 240,
      "suggestion": "Reduce number of places or extend time window"
    }
  }
}
```

### 4.2 Get Itinerary by ID

**Endpoint:** `GET /api/itineraries/:id`

**Response:** Same structure as POST response

### 4.3 List Places

**Endpoint:** `GET /api/places`

**Query Parameters:**
- `city` (optional): Filter by city name
- `category` (optional): Filter by category
- `limit` (optional, default 50): Max results

**Response:**
```json
{
  "success": true,
  "data": {
    "places": [
      {
        "id": "550e8400-e29b-41d4-a716-446655440001",
        "name": "Kalaram Temple",
        "city": "Nashik",
        "category": "religious",
        "latitude": 19.9975,
        "longitude": 73.7898,
        "address": "Old Panchavati, Nashik",
        "avg_visit_minutes": 30,
        "description": "Famous Hindu temple..."
      }
    ],
    "total": 42
  }
}
```

---

## 5. Core Algorithm: Route Optimization

### 5.1 Problem Statement

Given:
- Starting location (lat, lng)
- N places to visit (1 ≤ N ≤ 5)
- Time window (start_time, end_time)
- Visit duration per place
- Transport mode

Find:
- Optimal order to visit all places
- Arrival and departure times for each place
- Total distance and travel time
- Verify feasibility within time window

### 5.2 Algorithm: Nearest Neighbor with Time Constraints

```
Algorithm: OptimizeRoute(startLocation, places, timeWindow, visitDuration)

Input:
  - startLocation: {lat, lng}
  - places: array of {id, name, lat, lng, ...}
  - timeWindow: {startTime, endTime}
  - visitDuration: int (minutes per place)

Output:
  - orderedVisits: array of visits with times and routes
  - totalDistance: float (km)
  - totalTravelTime: int (minutes)
  - feasible: boolean

Steps:

1. INITIALIZE
   currentLocation ← startLocation
   currentTime ← timeWindow.startTime
   unvisitedPlaces ← places (all selected places)
   orderedVisits ← []
   totalDistance ← 0
   totalTravelTime ← 0

2. BUILD DISTANCE MATRIX
   Call Google Maps Distance Matrix API
   Get travel times and distances between:
     - startLocation and all places
     - all pairs of places
   Store in matrix M[i][j] where:
     M[i][j].time = travel time from location i to j
     M[i][j].distance = distance from location i to j

3. GREEDY NEAREST-NEIGHBOR SELECTION
   sequenceOrder ← 1
   
   WHILE unvisitedPlaces is not empty:
     
     a. Find nearest unvisited place from currentLocation
        nearestPlace ← null
        minDistance ← infinity
        
        FOR EACH place IN unvisitedPlaces:
          distance ← M[currentLocation][place].distance
          IF distance < minDistance:
            minDistance ← distance
            nearestPlace ← place
        
     b. Calculate arrival time
        travelTime ← M[currentLocation][nearestPlace].time
        arrivalTime ← currentTime + travelTime
        departureTime ← arrivalTime + visitDuration
        
     c. Check feasibility
        IF departureTime > timeWindow.endTime:
          RETURN error: "Cannot fit all places in time window"
        
     d. Create visit record
        visit ← {
          sequence: sequenceOrder,
          place: nearestPlace,
          arrivalTime: arrivalTime,
          departureTime: departureTime,
          visitDuration: visitDuration,
          travelTimeFromPrevious: travelTime,
          distanceFromPrevious: M[currentLocation][nearestPlace].distance
        }
        
        orderedVisits.append(visit)
        totalDistance += M[currentLocation][nearestPlace].distance
        totalTravelTime += travelTime
        
     e. Update state
        currentLocation ← nearestPlace
        currentTime ← departureTime
        unvisitedPlaces.remove(nearestPlace)
        sequenceOrder += 1

4. RETURN RESULT
   RETURN {
     orderedVisits: orderedVisits,
     totalDistance: totalDistance,
     totalTravelTime: totalTravelTime,
     totalVisitTime: len(places) * visitDuration,
     estimatedCompletionTime: currentTime,
     feasible: true,
     timeBufferMinutes: timeWindow.endTime - currentTime
   }
```

### 5.3 Go Implementation Structure

```go
// Service interface
type ItineraryService interface {
    CreateItinerary(ctx context.Context, req *CreateItineraryRequest) (*ItineraryResponse, error)
    GetItinerary(ctx context.Context, id uuid.UUID) (*ItineraryResponse, error)
}

// Core scheduling function
func (s *itineraryService) optimizeRoute(
    ctx context.Context,
    startLoc Location,
    places []*ent.Place,
    startTime time.Time,
    endTime time.Time,
    visitDuration int,
    transportMode string,
) (*OptimizedRoute, error) {
    
    // 1. Build distance matrix
    matrix, err := s.routingClient.GetDistanceMatrix(ctx, startLoc, places, transportMode)
    if err != nil {
        return nil, fmt.Errorf("failed to get distance matrix: %w", err)
    }
    
    // 2. Initialize state
    currentLoc := startLoc
    currentTime := startTime
    unvisited := make(map[string]*ent.Place)
    for _, p := range places {
        unvisited[p.ID.String()] = p
    }
    
    var visits []*Visit
    var totalDistance float64
    var totalTravelTime int
    sequenceOrder := 1
    
    // 3. Greedy nearest-neighbor loop
    for len(unvisited) > 0 {
        // Find nearest unvisited place
        nearestPlace, minDist := findNearest(currentLoc, unvisited, matrix)
        
        // Calculate times
        travelTime := matrix.GetTime(currentLoc, nearestPlace.Location())
        arrivalTime := currentTime.Add(time.Duration(travelTime) * time.Minute)
        departureTime := arrivalTime.Add(time.Duration(visitDuration) * time.Minute)
        
        // Check feasibility
        if departureTime.After(endTime) {
            return nil, fmt.Errorf("cannot fit all places: time window exceeded")
        }
        
        // Create visit
        visit := &Visit{
            SequenceOrder:          sequenceOrder,
            Place:                  nearestPlace,
            ArrivalTime:            arrivalTime,
            DepartureTime:          departureTime,
            VisitDuration:          visitDuration,
            TravelTimeFromPrevious: travelTime,
            DistanceFromPrevious:   minDist,
        }
        
        visits = append(visits, visit)
        totalDistance += minDist
        totalTravelTime += travelTime
        
        // Update state
        currentLoc = nearestPlace.Location()
        currentTime = departureTime
        delete(unvisited, nearestPlace.ID.String())
        sequenceOrder++
    }
    
    // 4. Return optimized route
    return &OptimizedRoute{
        Visits:              visits,
        TotalDistanceKm:     totalDistance,
        TotalTravelTime:     totalTravelTime,
        CompletionTime:      currentTime,
        TimeBufferMinutes:   int(endTime.Sub(currentTime).Minutes()),
        Feasible:            true,
    }, nil
}

func findNearest(
    from Location,
    places map[string]*ent.Place,
    matrix DistanceMatrix,
) (*ent.Place, float64) {
    var nearest *ent.Place
    minDist := math.MaxFloat64
    
    for _, place := range places {
        dist := matrix.GetDistance(from, place.Location())
        if dist < minDist {
            minDist = dist
            nearest = place
        }
    }
    
    return nearest, minDist
}
```

### 5.4 Complexity Analysis

- **Time Complexity:** O(N²) where N is number of places
  - Building distance matrix: O(N²) API calls (can be parallelized)
  - Greedy selection: O(N²) comparisons
  
- **Space Complexity:** O(N²) for distance matrix

- **Optimization:** For N ≤ 5, this is acceptable. No need for advanced TSP solvers.

---

## 6. Response Structure

### 6.1 Success Response Schema

```go
type ItineraryResponse struct {
    Success bool             `json:"success"`
    Data    ItineraryData    `json:"data"`
    Message string           `json:"message"`
}

type ItineraryData struct {
    ItineraryID             string        `json:"itinerary_id"`
    City                    string        `json:"city"`
    TripDate                string        `json:"trip_date"`
    StartTime               string        `json:"start_time"`
    EndTime                 string        `json:"end_time"`
    TotalPlaces             int           `json:"total_places"`
    TotalDistanceKm         float64       `json:"total_distance_km"`
    TotalTravelTimeMinutes  int           `json:"total_travel_time_minutes"`
    TotalVisitTimeMinutes   int           `json:"total_visit_time_minutes"`
    EstimatedCompletionTime string        `json:"estimated_completion_time"`
    Visits                  []VisitDetail `json:"visits"`
    RouteSummary            RouteSummary  `json:"route_summary"`
}

type VisitDetail struct {
    Sequence                 int          `json:"sequence"`
    Place                    PlaceDetail  `json:"place"`
    ArrivalTime              string       `json:"arrival_time"`
    DepartureTime            string       `json:"departure_time"`
    VisitDurationMinutes     int          `json:"visit_duration_minutes"`
    TravelTimeFromPrevious   int          `json:"travel_time_from_previous"`
    DistanceFromPreviousKm   float64      `json:"distance_from_previous_km"`
    Directions               string       `json:"directions"`
}

type PlaceDetail struct {
    ID          string  `json:"id"`
    Name        string  `json:"name"`
    Latitude    float64 `json:"latitude"`
    Longitude   float64 `json:"longitude"`
    Address     string  `json:"address"`
    Category    string  `json:"category,omitempty"`
    Description string  `json:"description,omitempty"`
}

type RouteSummary struct {
    Optimized        bool   `json:"optimized"`
    RouteType        string `json:"route_type"` // "circular", "linear"
    Feasible         bool   `json:"feasible"`
    TimeBufferMinutes int   `json:"time_buffer_minutes"`
}
```

### 6.2 Error Response Schema

```go
type ErrorResponse struct {
    Success bool        `json:"success"`
    Error   ErrorDetail `json:"error"`
}

type ErrorDetail struct {
    Code    string      `json:"code"`
    Message string      `json:"message"`
    Details interface{} `json:"details,omitempty"`
}
```

---

## 7. Implementation Steps

### Phase 1: Project Setup (Day 1)

```bash
# 1. Initialize Go module
mkdir nashik-itinerary && cd nashik-itinerary
go mod init github.com/yourusername/nashik-itinerary

# 2. Install dependencies
go get -u github.com/gin-gonic/gin
go get -u entgo.io/ent/cmd/ent
go get -u github.com/lib/pq
go get -u github.com/google/uuid
go get -u github.com/go-playground/validator/v10
go get -u github.com/swaggo/swag/cmd/swag
go get -u github.com/swaggo/gin-swagger
go get -u github.com/swaggo/files

# 3. Initialize ENT
ent init User Place Itinerary Visit

# 4. Create project structure
mkdir -p cmd/server
mkdir -p internal/{handler,service,repository,model}
mkdir -p pkg/{validator,response}
mkdir -p config
mkdir -p docs
```

### Phase 2: Database Setup (Day 1-2)

```go
// 1. Implement ENT schemas (see Section 3)
// 2. Generate ENT code
ent generate ./ent/schema

// 3. Create database connection
// config/database.go
func NewDB(dsn string) (*ent.Client, error) {
    client, err := ent.Open("postgres", dsn)
    if err != nil {
        return nil, err
    }
    
    // Run auto migration
    if err := client.Schema.Create(context.Background()); err != nil {
        return nil, err
    }
    
    return client, nil
}

// 4. Seed sample places for Nashik
// scripts/seed.go
func SeedPlaces(client *ent.Client) error {
    places := []struct{
        Name string
        Lat float64
        Lng float64
        Category string
    }{
        {"Kalaram Temple", 19.9975, 73.7898, "religious"},
        {"Ramkund", 19.9989, 73.7855, "religious"},
        {"Pandavleni Caves", 20.0204, 73.7831, "historical"},
        // Add more Nashik places...
    }
    
    for _, p := range places {
        _, err := client.Place.Create().
            SetName(p.Name).
            SetCity("Nashik").
            SetLatitude(p.Lat).
            SetLongitude(p.Lng).
            SetCategory(p.Category).
            Save(context.Background())
        if err != nil {
            return err
        }
    }
    return nil
}
```

### Phase 3: Routing Service Integration (Day 2-3)

```go
// pkg/routing/google_maps.go
package routing

import (
    "context"
    "fmt"
    "googlemaps.github.io/maps"
)

type GoogleMapsClient struct {
    client *maps.Client
}

func NewGoogleMapsClient(apiKey string) (*GoogleMapsClient, error) {
    c, err := maps.NewClient(maps.WithAPIKey(apiKey))
    if err != nil {
        return nil, err
    }
    return &GoogleMapsClient{client: c}, nil
}

func (g *GoogleMapsClient) GetDistanceMatrix(
    ctx context.Context,
    origins []Location,
    destinations []Location,
    mode string,
) (*DistanceMatrix, error) {
    
    // Convert to maps API format
    originsStr := make([]string, len(origins))
    for i, o := range origins {
        originsStr[i] = fmt.Sprintf("%f,%f", o.Lat, o.Lng)
    }
    
    destsStr := make([]string, len(destinations))
    for i, d := range destinations {
        destsStr[i] = fmt.Sprintf("%f,%f", d.Lat, d.Lng)
    }
    
    // Call Google Maps API
    req := &maps.DistanceMatrixRequest{
        Origins:      originsStr,
        Destinations: destsStr,
        Mode:         maps.TravelMode(mode),
    }
    
    resp, err := g.client.DistanceMatrix(ctx, req)
    if err != nil {
        return nil, err
    }
    
    // Parse response into our matrix structure
    matrix := NewDistanceMatrix(len(origins), len(destinations))
    for i, row := range resp.Rows {
        for j, element := range row.Elements {
            matrix.Set(i, j, RouteInfo{
                DistanceKm:   float64(element.Distance.Meters) / 1000.0,
                TravelTimeMinutes: int(element.Duration.Minutes()),
            })
        }
    }
    
    return matrix, nil
}
```

### Phase 4: Business Logic (Day 3-4)

```go
// internal/service/itinerary_service.go
package service

type ItineraryService struct {
    db            *ent.Client
    routingClient RoutingClient
    validator     *validator.Validate
}

func NewItineraryService(
    db *ent.Client,
    routingClient RoutingClient,
) *ItineraryService {
    return &ItineraryService{
        db:            db,
        routingClient: routingClient,
        validator:     validator.New(),
    }
}

func (s *ItineraryService) CreateItinerary(
    ctx context.Context,
    req *CreateItineraryRequest,
) (*ItineraryResponse, error) {
    
    // 1. Validate input
    if err := s.validator.Struct(req); err != nil {
        return nil, NewValidationError(err)
    }
    
    // 2. Fetch places from database
    places, err := s.db.Place.
        Query().
        Where(place.IDIn(req.SelectedPlaces...)).
        All(ctx)
    if err != nil {
        return nil, err
    }
    
    if len(places) != len(req.SelectedPlaces) {
        return nil, ErrPlaceNotFound
    }
    
    // 3. Parse times
    startTime, endTime := s.parseTimes(req.Date, req.StartTime, req.EndTime)
    
    // 4. Optimize route
    route, err := s.optimizeRoute(
        ctx,
        req.CurrentLocation,
        places,
        startTime,
        endTime,
        req.VisitDuration,
        req.TransportMode,
    )
    if err != nil {
        return nil, err
    }
    
    // 5. Save to database (transaction)
    tx, err := s.db.Tx(ctx)
    if err != nil {
        return nil, err
    }
    
    itinerary, err := tx.Itinerary.Create().
        SetUserID(req.UserID). // From JWT token
        SetCity(req.City).
        SetTripDate(startTime).
        SetStartTime(startTime).
        SetEndTime(endTime).
        SetStartLatitude(req.CurrentLocation.Lat).
        SetStartLongitude(req.CurrentLocation.Lng).
        SetVisitDurationMinutes(req.VisitDuration).
        SetTransportMode(req.TransportMode).
        SetTotalDistanceKm(int(route.TotalDistanceKm)).
        SetTotalTravelTimeMinutes(route.TotalTravelTime).
        Save(ctx)
    if err != nil {
        tx.Rollback()
        return nil, err
    }
    
    // Save visits
    for _, visit := range route.Visits {
        _, err := tx.Visit.Create().
            SetItineraryID(itinerary.ID).
            SetPlaceID(visit.Place.ID).
            SetSequenceOrder(visit.SequenceOrder).
            SetArrivalTime(visit.ArrivalTime).
            SetDepartureTime(visit.DepartureTime).
            SetVisitDurationMinutes(visit.VisitDuration).
            SetTravelTimeFromPrevious(visit.TravelTimeFromPrevious).
            SetDistanceFromPreviousKm(int(visit.DistanceFromPrevious)).
            Save(ctx)
        if err != nil {
            tx.Rollback()
            return nil, err
        }
    }
    
    if err := tx.Commit(); err != nil {
        return nil, err
    }
    
    // 6. Build response
    return s.buildResponse(itinerary, route), nil
}
```

### Phase 5: API Handlers & Swagger (Day 4-5)

```go
// internal/handler/itinerary_handler.go
package handler

// @Summary Create itinerary
// @Description Create a new travel itinerary with optimized route
// @Tags itineraries
// @Accept json
// @Produce json
// @Param request body CreateItineraryRequest true "Itinerary details"
// @Success 201 {object} ItineraryResponse
// @Failure 400 {object} ErrorResponse
// @Failure 404 {object} ErrorResponse
// @Failure 422 {object} ErrorResponse
// @Router /api/itineraries [post]
func (h *ItineraryHandler) CreateItinerary(c *gin.Context) {
    var req CreateItineraryRequest
    
    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(400, NewErrorResponse("INVALID_JSON", err.Error()))
        return
    }
    
    resp, err := h.service.CreateItinerary(c.Request.Context(), &req)
    if err != nil {
        handleError(c, err)
        return
    }
    
    c.JSON(201, resp)
}

// @Summary Get itinerary
// @Description Get itinerary details by ID
// @Tags itineraries
// @Produce json
// @Param id path string true "Itinerary ID" format(uuid)
// @Success 200 {object} ItineraryResponse
// @Failure 404 {object} ErrorResponse
// @Router /api/itineraries/{id} [get]
func (h *ItineraryHandler) GetItinerary(c *gin.Context) {
    id, err := uuid.Parse(c.Param("id"))
    if err != nil {
        c.JSON(400, NewErrorResponse("INVALID_ID", "Invalid UUID format"))
        return
    }
    
    resp, err := h.service.GetItinerary(c.Request.Context(), id)
    if err != nil {
        handleError(c, err)
        return
    }
    
    c.JSON(200, resp)
}
```

### Phase 6: Main Server & Swagger Setup (Day 5)

```go
// cmd/server/main.go
package main

import (
    "log"
    "os"
    
    "github.com/gin-gonic/gin"
    swaggerFiles "github.com/swaggo/files"
    ginSwagger "github.com/swaggo/gin-swagger"
    
    _ "github.com/yourusername/nashik-itinerary/docs" // Swagger docs
)

// @title Nashik Itinerary Planner API
// @version 1.0
// @description API for creating optimized travel itineraries
// @host localhost:8080
// @BasePath /
func main() {
    // Load config
    dsn := os.Getenv("DATABASE_DSN")
    googleAPIKey := os.Getenv("GOOGLE_MAPS_API_KEY")
    
    // Initialize database
    db, err := config.NewDB(dsn)
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()
    
    // Initialize routing client
    routingClient, err := routing.NewGoogleMapsClient(googleAPIKey)
    if err != nil {
        log.Fatal(err)
    }
    
    // Initialize service
    itineraryService := service.NewItineraryService(db, routingClient)
    
    // Initialize handlers
    itineraryHandler := handler.NewItineraryHandler(itineraryService)
    placeHandler := handler.NewPlaceHandler(db)
    
    // Setup router
    r := gin.Default()
    
    // Middleware
    r.Use(gin.Recovery())
    r.Use(gin.Logger())
    
    // Routes
    api := r.Group("/api")
    {
        api.POST("/itineraries", itineraryHandler.CreateItinerary)
        api.GET("/itineraries/:id", itineraryHandler.GetItinerary)
        api.GET("/places", placeHandler.ListPlaces)
    }
    
    // Swagger
    r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
    
    // Start server
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }
    
    log.Printf("Server starting on port %s", port)
    if err := r.Run(":" + port); err != nil {
        log.Fatal(err)
    }
}
```

### Phase 7: Generate Swagger Docs

```bash
# Generate Swagger documentation
swag init -g cmd/server/main.go -o docs

# Swagger UI will be available at http://localhost:8080/swagger/index.html
```

### Phase 8: Testing (Day 6)

```go
// internal/service/itinerary_service_test.go
package service

func TestOptimizeRoute(t *testing.T) {
    // Mock data
    startLoc := Location{Lat: 19.9975, Lng: 73.7898}
    places := []*ent.Place{
        {ID: uuid.New(), Name: "Place A", Latitude: 19.998, Longitude: 73.790},
        {ID: uuid.New(), Name: "Place B", Latitude: 20.001, Longitude: 73.785},
        {ID: uuid.New(), Name: "Place C", Latitude: 20.020, Longitude: 73.783},
    }
    
    // Test
    route, err := service.optimizeRoute(
        context.Background(),
        startLoc,
        places,
        time.Now(),
        time.Now().Add(7 * time.Hour),
        30,
        "driving",
    )
    
    assert.NoError(t, err)
    assert.Equal(t, 3, len(route.Visits))
    assert.True(t, route.Feasible)
}
```

---

## 8. Technology Stack

### 8.1 Core Technologies

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| **Language** | Go | 1.21+ | Backend server |
| **Web Framework** | Gin | v1.9+ | HTTP routing & middleware |
| **ORM** | ENT | v0.12+ | Database modeling & queries |
| **Database** | PostgreSQL | 14+ | Data persistence |
| **Validation** | go-playground/validator | v10 | Input validation |
| **API Docs** | Swagger/OpenAPI | 3.0 | API documentation |
| **Routing Service** | Google Maps API | - | Distance matrix & directions |

### 8.2 Project Dependencies

```go
// go.mod
module github.com/yourusername/nashik-itinerary

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    entgo.io/ent v0.12.5
    github.com/lib/pq v1.10.9
    github.com/google/uuid v1.5.0
    github.com/go-playground/validator/v10 v10.16.0
    github.com/swaggo/swag v1.16.2
    github.com/swaggo/gin-swagger v1.6.0
    github.com/swaggo/files v1.0.1
    googlemaps.github.io/maps v1.5.0
)
```

### 8.3 Environment Variables

```bash
# .env.example
DATABASE_DSN=postgres://user:password@localhost:5432/nashik_itinerary?sslmode=disable
GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
PORT=8080
GIN_MODE=debug  # Use 'release' in production
```

### 8.4 Development Tools

```bash
# Install tools
go install entgo.io/ent/cmd/ent@latest
go install github.com/swaggo/swag/cmd/swag@latest

# Run database (Docker)
docker run --name postgres-nashik \
  -e POSTGRES_DB=nashik_itinerary \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=secret \
  -p 5432:5432 \
  -d postgres:14-alpine

# Run server
export DATABASE_DSN="postgres://admin:secret@localhost:5432/nashik_itinerary?sslmode=disable"
export GOOGLE_MAPS_API_KEY="your_key"
go run cmd/server/main.go

# Generate Swagger docs
swag init -g cmd/server/main.go -o docs

# Access Swagger UI
open http://localhost:8080/swagger/index.html
```

---

## 🚀 Quick Start Guide

```bash
# 1. Clone and setup
git clone <repo-url>
cd nashik-itinerary
go mod download

# 2. Start PostgreSQL
docker-compose up -d postgres

# 3. Set environment variables
cp .env.example .env
# Edit .env with your Google Maps API key

# 4. Generate ENT code
ent generate ./ent/schema

# 5. Seed database with Nashik places
go run scripts/seed.go

# 6. Generate Swagger docs
swag init -g cmd/server/main.go -o docs

# 7. Run server
go run cmd/server/main.go

# 8. Test API
curl -X POST http://localhost:8080/api/itineraries \
  -H "Content-Type: application/json" \
  -d @examples/create_itinerary.json

# 9. View Swagger UI
open http://localhost:8080/swagger/index.html
```

---

## ✅ MVP Success Criteria

- [ ] User can submit itinerary request with 1-5 places
- [ ] System validates all inputs and returns clear error messages
- [ ] System optimizes route using nearest-neighbor algorithm
- [ ] System calculates accurate arrival/departure times
- [ ] System verifies time window feasibility
- [ ] System returns complete structured itinerary with all visit details
- [ ] API is fully documented with Swagger/OpenAPI
- [ ] Database stores itineraries and visits correctly
- [ ] Response includes total distance, travel time, and time buffer
- [ ] System handles edge cases (invalid places, impossible schedules)

---

## 📚 Next Steps (Post-MVP)

Once MVP is stable, consider adding:
1. User authentication (JWT)
2. Place recommendations based on preferences
3. Export itinerary as PDF
4. Share itinerary via link
5. Multi-day trip support
6. Weather integration
7. Cost estimation
8. User reviews for places

---

**Document Version:** 1.0  
**Last Updated:** December 6, 2025  
**Author:** Ayush Sharma
**Status:** Ready for Implementation
