# Itinerary Planner MVP — Implementation Document

**Project:** Nashik Darshan Itinerary Planner (Minimum Viable Product)  
**Backend:** Go + ENT ORM + PostgreSQL  
**API Documentation:** Swagger/OpenAPI  
**Date:** December 6, 2025

---

## 📁 Project Structure Reference

```
nashik-darshan-v2/
├── cmd/
│   ├── server/main.go           # Main server entry point
│   └── migrate/main.go          # Database migration runner
├── ent/
│   └── schema/                  # ENT schema definitions
│       ├── user.go              # ✅ Existing
│       ├── place.go             # ✅ Existing
│       ├── itinerary.go         # 🆕 To be created
│       └── visit.go             # 🆕 To be created
├── internal/
│   ├── api/
│   │   ├── router.go            # Main router setup
│   │   ├── dto/                 # Data Transfer Objects
│   │   │   ├── itinerary.go    # 🆕 Itinerary DTOs
│   │   │   └── place.go         # ✅ Existing
│   │   └── v1/                  # API handlers (v1)
│   │       ├── itinerary.go    # 🆕 Itinerary handler
│   │       └── place.go         # ✅ Existing
│   ├── service/                 # Business logic layer
│   │   ├── itinerary.go        # 🆕 Itinerary service
│   │   └── event.go             # ✅ Existing reference
│   ├── repository/              # Data access layer
│   │   └── ent/                 # ENT repository implementations
│   │       ├── itinerary.go    # 🆕 Itinerary repository
│   │       └── place.go         # ✅ Existing
│   ├── domain/                  # Domain models
│   │   ├── itinerary/          # 🆕 Itinerary domain
│   │   │   ├── model.go        # Domain models
│   │   │   └── repository.go   # Repository interface
│   │   └── event/               # ✅ Existing reference
│   ├── types/                   # Shared types and enums
│   │   ├── itinerary.go        # 🆕 Itinerary-specific types
│   │   └── base.go              # ✅ Existing base types
│   ├── errors/                  # Custom error handling (ierr)
│   │   └── errors.go            # ✅ Error builder pattern
│   ├── validator/               # Input validation
│   │   └── validator.go         # ✅ Validation utilities
│   ├── logger/                  # Logging utilities
│   │   └── logger.go            # ✅ Structured logging
│   ├── config/                  # Configuration management
│   │   └── config.go            # ✅ Config loader
│   └── postgres/                # Database client
│       └── client.go            # ✅ ENT client wrapper
├── docs/
│   ├── swagger/                 # Auto-generated Swagger docs
│   └── prds/
│       ├── itenary.md          # 📄 This document
│       └── events.md            # ✅ Existing reference
└── scripts/
    └── seed_places.go          # 🆕 Seed Nashik places
```

### 📝 File Organization Guide

| Component | Location | Purpose |
|-----------|----------|---------|
| **API Handlers** | `internal/api/v1/*.go` | HTTP request handling, input binding, response formatting |
| **DTOs** | `internal/api/dto/*.go` | Request/response structures, validation tags |
| **Business Logic** | `internal/service/*.go` | Core algorithms, orchestration, business rules |
| **Data Access** | `internal/repository/ent/*.go` | Database queries, ENT operations |
| **Domain Models** | `internal/domain/*/model.go` | Pure domain objects, conversion logic |
| **Repository Interfaces** | `internal/domain/*/repository.go` | Repository contracts |
| **Schemas** | `ent/schema/*.go` | ENT entity definitions |
| **Types** | `internal/types/*.go` | Enums, filters, shared types |
| **Error Handling** | `internal/errors/*.go` | Custom error builder (ierr) |
| **Validation** | `internal/validator/*.go` | Input validation rules |

---

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

**File:** `internal/api/dto/itinerary.go`

```go
package dto

import (
    "time"
    "github.com/omkar273/nashikdarshan/internal/types"
    ierr "github.com/omkar273/nashikdarshan/internal/errors"
    "github.com/shopspring/decimal"
)

// CreateItineraryRequest represents a request to create an itinerary
type CreateItineraryRequest struct {
    CurrentLocation types.Location       `json:"current_location" binding:"required"`
    City            string               `json:"city" binding:"required,min=2"`
    TripDate        time.Time            `json:"trip_date" binding:"required"` // ISO 8601
    StartTime       time.Time            `json:"start_time" binding:"required"` // ISO 8601 with time
    EndTime         time.Time            `json:"end_time" binding:"required"`   // ISO 8601 with time
    SelectedPlaces  []string             `json:"selected_places" binding:"required,min=1,max=5"`
    VisitDuration   int                  `json:"visit_duration" binding:"omitempty,min=15,max=120"`
    TransportMode   types.TransportMode  `json:"transport_mode" binding:"omitempty"`
}

// Validate validates the CreateItineraryRequest
func (req *CreateItineraryRequest) Validate() error {
    // Validate using project validator
    if err := validator.ValidateRequest(req); err != nil {
        return err
    }

    // Validate trip date is not in the past
    if req.TripDate.Before(time.Now().Truncate(24 * time.Hour)) {
        return ierr.NewError("Trip date cannot be in the past").
            WithHint("Please select today or a future date").
            Mark(ierr.ErrValidation)
    }

    // Validate time window (at least 2 hours)
    duration := req.EndTime.Sub(req.StartTime)
    if duration < 2*time.Hour {
        return ierr.NewError("Trip duration must be at least 2 hours").
            WithHint("Please extend your time window").
            WithDetails(map[string]interface{}{
                "start_time": req.StartTime,
                "end_time":   req.EndTime,
                "duration":   duration.String(),
            }).
            Mark(ierr.ErrValidation)
    }

    // Validate location coordinates
    if err := req.CurrentLocation.Validate(); err != nil {
        return ierr.WithError(err).
            WithHint("Please provide valid latitude and longitude").
            Mark(ierr.ErrValidation)
    }

    // Validate no duplicate place IDs
    seen := make(map[string]bool)
    for _, placeID := range req.SelectedPlaces {
        if seen[placeID] {
            return ierr.NewError("Duplicate place IDs not allowed").
                WithHint("Each place can only be selected once").
                WithDetails(map[string]interface{}{
                    "duplicate_id": placeID,
                }).
                Mark(ierr.ErrValidation)
        }
        seen[placeID] = true
    }

    // Validate transport mode
    if req.TransportMode != "" {
        if err := req.TransportMode.Validate(); err != nil {
            return err
        }
    }

    return nil
}
```

**File:** `internal/types/itinerary.go`

```go
package types

import (
    ierr "github.com/omkar273/nashikdarshan/internal/errors"
    "github.com/shopspring/decimal"
)

// TransportMode represents the mode of transportation
type TransportMode string

const (
    TransportModeWalking TransportMode = "WALKING"
    TransportModeDriving TransportMode = "DRIVING"
    TransportModeTaxi    TransportMode = "TAXI"
)

// Validate validates the TransportMode
func (tm TransportMode) Validate() error {
    switch tm {
    case TransportModeWalking, TransportModeDriving, TransportModeTaxi:
        return nil
    default:
        return ierr.NewError("Invalid transport mode").
            WithHint("Must be one of: WALKING, DRIVING, TAXI").
            Mark(ierr.ErrValidation)
    }
}

// Location represents a geographic location
type Location struct {
    Latitude  decimal.Decimal `json:"latitude" binding:"required"`
    Longitude decimal.Decimal `json:"longitude" binding:"required"`
}

// Validate validates the Location coordinates
func (l *Location) Validate() error {
    lat := l.Latitude
    lng := l.Longitude

    // Validate latitude range (-90 to 90)
    if lat.LessThan(decimal.NewFromInt(-90)) || lat.GreaterThan(decimal.NewFromInt(90)) {
        return ierr.NewError("Invalid latitude").
            WithHint("Latitude must be between -90 and 90").
            WithDetails(map[string]interface{}{
                "latitude": lat.String(),
            }).
            Mark(ierr.ErrValidation)
    }

    // Validate longitude range (-180 to 180)
    if lng.LessThan(decimal.NewFromInt(-180)) || lng.GreaterThan(decimal.NewFromInt(180)) {
        return ierr.NewError("Invalid longitude").
            WithHint("Longitude must be between -180 and 180").
            WithDetails(map[string]interface{}{
                "longitude": lng.String(),
            }).
            Mark(ierr.ErrValidation)
    }

    return nil
}

// ItineraryStatus represents the status of an itinerary
type ItineraryStatus string

const (
    ItineraryStatusDraft     ItineraryStatus = "DRAFT"
    ItineraryStatusCompleted ItineraryStatus = "COMPLETED"
    ItineraryStatusCancelled ItineraryStatus = "CANCELLED"
)

// Validate validates the ItineraryStatus
func (is ItineraryStatus) Validate() error {
    switch is {
    case ItineraryStatusDraft, ItineraryStatusCompleted, ItineraryStatusCancelled:
        return nil
    default:
        return ierr.NewError("Invalid itinerary status").
            WithHint("Must be one of: DRAFT, COMPLETED, CANCELLED").
            Mark(ierr.ErrValidation)
    }
}
```

### 1.4 Validation Rules

**Server-side validation must ensure:**

| Rule | Validation Location | Error Type |
|------|-------------------|------------|
| Current location coordinates valid (lat: -90 to 90, lng: -180 to 180) | `types.Location.Validate()` | `ierr.ErrValidation` |
| Trip date is not in the past | `dto.CreateItineraryRequest.Validate()` | `ierr.ErrValidation` |
| End time is at least 2 hours after start time | `dto.CreateItineraryRequest.Validate()` | `ierr.ErrValidation` |
| Each place ID exists in database | `service.CreateItinerary()` | `ierr.ErrNotFound` |
| Number of places between 1 and 5 | Gin binding validation | `ierr.ErrValidation` |
| No duplicate place IDs | `dto.CreateItineraryRequest.Validate()` | `ierr.ErrValidation` |
| Visit duration allows fitting all places | `service.optimizeRoute()` | `ierr.ErrInvalidOperation` |
| Transport mode is valid enum | `types.TransportMode.Validate()` | `ierr.ErrValidation` |

**Error Handling Pattern:**

```go
// In handler (internal/api/v1/itinerary.go)
func (h *ItineraryHandler) Create(c *gin.Context) {
    var req dto.CreateItineraryRequest
    if err := c.ShouldBindJSON(&req); err != nil {
        c.Error(ierr.WithError(err).
            WithHint("Please check the request payload").
            Mark(ierr.ErrValidation))
        return
    }

    itinerary, err := h.itineraryService.Create(c.Request.Context(), &req)
    if err != nil {
        c.Error(err) // Error middleware handles formatting
        return
    }
    
    c.JSON(http.StatusCreated, itinerary)
}

// In service (internal/service/itinerary.go)
func (s *itineraryService) Create(ctx context.Context, req *dto.CreateItineraryRequest) (*dto.ItineraryResponse, error) {
    // Validate request
    if err := req.Validate(); err != nil {
        return nil, err // Already has ierr.ErrValidation marker
    }

    // Fetch places
    places, err := s.fetchPlaces(ctx, req.SelectedPlaces)
    if err != nil {
        return nil, ierr.WithError(err).
            WithHint("One or more places not found").
            Mark(ierr.ErrNotFound)
    }

    // Check if schedule is feasible
    if !s.isFeasible(req, places) {
        return nil, ierr.NewError("Cannot fit all places within time window").
            WithHint("Reduce number of places or extend time window").
            WithDetails(map[string]interface{}{
                "available_time": req.EndTime.Sub(req.StartTime).Minutes(),
                "required_time":  s.calculateRequiredTime(req, places),
            }).
            Mark(ierr.ErrInvalidOperation)
    }

    // Continue with route optimization...
}
```

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

**Status:** ✅ Already exists - Add edges only

```go
// Add to existing User schema
func (User) Edges() []ent.Edge {
    return []ent.Edge{
        // ... existing edges ...
        edge.To("itineraries", Itinerary.Type),
    }
}
```

#### Place Schema (`ent/schema/place.go`)

**Status:** ✅ Already exists - Add fields and edges only

```go
// Add to existing Place schema fields
func (Place) Fields() []ent.Field {
    return []ent.Field{
        // ... existing fields ...
        
        // Add these new fields for itinerary planning
        field.Int("avg_visit_minutes").
            Default(30).
            Positive().
            Comment("Average time visitors spend at this place"),
        field.JSON("opening_hours", &types.Metadata{}).
            Optional().
            Comment("Operating hours - {\"monday\": \"09:00-18:00\", ...}"),
    }
}

// Add to existing Place schema edges
func (Place) Edges() []ent.Edge {
    return []ent.Edge{
        // ... existing edges ...
        edge.To("visits", Visit.Type),
    }
}

// Add to existing Place schema indexes
func (Place) Indexes() []ent.Index {
    return []ent.Index{
        // ... existing indexes ...
        index.Fields("city", "status"), // For filtering active places by city
    }
}
```

#### Itinerary Schema (`ent/schema/itinerary.go`)

**Status:** 🆕 New file to create

**File:** `ent/schema/itinerary.go`

```go
package schema

import (
    "time"

    "entgo.io/ent"
    "entgo.io/ent/dialect/entsql"
    "entgo.io/ent/schema/edge"
    "entgo.io/ent/schema/field"
    "entgo.io/ent/schema/index"
    "github.com/omkar273/nashikdarshan/internal/types"
)

// Itinerary holds the schema definition for the Itinerary entity.
type Itinerary struct {
    ent.Schema
}

// Mixin defines the mixins for Itinerary
func (Itinerary) Mixin() []ent.Mixin {
    return []ent.Mixin{
        BaseMixin{},     // Provides: id, created_at, updated_at, created_by, updated_by
        MetadataMixin{}, // Provides: metadata field
    }
}

// Fields of the Itinerary.
func (Itinerary) Fields() []ent.Field {
    return []ent.Field{
        field.String("user_id").
            NotEmpty().
            Comment("User who created the itinerary"),
        
        field.String("city").
            NotEmpty().
            MaxLen(100).
            Comment("Destination city"),
        
        field.Time("trip_date").
            Comment("Date of the trip"),
        
        field.Time("start_time").
            Comment("Trip start time (date + time)"),
        
        field.Time("end_time").
            Comment("Trip end time (date + time)"),
        
        field.Other("start_latitude", &types.Decimal{}).
            SchemaType(map[string]string{
                dialect.Postgres: "decimal(10,7)",
            }).
            Comment("Starting location latitude"),
        
        field.Other("start_longitude", &types.Decimal{}).
            SchemaType(map[string]string{
                dialect.Postgres: "decimal(10,7)",
            }).
            Comment("Starting location longitude"),
        
        field.Int("visit_duration_minutes").
            Default(30).
            Positive().
            Comment("Default duration per place"),
        
        field.String("transport_mode").
            Default(string(types.TransportModeDriving)).
            Comment("WALKING, DRIVING, TAXI"),
        
        field.String("status").
            Default(string(types.ItineraryStatusDraft)).
            Comment("DRAFT, COMPLETED, CANCELLED"),
        
        field.Int("total_distance_km").
            Optional().
            Nillable().
            Comment("Total travel distance in km"),
        
        field.Int("total_travel_time_minutes").
            Optional().
            Nillable().
            Comment("Total travel time in minutes"),
    }
}

// Edges of the Itinerary.
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

// Indexes of the Itinerary.
func (Itinerary) Indexes() []ent.Index {
    return []ent.Index{
        // Find user's itineraries
        index.Fields("user_id", "status"),
        
        // Find itineraries by date
        index.Fields("city", "trip_date", "status"),
        
        // Find recent itineraries
        index.Fields("created_at").
            Annotations(entsql.Desc()),
    }
}
```

#### Visit Schema (`ent/schema/visit.go`)

**Status:** 🆕 New file to create

**File:** `ent/schema/visit.go`

```go
package schema

import (
    "time"

    "entgo.io/ent"
    "entgo.io/ent/schema/edge"
    "entgo.io/ent/schema/field"
    "entgo.io/ent/schema/index"
    "github.com/omkar273/nashikdarshan/internal/types"
)

// Visit holds the schema definition for the Visit entity.
type Visit struct {
    ent.Schema
}

// Mixin defines the mixins for Visit
func (Visit) Mixin() []ent.Mixin {
    return []ent.Mixin{
        BaseMixin{}, // Provides: id, created_at, updated_at, created_by, updated_by
    }
}

// Fields of the Visit.
func (Visit) Fields() []ent.Field {
    return []ent.Field{
        field.String("itinerary_id").
            NotEmpty().
            Comment("Parent itinerary ID"),
        
        field.String("place_id").
            NotEmpty().
            Comment("Place being visited"),
        
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
            NonNegative().
            Comment("Travel time from previous location (minutes)"),
        
        field.Int("distance_from_previous_km").
            Default(0).
            NonNegative().
            Comment("Distance from previous location (km)"),
        
        field.String("directions").
            Optional().
            MaxLen(1000).
            Comment("Turn-by-turn directions from previous location"),
    }
}

// Edges of the Visit.
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

// Indexes of the Visit.
func (Visit) Indexes() []ent.Index {
    return []ent.Index{
        // Get all visits for an itinerary in sequence order
        index.Fields("itinerary_id", "sequence_order"),
        
        // Check which itineraries include a place
        index.Fields("place_id"),
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

**Error Response (400 Bad Request - Validation):**
```json
{
  "error": {
    "code": "validation_error",
    "message": "Trip duration must be at least 2 hours",
    "hint": "Please extend your time window",
    "details": {
      "start_time": "2025-12-20T10:00:00Z",
      "end_time": "2025-12-20T11:00:00Z",
      "duration": "1h0m0s"
    }
  }
}
```

**Error Response (404 Not Found - Place Not Found):**
```json
{
  "error": {
    "code": "not_found",
    "message": "One or more selected places not found",
    "hint": "Please verify the place IDs",
    "details": {
      "missing_ids": ["invalid-uuid-1", "invalid-uuid-2"],
      "total_selected": 3,
      "found": 1
    }
  }
}
```

**Error Response (400 Bad Request - Infeasible Schedule):**
```json
{
  "error": {
    "code": "invalid_operation",
    "message": "Cannot fit all places within time window",
    "hint": "Reduce number of places or extend time window",
    "details": {
      "available_time_minutes": 240,
      "required_time_minutes": 300,
      "places_count": 5,
      "visit_duration_per_place": 45,
      "estimated_travel_time": 75
    }
  }
}
```

**Error Handling in Code:**

```go
// internal/service/itinerary.go

// Example: Place not found
func (s *itineraryService) fetchPlaces(ctx context.Context, placeIDs []string) ([]*domain.Place, error) {
    places, err := s.placeRepo.GetByIDs(ctx, placeIDs)
    if err != nil {
        return nil, ierr.WithError(err).
            WithHint("Failed to fetch places from database").
            Mark(ierr.ErrDatabase)
    }

    if len(places) != len(placeIDs) {
        foundIDs := make(map[string]bool)
        for _, p := range places {
            foundIDs[p.ID] = true
        }
        
        missingIDs := []string{}
        for _, id := range placeIDs {
            if !foundIDs[id] {
                missingIDs = append(missingIDs, id)
            }
        }

        return nil, ierr.NewError("One or more selected places not found").
            WithHint("Please verify the place IDs").
            WithDetails(map[string]interface{}{
                "missing_ids":    missingIDs,
                "total_selected": len(placeIDs),
                "found":          len(places),
            }).
            Mark(ierr.ErrNotFound)
    }

    return places, nil
}

// Example: Infeasible schedule
func (s *itineraryService) checkFeasibility(
    req *dto.CreateItineraryRequest,
    estimatedTravelTime int,
) error {
    availableMinutes := int(req.EndTime.Sub(req.StartTime).Minutes())
    visitDuration := req.VisitDuration
    if visitDuration == 0 {
        visitDuration = 30 // default
    }
    
    totalVisitTime := len(req.SelectedPlaces) * visitDuration
    requiredTime := totalVisitTime + estimatedTravelTime

    if requiredTime > availableMinutes {
        return ierr.NewError("Cannot fit all places within time window").
            WithHint("Reduce number of places or extend time window").
            WithDetails(map[string]interface{}{
                "available_time_minutes":      availableMinutes,
                "required_time_minutes":       requiredTime,
                "places_count":                len(req.SelectedPlaces),
                "visit_duration_per_place":    visitDuration,
                "estimated_travel_time":       estimatedTravelTime,
            }).
            Mark(ierr.ErrInvalidOperation)
    }

    return nil
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

**File:** `internal/service/itinerary.go`

```go
package service

import (
    "context"
    "time"

    "github.com/omkar273/nashikdarshan/internal/api/dto"
    domain "github.com/omkar273/nashikdarshan/internal/domain/itinerary"
    ierr "github.com/omkar273/nashikdarshan/internal/errors"
    "github.com/omkar273/nashikdarshan/internal/types"
)

// ItineraryService interface
type ItineraryService interface {
    Create(ctx context.Context, req *dto.CreateItineraryRequest) (*dto.ItineraryResponse, error)
    Get(ctx context.Context, id string) (*dto.ItineraryResponse, error)
    List(ctx context.Context, userID string, filter *types.ItineraryFilter) (*dto.ListItinerariesResponse, error)
    Delete(ctx context.Context, id string) error
}

type itineraryService struct {
    ServiceParams
    itineraryRepo domain.Repository
    placeRepo     // Place repository for fetching places
    routingClient RoutingClient // Google Maps API client
}

// NewItineraryService creates a new itinerary service
func NewItineraryService(
    params ServiceParams,
    itineraryRepo domain.Repository,
    placeRepo placeRepo,
    routingClient RoutingClient,
) ItineraryService {
    return &itineraryService{
        ServiceParams: params,
        itineraryRepo: itineraryRepo,
        placeRepo:     placeRepo,
        routingClient: routingClient,
    }
}

// Create creates a new itinerary with optimized route
func (s *itineraryService) Create(
    ctx context.Context,
    req *dto.CreateItineraryRequest,
) (*dto.ItineraryResponse, error) {
    // 1. Validate request
    if err := req.Validate(); err != nil {
        return nil, err
    }

    // 2. Fetch places from database
    places, err := s.fetchPlaces(ctx, req.SelectedPlaces)
    if err != nil {
        return nil, err
    }

    // 3. Get distance matrix from routing service
    matrix, err := s.routingClient.GetDistanceMatrix(
        ctx,
        req.CurrentLocation,
        places,
        req.TransportMode,
    )
    if err != nil {
        return nil, ierr.WithError(err).
            WithHint("Failed to calculate route distances").
            Mark(ierr.ErrIntegration)
    }

    // 4. Optimize route using nearest-neighbor algorithm
    route, err := s.optimizeRoute(
        ctx,
        req,
        places,
        matrix,
    )
    if err != nil {
        return nil, err
    }

    // 5. Convert to domain model and save
    itinerary := req.ToItinerary(route)
    if err := s.itineraryRepo.Create(ctx, itinerary); err != nil {
        return nil, ierr.WithError(err).
            WithHint("Failed to save itinerary").
            Mark(ierr.ErrDatabase)
    }

    // 6. Build and return response
    return dto.NewItineraryResponse(itinerary), nil
}

// optimizeRoute implements nearest-neighbor algorithm
func (s *itineraryService) optimizeRoute(
    ctx context.Context,
    req *dto.CreateItineraryRequest,
    places []*domain.Place,
    matrix *DistanceMatrix,
) (*domain.OptimizedRoute, error) {
    // Get visit duration (default to 30 if not specified)
    visitDuration := req.VisitDuration
    if visitDuration == 0 {
        visitDuration = 30
    }

    // Initialize state
    currentLoc := req.CurrentLocation
    currentTime := req.StartTime
    unvisited := make(map[string]*domain.Place)
    for _, p := range places {
        unvisited[p.ID] = p
    }

    var visits []*domain.Visit
    totalDistance := 0
    totalTravelTime := 0
    sequenceOrder := 1

    // Greedy nearest-neighbor selection
    for len(unvisited) > 0 {
        // Find nearest unvisited place
        nearestPlace, distance := s.findNearest(currentLoc, unvisited, matrix)
        if nearestPlace == nil {
            return nil, ierr.NewError("Failed to find nearest place").
                WithHint("Route optimization failed").
                Mark(ierr.ErrInternal)
        }

        // Get travel time from matrix
        travelTime := matrix.GetTravelTime(currentLoc, nearestPlace.Location)
        
        // Calculate arrival and departure times
        arrivalTime := currentTime.Add(time.Duration(travelTime) * time.Minute)
        departureTime := arrivalTime.Add(time.Duration(visitDuration) * time.Minute)

        // Check if we exceed time window
        if departureTime.After(req.EndTime) {
            return nil, ierr.NewError("Cannot fit all places within time window").
                WithHint("Reduce number of places or extend time window").
                WithDetails(map[string]interface{}{
                    "available_time": req.EndTime.Sub(req.StartTime).Minutes(),
                    "required_time":  departureTime.Sub(req.StartTime).Minutes(),
                    "places_fitted":  len(visits),
                    "total_places":   len(req.SelectedPlaces),
                }).
                Mark(ierr.ErrInvalidOperation)
        }

        // Get directions from routing client
        directions, err := s.routingClient.GetDirections(
            ctx,
            currentLoc,
            nearestPlace.Location,
            req.TransportMode,
        )
        if err != nil {
            s.Logger.Warnw("Failed to get directions",
                "from", currentLoc,
                "to", nearestPlace.Location,
                "error", err,
            )
            directions = "" // Continue without directions
        }

        // Create visit record
        visit := &domain.Visit{
            ID:                     types.GenerateUUIDWithPrefix(types.UUID_PREFIX_VISIT),
            PlaceID:                nearestPlace.ID,
            Place:                  nearestPlace,
            SequenceOrder:          sequenceOrder,
            ArrivalTime:            arrivalTime,
            DepartureTime:          departureTime,
            VisitDurationMinutes:   visitDuration,
            TravelTimeFromPrevious: travelTime,
            DistanceFromPreviousKm: distance,
            Directions:             directions,
        }

        visits = append(visits, visit)
        totalDistance += distance
        totalTravelTime += travelTime

        // Update state for next iteration
        currentLoc = nearestPlace.Location
        currentTime = departureTime
        delete(unvisited, nearestPlace.ID)
        sequenceOrder++
    }

    // Calculate time buffer
    timeBuffer := int(req.EndTime.Sub(currentTime).Minutes())

    return &domain.OptimizedRoute{
        Visits:              visits,
        TotalDistanceKm:     totalDistance,
        TotalTravelTime:     totalTravelTime,
        EstimatedCompletion: currentTime,
        TimeBufferMinutes:   timeBuffer,
        Feasible:            true,
    }, nil
}

// findNearest finds the nearest unvisited place
func (s *itineraryService) findNearest(
    from types.Location,
    unvisited map[string]*domain.Place,
    matrix *DistanceMatrix,
) (*domain.Place, int) {
    var nearest *domain.Place
    minDistance := int(^uint(0) >> 1) // Max int

    for _, place := range unvisited {
        distance := matrix.GetDistance(from, place.Location)
        if distance < minDistance {
            minDistance = distance
            nearest = place
        }
    }

    return nearest, minDistance
}

// fetchPlaces fetches places by IDs and validates they exist
func (s *itineraryService) fetchPlaces(
    ctx context.Context,
    placeIDs []string,
) ([]*domain.Place, error) {
    places, err := s.placeRepo.GetByIDs(ctx, placeIDs)
    if err != nil {
        return nil, ierr.WithError(err).
            WithHint("Failed to fetch places").
            Mark(ierr.ErrDatabase)
    }

    // Check all places were found
    if len(places) != len(placeIDs) {
        foundIDs := make(map[string]bool)
        for _, p := range places {
            foundIDs[p.ID] = true
        }

        missingIDs := []string{}
        for _, id := range placeIDs {
            if !foundIDs[id] {
                missingIDs = append(missingIDs, id)
            }
        }

        return nil, ierr.NewError("One or more selected places not found").
            WithHint("Please verify the place IDs").
            WithDetails(map[string]interface{}{
                "missing_ids":    missingIDs,
                "total_selected": len(placeIDs),
                "found":          len(places),
            }).
            Mark(ierr.ErrNotFound)
    }

    return places, nil
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

### Phase 1: Schema & Domain Setup (Day 1)

**Status:** Project already exists, add itinerary components

```bash
# 1. Create ENT schemas
cd /home/ayush-1/Desktop/Caygnus/nashik-darshan-v2

# Create itinerary schema
touch ent/schema/itinerary.go
touch ent/schema/visit.go

# 2. Add schema definitions (see Section 3.2)
# Edit ent/schema/itinerary.go
# Edit ent/schema/visit.go
# Edit ent/schema/place.go (add fields)
# Edit ent/schema/user.go (add edges)

# 3. Generate ENT code
go run -mod=mod entgo.io/ent/cmd/ent generate ./ent/schema

# Or use make command if available
make generate-ent
```

**Files to Create/Modify:**

| File | Action | Description |
|------|--------|-------------|
| `ent/schema/itinerary.go` | 🆕 Create | Itinerary entity schema |
| `ent/schema/visit.go` | 🆕 Create | Visit entity schema |
| `ent/schema/place.go` | ✏️ Modify | Add `avg_visit_minutes`, `opening_hours` fields |
| `ent/schema/user.go` | ✏️ Modify | Add `itineraries` edge |

### Phase 2: Domain Models & Repository (Day 1-2)

**File:** `internal/domain/itinerary/model.go`

```go
package itinerary

import (
    "time"

    "github.com/omkar273/nashikdarshan/ent"
    "github.com/omkar273/nashikdarshan/internal/types"
    "github.com/shopspring/decimal"
)

// Itinerary represents an itinerary domain model
type Itinerary struct {
    // Identity
    ID     string `json:"id"`
    UserID string `json:"user_id"`

    // Trip details
    City            string              `json:"city"`
    TripDate        time.Time           `json:"trip_date"`
    StartTime       time.Time           `json:"start_time"`
    EndTime         time.Time           `json:"end_time"`
    StartLocation   types.Location      `json:"start_location"`
    VisitDuration   int                 `json:"visit_duration_minutes"`
    TransportMode   types.TransportMode `json:"transport_mode"`

    // Route metrics
    TotalDistanceKm     *int `json:"total_distance_km,omitempty"`
    TotalTravelTime     *int `json:"total_travel_time_minutes,omitempty"`
    
    // Relations
    Visits []*Visit `json:"visits,omitempty"`

    // Metadata
    Metadata *types.Metadata `json:"metadata,omitempty"`

    // Audit (includes Status)
    types.BaseModel
}

// Visit represents a place visit in an itinerary
type Visit struct {
    // Identity
    ID          string `json:"id"`
    ItineraryID string `json:"itinerary_id"`
    PlaceID     string `json:"place_id"`

    // Sequence
    SequenceOrder int `json:"sequence_order"`

    // Timing
    ArrivalTime            time.Time `json:"arrival_time"`
    DepartureTime          time.Time `json:"departure_time"`
    VisitDurationMinutes   int       `json:"visit_duration_minutes"`
    
    // Route info
    TravelTimeFromPrevious int    `json:"travel_time_from_previous"`
    DistanceFromPreviousKm int    `json:"distance_from_previous_km"`
    Directions             string `json:"directions,omitempty"`

    // Relations
    Place *Place `json:"place,omitempty"`

    // Audit
    types.BaseModel
}

// OptimizedRoute represents the result of route optimization
type OptimizedRoute struct {
    Visits              []*Visit  `json:"visits"`
    TotalDistanceKm     int       `json:"total_distance_km"`
    TotalTravelTime     int       `json:"total_travel_time_minutes"`
    EstimatedCompletion time.Time `json:"estimated_completion"`
    TimeBufferMinutes   int       `json:"time_buffer_minutes"`
    Feasible            bool      `json:"feasible"`
}

// FromEnt converts Ent Itinerary to domain Itinerary
func FromEnt(e *ent.Itinerary) *Itinerary {
    if e == nil {
        return nil
    }

    itinerary := &Itinerary{
        ID:                  e.ID,
        UserID:              e.UserID,
        City:                e.City,
        TripDate:            e.TripDate,
        StartTime:           e.StartTime,
        EndTime:             e.EndTime,
        StartLocation:       types.Location{
            Latitude:  e.StartLatitude,
            Longitude: e.StartLongitude,
        },
        VisitDuration:       e.VisitDurationMinutes,
        TransportMode:       types.TransportMode(e.TransportMode),
        TotalDistanceKm:     e.TotalDistanceKm,
        TotalTravelTime:     e.TotalTravelTimeMinutes,
        Metadata:            types.NewMetadataFromMap(e.Metadata),
        BaseModel: types.BaseModel{
            Status:    types.Status(e.Status),
            CreatedBy: e.CreatedBy,
            UpdatedBy: e.UpdatedBy,
            CreatedAt: e.CreatedAt,
            UpdatedAt: e.UpdatedAt,
        },
    }

    // Convert visits if loaded
    if e.Edges.Visits != nil {
        itinerary.Visits = VisitFromEntList(e.Edges.Visits)
    }

    return itinerary
}

// VisitFromEnt converts Ent Visit to domain Visit
func VisitFromEnt(e *ent.Visit) *Visit {
    if e == nil {
        return nil
    }

    return &Visit{
        ID:                     e.ID,
        ItineraryID:            e.ItineraryID,
        PlaceID:                e.PlaceID,
        SequenceOrder:          e.SequenceOrder,
        ArrivalTime:            e.ArrivalTime,
        DepartureTime:          e.DepartureTime,
        VisitDurationMinutes:   e.VisitDurationMinutes,
        TravelTimeFromPrevious: e.TravelTimeFromPrevious,
        DistanceFromPreviousKm: e.DistanceFromPreviousKm,
        Directions:             e.Directions,
        BaseModel: types.BaseModel{
            CreatedBy: e.CreatedBy,
            UpdatedBy: e.UpdatedBy,
            CreatedAt: e.CreatedAt,
            UpdatedAt: e.UpdatedAt,
        },
    }
}

// VisitFromEntList converts a list of Ent Visits
func VisitFromEntList(visits []*ent.Visit) []*Visit {
    if visits == nil {
        return nil
    }

    result := make([]*Visit, len(visits))
    for i, v := range visits {
        result[i] = VisitFromEnt(v)
    }
    return result
}
```

**File:** `internal/domain/itinerary/repository.go`

```go
package itinerary

import "context"

// Repository defines the interface for itinerary data access
type Repository interface {
    // Itinerary CRUD
    Create(ctx context.Context, itinerary *Itinerary) error
    Get(ctx context.Context, id string) (*Itinerary, error)
    GetWithVisits(ctx context.Context, id string) (*Itinerary, error)
    List(ctx context.Context, userID string, filter *ItineraryFilter) ([]*Itinerary, error)
    Delete(ctx context.Context, id string) error

    // Visit operations
    CreateVisits(ctx context.Context, visits []*Visit) error
    GetVisits(ctx context.Context, itineraryID string) ([]*Visit, error)
}
```

**File:** `scripts/seed_places.go`

```go
package main

import (
    "context"
    "log"

    "github.com/omkar273/nashikdarshan/ent"
    "github.com/omkar273/nashikdarshan/internal/config"
    "github.com/omkar273/nashikdarshan/internal/postgres"
    "github.com/omkar273/nashikdarshan/internal/types"
    "github.com/shopspring/decimal"
)

func main() {
    // Load config
    cfg, err := config.Load()
    if err != nil {
        log.Fatal("Failed to load config:", err)
    }

    // Connect to database
    client, err := postgres.NewClient(cfg)
    if err != nil {
        log.Fatal("Failed to connect to database:", err)
    }
    defer client.Close()

    ctx := context.Background()

    // Seed Nashik places
    places := []struct {
        Name              string
        Slug              string
        PlaceType         string
        Latitude          string
        Longitude         string
        AvgVisitMinutes   int
        Description       string
    }{
        {
            Name:            "Kalaram Temple",
            Slug:            "kalaram-temple",
            PlaceType:       "TEMPLE",
            Latitude:        "19.9975",
            Longitude:       "73.7898",
            AvgVisitMinutes: 45,
            Description:     "Famous black stone temple dedicated to Lord Ram",
        },
        {
            Name:            "Ramkund",
            Slug:            "ramkund",
            PlaceType:       "RELIGIOUS",
            Latitude:        "19.9989",
            Longitude:       "73.7855",
            AvgVisitMinutes: 30,
            Description:     "Holy bathing ghat on Godavari river",
        },
        {
            Name:            "Pandavleni Caves",
            Slug:            "pandavleni-caves",
            PlaceType:       "HISTORICAL",
            Latitude:        "20.0204",
            Longitude:       "73.7831",
            AvgVisitMinutes: 60,
            Description:     "Ancient Buddhist caves from 3rd century BC",
        },
        // Add more places...
    }

    for _, p := range places {
        lat, _ := decimal.NewFromString(p.Latitude)
        lng, _ := decimal.NewFromString(p.Longitude)

        _, err := client.Place.Create().
            SetID(types.GenerateUUIDWithPrefix(types.UUID_PREFIX_PLACE)).
            SetSlug(p.Slug).
            SetTitle(p.Name).
            SetPlaceType(p.PlaceType).
            SetLatitude(&lat).
            SetLongitude(&lng).
            SetAvgVisitMinutes(p.AvgVisitMinutes).
            SetDescription(&p.Description).
            SetStatus(string(types.StatusPublished)).
            Save(ctx)
        
        if err != nil {
            log.Printf("Failed to create place %s: %v", p.Name, err)
            continue
        }

        log.Printf("Created place: %s", p.Name)
    }

    log.Println("Seed completed successfully!")
}
```

### Phase 3: Repository Implementation (Day 2)

**File:** `internal/repository/ent/itinerary.go`

```go
package ent

import (
    "context"

    "github.com/omkar273/nashikdarshan/ent"
    "github.com/omkar273/nashikdarshan/ent/itinerary"
    "github.com/omkar273/nashikdarshan/ent/visit"
    domain "github.com/omkar273/nashikdarshan/internal/domain/itinerary"
    ierr "github.com/omkar273/nashikdarshan/internal/errors"
    "github.com/omkar273/nashikdarshan/internal/logger"
    "github.com/omkar273/nashikdarshan/internal/postgres"
    "github.com/omkar273/nashikdarshan/internal/types"
)

type ItineraryRepository struct {
    client postgres.IClient
    log    logger.Logger
}

func NewItineraryRepository(client postgres.IClient, log *logger.Logger) domain.Repository {
    return &ItineraryRepository{
        client: client,
        log:    *log,
    }
}

// Create creates a new itinerary with visits
func (r *ItineraryRepository) Create(ctx context.Context, itin *domain.Itinerary) error {
    client := r.client.Querier(ctx)

    r.log.Debugw("creating itinerary",
        "itinerary_id", itin.ID,
        "user_id", itin.UserID,
        "city", itin.City,
        "visits_count", len(itin.Visits),
    )

    // Start transaction
    tx, err := client.Tx(ctx)
    if err != nil {
        return ierr.WithError(err).
            WithHint("Failed to start transaction").
            Mark(ierr.ErrDatabase)
    }

    // Create itinerary
    _, err = tx.Itinerary.Create().
        SetID(itin.ID).
        SetUserID(itin.UserID).
        SetCity(itin.City).
        SetTripDate(itin.TripDate).
        SetStartTime(itin.StartTime).
        SetEndTime(itin.EndTime).
        SetStartLatitude(itin.StartLocation.Latitude).
        SetStartLongitude(itin.StartLocation.Longitude).
        SetVisitDurationMinutes(itin.VisitDuration).
        SetTransportMode(string(itin.TransportMode)).
        SetStatus(string(itin.Status)).
        SetNillableTotalDistanceKm(itin.TotalDistanceKm).
        SetNillableTotalTravelTimeMinutes(itin.TotalTravelTime).
        SetNillableMetadata((*map[string]string)(itin.Metadata)).
        SetCreatedBy(itin.CreatedBy).
        SetUpdatedBy(itin.UpdatedBy).
        Save(ctx)

    if err != nil {
        tx.Rollback()
        return ierr.WithError(err).
            WithHint("Failed to create itinerary").
            Mark(ierr.ErrDatabase)
    }

    // Create visits
    for _, v := range itin.Visits {
        _, err := tx.Visit.Create().
            SetID(v.ID).
            SetItineraryID(itin.ID).
            SetPlaceID(v.PlaceID).
            SetSequenceOrder(v.SequenceOrder).
            SetArrivalTime(v.ArrivalTime).
            SetDepartureTime(v.DepartureTime).
            SetVisitDurationMinutes(v.VisitDurationMinutes).
            SetTravelTimeFromPrevious(v.TravelTimeFromPrevious).
            SetDistanceFromPreviousKm(v.DistanceFromPreviousKm).
            SetDirections(v.Directions).
            SetCreatedBy(v.CreatedBy).
            SetUpdatedBy(v.UpdatedBy).
            Save(ctx)

        if err != nil {
            tx.Rollback()
            return ierr.WithError(err).
                WithHint("Failed to create visit").
                Mark(ierr.ErrDatabase)
        }
    }

    // Commit transaction
    if err := tx.Commit(); err != nil {
        return ierr.WithError(err).
            WithHint("Failed to commit transaction").
            Mark(ierr.ErrDatabase)
    }

    r.log.Infow("created itinerary successfully",
        "itinerary_id", itin.ID,
        "visits_count", len(itin.Visits),
    )

    return nil
}

// GetWithVisits retrieves itinerary with all visits and place details
func (r *ItineraryRepository) GetWithVisits(ctx context.Context, id string) (*domain.Itinerary, error) {
    client := r.client.Querier(ctx)

    e, err := client.Itinerary.Query().
        Where(itinerary.ID(id)).
        WithVisits(func(q *ent.VisitQuery) {
            q.WithPlace().
                Order(ent.Asc(visit.FieldSequenceOrder))
        }).
        Only(ctx)

    if err != nil {
        if ent.IsNotFound(err) {
            return nil, ierr.NewError("Itinerary not found").
                WithHint("Please check the itinerary ID").
                WithDetails(map[string]interface{}{
                    "id": id,
                }).
                Mark(ierr.ErrNotFound)
        }
        return nil, ierr.WithError(err).
            WithHint("Failed to fetch itinerary").
            Mark(ierr.ErrDatabase)
    }

    return domain.FromEnt(e), nil
}

// Additional repository methods...
```

### Phase 4: Routing Service Integration (Day 3)

**File:** `internal/service/routing_client.go`

```go
package service

import (
    "context"

    "github.com/omkar273/nashikdarshan/internal/domain/itinerary"
    ierr "github.com/omkar273/nashikdarshan/internal/errors"
    "github.com/omkar273/nashikdarshan/internal/types"
    "googlemaps.github.io/maps"
)

// RoutingClient interface for getting route information
type RoutingClient interface {
    GetDistanceMatrix(
        ctx context.Context,
        origin types.Location,
        destinations []*itinerary.Place,
        mode types.TransportMode,
    ) (*DistanceMatrix, error)

    GetDirections(
        ctx context.Context,
        origin types.Location,
        destination types.Location,
        mode types.TransportMode,
    ) (string, error)
}

// GoogleMapsClient implements RoutingClient using Google Maps API
type GoogleMapsClient struct {
    client *maps.Client
}

// NewGoogleMapsClient creates a new Google Maps routing client
func NewGoogleMapsClient(apiKey string) (RoutingClient, error) {
    c, err := maps.NewClient(maps.WithAPIKey(apiKey))
    if err != nil {
        return nil, ierr.WithError(err).
            WithHint("Failed to initialize Google Maps client").
            Mark(ierr.ErrInternal)
    }
    return &GoogleMapsClient{client: c}, nil
}

// GetDistanceMatrix retrieves distance and time matrix
func (g *GoogleMapsClient) GetDistanceMatrix(
    ctx context.Context,
    origin types.Location,
    destinations []*itinerary.Place,
    mode types.TransportMode,
) (*DistanceMatrix, error) {
    // Build origins (starting location + all places)
    origins := []string{
        origin.Latitude.String() + "," + origin.Longitude.String(),
    }
    for _, place := range destinations {
        origins = append(origins,
            place.Location.Latitude.String() + "," + place.Location.Longitude.String(),
        )
    }

    // Build destinations (all places)
    dests := make([]string, len(destinations))
    for i, place := range destinations {
        dests[i] = place.Location.Latitude.String() + "," + place.Location.Longitude.String()
    }

    // Call Google Maps API
    req := &maps.DistanceMatrixRequest{
        Origins:      origins,
        Destinations: dests,
        Mode:         g.convertTransportMode(mode),
    }

    resp, err := g.client.DistanceMatrix(ctx, req)
    if err != nil {
        return nil, ierr.WithError(err).
            WithHint("Failed to get distance matrix from Google Maps").
            Mark(ierr.ErrIntegration)
    }

    // Parse response into matrix
    matrix := NewDistanceMatrix(len(origins), len(dests))
    for i, row := range resp.Rows {
        for j, element := range row.Elements {
            if element.Status != "OK" {
                continue
            }
            matrix.Set(i, j, RouteInfo{
                DistanceKm:        int(element.Distance.Meters / 1000),
                TravelTimeMinutes: int(element.Duration.Minutes()),
            })
        }
    }

    return matrix, nil
}

// GetDirections retrieves turn-by-turn directions
func (g *GoogleMapsClient) GetDirections(
    ctx context.Context,
    origin types.Location,
    destination types.Location,
    mode types.TransportMode,
) (string, error) {
    req := &maps.DirectionsRequest{
        Origin:      origin.Latitude.String() + "," + origin.Longitude.String(),
        Destination: destination.Latitude.String() + "," + destination.Longitude.String(),
        Mode:        g.convertTransportMode(mode),
    }

    routes, _, err := g.client.Directions(ctx, req)
    if err != nil {
        return "", ierr.WithError(err).
            WithHint("Failed to get directions from Google Maps").
            Mark(ierr.ErrIntegration)
    }

    if len(routes) == 0 || len(routes[0].Legs) == 0 {
        return "", nil
    }

    // Get first step's instructions
    if len(routes[0].Legs[0].Steps) > 0 {
        return routes[0].Legs[0].Steps[0].HTMLInstructions, nil
    }

    return "", nil
}

func (g *GoogleMapsClient) convertTransportMode(mode types.TransportMode) maps.Mode {
    switch mode {
    case types.TransportModeWalking:
        return maps.TravelModeWalking
    case types.TransportModeDriving:
        return maps.TravelModeDriving
    default:
        return maps.TravelModeDriving
    }
}

// DistanceMatrix stores distances and times between locations
type DistanceMatrix struct {
    data [][]RouteInfo
}

type RouteInfo struct {
    DistanceKm        int
    TravelTimeMinutes int
}

func NewDistanceMatrix(rows, cols int) *DistanceMatrix {
    data := make([][]RouteInfo, rows)
    for i := range data {
        data[i] = make([]RouteInfo, cols)
    }
    return &DistanceMatrix{data: data}
}

func (m *DistanceMatrix) Set(row, col int, info RouteInfo) {
    m.data[row][col] = info
}

func (m *DistanceMatrix) Get(row, col int) RouteInfo {
    return m.data[row][col]
}

func (m *DistanceMatrix) GetDistance(from, to types.Location) int {
    // Implementation depends on how you map locations to indices
    // This is a simplified version
    return 0
}

func (m *DistanceMatrix) GetTravelTime(from, to types.Location) int {
    // Implementation depends on how you map locations to indices
    return 0
}
```

### Phase 5: Business Logic (Day 3-4)

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

### Phase 6: DTOs & API Handlers (Day 4-5)

See complete DTO definitions in Section 1.3 and API handler patterns in Section 1.4.

**Key Files to Create:**
- `internal/api/dto/itinerary.go` - Request/response DTOs
- `internal/api/v1/itinerary.go` - API handlers
- Update `internal/api/router.go` - Add itinerary routes

### Phase 7: Testing (Day 5-6)

```bash
# Run unit tests
go test ./internal/service/...
go test ./internal/repository/ent/...

# Run integration tests
go test ./internal/api/v1/... -tags=integration

# Test with curl
curl -X POST http://localhost:8080/api/v1/itineraries \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d @test/fixtures/create_itinerary.json
```

### Phase 8: Documentation & Deployment (Day 6-7)

```bash
# Generate Swagger docs
make swagger

# Build binary
make build

# Run migrations
make migrate-up

# Deploy (example)
./bin/server
```

---

## 8. Technology Stack

### 8.1 Core Technologies

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| **Language** | Go | 1.21+ | Backend server |
| **Web Framework** | Gin | v1.9+ | HTTP routing & middleware |
| **ORM** | ENT | v0.13+ | Database modeling & queries |
| **Database** | PostgreSQL | 15+ | Data persistence with PostGIS |
| **Validation** | Gin bindings | - | Input validation |
| **Error Handling** | Custom ierr | - | Structured error responses |
| **Logging** | Zap (via logger package) | - | Structured logging |
| **API Docs** | Swagger/OpenAPI | 3.0 | API documentation |
| **Routing Service** | Google Maps API | - | Distance matrix & directions |
| **Decimal** | shopspring/decimal | - | Precise coordinate handling |

### 8.2 Project Dependencies

**Already in Project:**
```go
// Existing dependencies in go.mod
require (
    github.com/gin-gonic/gin
    entgo.io/ent
    github.com/lib/pq
    github.com/shopspring/decimal
    github.com/swaggo/swag
    github.com/swaggo/gin-swagger
    github.com/swaggo/files
    github.com/cockroachdb/errors
    go.uber.org/zap
    // ... other existing dependencies
)
```

**New Dependencies to Add:**
```bash
# Google Maps API client
go get googlemaps.github.io/maps

# Or add to go.mod:
# googlemaps.github.io/maps v1.5.0
```

### 8.3 Environment Variables

**File:** `.env` (Add to existing)

```bash
# Google Maps API
GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here

# Existing variables remain unchanged:
# DATABASE_URL=...
# SUPABASE_URL=...
# etc.
```

**File:** `config.yaml` (Add to existing)

```yaml
# Add to existing config structure
routing:
  provider: "google_maps"
  api_key: ${GOOGLE_MAPS_API_KEY}
  timeout: 30s
  cache_ttl: 3600s # Cache distance matrix results for 1 hour
```

### 8.4 Development Commands

```bash
# Generate ENT code (after schema changes)
make generate-ent

# Run migrations
make migrate-up

# Seed places
go run scripts/seed_places.go

# Generate Swagger docs
make swagger

# Run server
make run
# or
./bin/server

# Run tests
make test

# Build binary
make build
```

---

## 🚀 Quick Start Guide

```bash
# 1. Navigate to project
cd /home/ayush-1/Desktop/Caygnus/nashik-darshan-v2

# 2. Install new dependencies
go get googlemaps.github.io/maps

# 3. Add Google Maps API key to .env
echo "GOOGLE_MAPS_API_KEY=your_api_key_here" >> .env

# 4. Create ENT schemas (see Phase 1)
# - ent/schema/itinerary.go
# - ent/schema/visit.go
# - Update ent/schema/place.go and user.go

# 5. Generate ENT code
make generate-ent

# 6. Run migrations
make migrate-up

# 7. Seed Nashik places
go run scripts/seed_places.go

# 8. Generate Swagger docs (after implementing handlers)
make swagger

# 9. Run server
make run

# 10. Test API
curl -X POST http://localhost:8080/api/v1/itineraries \
  -H "Authorization: Bearer $AUTH_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "current_location": {"latitude": "19.9975", "longitude": "73.7898"},
    "city": "Nashik",
    "trip_date": "2025-12-20T00:00:00Z",
    "start_time": "2025-12-20T10:00:00Z",
    "end_time": "2025-12-20T17:00:00Z",
    "selected_places": ["place-id-1", "place-id-2", "place-id-3"],
    "visit_duration": 45,
    "transport_mode": "DRIVING"
  }'

# 11. View Swagger UI
open http://localhost:8080/swagger/index.html
```

---

## 9. Implementation Checklist

### Phase 1: Schema & Domain ✅
- [ ] Create `ent/schema/itinerary.go` with BaseMixin and MetadataMixin
- [ ] Create `ent/schema/visit.go` with BaseMixin
- [ ] Update `ent/schema/place.go` - add `avg_visit_minutes`, `opening_hours`
- [ ] Update `ent/schema/user.go` - add `itineraries` edge
- [ ] Add types to `internal/types/itinerary.go` (TransportMode, ItineraryStatus, Location)
- [ ] Add UUID prefix constant `UUID_PREFIX_VISIT = "visit"` to `internal/types/uuid.go`
- [ ] Run `make generate-ent`
- [ ] Run `make migrate-up`

### Phase 2: Domain Models & Repository ✅
- [ ] Create `internal/domain/itinerary/model.go` (Itinerary, Visit, OptimizedRoute)
- [ ] Create `internal/domain/itinerary/repository.go` (Repository interface)
- [ ] Create `internal/repository/ent/itinerary.go` (Repository implementation)
- [ ] Create `scripts/seed_places.go` (Seed Nashik places with avg_visit_minutes)
- [ ] Run seed script: `go run scripts/seed_places.go`

### Phase 3: Routing Service ✅
- [ ] Install dependency: `go get googlemaps.github.io/maps`
- [ ] Add `GOOGLE_MAPS_API_KEY` to `.env`
- [ ] Update `config.yaml` with routing section
- [ ] Update `internal/config/config.go` to load routing config
- [ ] Create `internal/service/routing_client.go` (RoutingClient interface)
- [ ] Implement GoogleMapsClient with GetDistanceMatrix and GetDirections
- [ ] Create DistanceMatrix helper struct

### Phase 4: Business Logic ✅
- [ ] Create `internal/service/itinerary.go` (ItineraryService interface)
- [ ] Implement `Create()` method with full validation
- [ ] Implement `optimizeRoute()` method (nearest-neighbor algorithm)
- [ ] Implement `findNearest()` helper
- [ ] Implement `fetchPlaces()` helper with error handling
- [ ] Implement `Get()`, `List()`, `Delete()` methods
- [ ] Add service to `internal/repository/factory.go`

### Phase 5: DTOs ✅
- [ ] Create `internal/api/dto/itinerary.go`
- [ ] Implement `CreateItineraryRequest` with Validate() method
- [ ] Implement `ItineraryResponse` and `VisitResponse`
- [ ] Implement `ListItinerariesResponse`
- [ ] Add ToItinerary() and ToVisit() conversion methods
- [ ] Add NewItineraryResponse() helper

### Phase 6: API Handlers ✅
- [ ] Create `internal/api/v1/itinerary.go`
- [ ] Implement `Create()` handler with Swagger annotations
- [ ] Implement `Get()` handler
- [ ] Implement `List()` handler
- [ ] Implement `Delete()` handler
- [ ] Add error handling using ierr pattern
- [ ] Update `internal/api/router.go` - add itinerary routes
- [ ] Add middleware for authentication (if needed)

### Phase 7: Testing ✅
- [ ] Write unit tests for `service/itinerary.go`
- [ ] Write unit tests for `repository/ent/itinerary.go`
- [ ] Write integration tests for API handlers
- [ ] Create test fixtures in `test/fixtures/`
- [ ] Test with curl commands
- [ ] Verify all error cases (validation, not found, infeasible)

### Phase 8: Documentation & Polish ✅
- [ ] Run `make swagger` to generate API docs
- [ ] Test Swagger UI at `/swagger/index.html`
- [ ] Update README.md with itinerary endpoints
- [ ] Add example requests/responses
- [ ] Document Google Maps API setup
- [ ] Add error code documentation
- [ ] Create Postman collection (optional)

---

## 10. Error Handling Reference

**Error Codes Used:**

| Code | When to Use | HTTP Status | Example |
|------|-------------|-------------|---------|
| `ierr.ErrValidation` | Invalid input data | 400 | Invalid coordinates, bad time window |
| `ierr.ErrNotFound` | Place/itinerary not found | 404 | Place ID doesn't exist |
| `ierr.ErrInvalidOperation` | Infeasible schedule | 400 | Can't fit places in time |
| `ierr.ErrDatabase` | Database operation failed | 500 | Query error, transaction failed |
| `ierr.ErrIntegration` | External API failed | 502 | Google Maps API error |
| `ierr.ErrInternal` | Unexpected internal error | 500 | Routing algorithm failure |

**Example Error Building:**

```go
// Validation error
return ierr.NewError("Trip date cannot be in the past").
    WithHint("Please select today or a future date").
    Mark(ierr.ErrValidation)

// Not found error with details
return ierr.NewError("One or more selected places not found").
    WithHint("Please verify the place IDs").
    WithDetails(map[string]interface{}{
        "missing_ids": missingIDs,
    }).
    Mark(ierr.ErrNotFound)

// Infeasible operation with helpful details
return ierr.NewError("Cannot fit all places within time window").
    WithHint("Reduce number of places or extend time window").
    WithDetails(map[string]interface{}{
        "available_time": availableMinutes,
        "required_time":  requiredMinutes,
    }).
    Mark(ierr.ErrInvalidOperation)
```

---

## ✅ MVP Success Criteria

- [ ] User can submit itinerary request with 1-5 places
- [ ] System validates all inputs and returns clear ierr-formatted errors
- [ ] System optimizes route using nearest-neighbor algorithm
- [ ] System calculates accurate arrival/departure times with Google Maps API
- [ ] System verifies time window feasibility before saving
- [ ] System returns complete structured itinerary with all visit details
- [ ] API is fully documented with Swagger/OpenAPI 3.0
- [ ] Database stores itineraries and visits with proper relations
- [ ] Response includes total distance, travel time, and time buffer
- [ ] System handles edge cases (invalid places, impossible schedules, API failures)
- [ ] All errors use ierr pattern with codes, hints, and details
- [ ] Places are pre-seeded with Nashik tourist spots

---

## 📚 Next Steps (Post-MVP)

**Phase 2 Enhancements:**
1. **Smart Recommendations**: Suggest places based on visit history and preferences
2. **Real-time Traffic**: Integrate traffic data for better time estimates
3. **Weather Integration**: Show weather forecast for trip date
4. **Cost Estimation**: Calculate fuel/transport costs
5. **Multi-day Support**: Plan trips spanning multiple days
6. **Sharing**: Generate shareable itinerary links
7. **Export**: PDF/Calendar export functionality
8. **Reviews**: Allow users to rate completed itineraries
9. **Optimization**: Try 2-opt or genetic algorithms for better routes
10. **Caching**: Cache distance matrix results to reduce API calls

---

**Document Version:** 2.0  
**Last Updated:** December 6, 2025  
**Author:** Ayush Sharma  
**Status:** ✅ Ready for Implementation  
**Project:** nashik-darshan-v2  
**Repository:** /home/ayush-1/Desktop/Caygnus/nashik-darshan-v2
