# Hotels Module - Quick Reference

## API Endpoints

### Public Endpoints (No Authentication Required)

#### 1. List Hotels
```
GET /v1/hotels
```
**Query Parameters:**
- `limit` (int) - Number of results per page
- `offset` (int) - Pagination offset
- `status` (string) - Filter by status (published/draft/archived)
- `sort` (string) - Sort field name
- `order` (string) - Sort order (asc/desc)
- `slug` (string[]) - Filter by slugs
- `star_rating` (int[]) - Filter by star ratings (1-5)
- `facilities` (string[]) - Filter by facilities (array overlap)
- `room_types` (string[]) - Filter by room types (array overlap)
- `min_price` (decimal) - Minimum price filter
- `max_price` (decimal) - Maximum price filter
- `latitude` (decimal) - Center latitude for geospatial search
- `longitude` (decimal) - Center longitude for geospatial search
- `radius_m` (decimal) - Radius in meters (max 15,000m)
- `search_query` (string) - Search in name/description
- `last_viewed_after` (datetime) - Filter trending hotels

**Response:** 200 OK
```json
{
  "data": [
    {
      "id": "hotel_...",
      "slug": "luxury-hotel-nashik",
      "name": "Luxury Hotel",
      "star_rating": 5,
      "location": {
        "latitude": "19.9975",
        "longitude": "73.7898"
      },
      ...
    }
  ],
  "pagination": {
    "limit": 20,
    "offset": 0,
    "total": 100
  }
}
```

#### 2. Get Hotel by ID
```
GET /v1/hotels/:id
```
**Response:** 200 OK

#### 3. Get Hotel by Slug
```
GET /v1/hotels/slug/:slug
```
**Response:** 200 OK

---

### Protected Endpoints (Authentication Required)

#### 4. Create Hotel
```
POST /v1/hotels
Authorization: Bearer <token>
```
**Request Body:**
```json
{
  "slug": "luxury-hotel-nashik",
  "name": "Luxury Hotel Nashik",
  "description": "5-star luxury experience",
  "star_rating": 5,
  "room_count": 100,
  "check_in_time": "14:00",
  "check_out_time": "11:00",
  "facilities": ["wifi", "parking", "pool", "gym", "spa"],
  "room_types": ["deluxe", "suite", "presidential"],
  "address": {
    "street": "123 Main St",
    "city": "Nashik",
    "state": "Maharashtra",
    "country": "India",
    "postal_code": "422001"
  },
  "location": {
    "latitude": "19.9975",
    "longitude": "73.7898"
  },
  "phone": "+91-253-1234567",
  "email": "info@luxuryhotel.com",
  "website": "https://luxuryhotel.com",
  "primary_image_url": "https://cdn.example.com/hotel.jpg",
  "thumbnail_url": "https://cdn.example.com/hotel-thumb.jpg",
  "price_min": 5000.00,
  "price_max": 50000.00,
  "currency": "INR"
}
```
**Response:** 201 Created

#### 5. Update Hotel
```
PUT /v1/hotels/:id
Authorization: Bearer <token>
```
**Request Body:** (All fields optional)
```json
{
  "name": "Updated Hotel Name",
  "star_rating": 5,
  "price_min": 6000.00
}
```
**Response:** 200 OK

#### 6. Delete Hotel
```
DELETE /v1/hotels/:id
Authorization: Bearer <token>
```
**Response:** 204 No Content

---

## File Structure

```
ent/
├── schema/
│   └── hotel.go                    # Ent schema definition
├── hotel.go                        # Generated entity
├── hotel_create.go                 # Generated create builder
├── hotel_update.go                 # Generated update builder
├── hotel_query.go                  # Generated query builder
└── hotel_delete.go                 # Generated delete builder

internal/
├── domain/
│   └── hotel/
│       ├── model.go                # Domain model
│       └── repository.go           # Repository interface
├── repository/
│   └── ent/
│       └── hotel.go                # Repository implementation
├── types/
│   ├── hotel.go                    # HotelFilter
│   └── uuid.go                     # UUID_PREFIX_HOTEL
├── api/
│   ├── dto/
│   │   └── hotel.go                # Request/Response DTOs
│   ├── v1/
│   │   └── hotel.go                # HTTP handlers
│   └── router.go                   # Route registration
└── service/
    ├── hotel.go                    # Service implementation
    └── factory.go                  # ServiceParams.HotelRepo

cmd/server/main.go                  # DI container registration
docs/swagger/                       # Generated Swagger docs
```

---

## Database Schema

### Table: `hotels`

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | varchar(255) | PRIMARY KEY | Unique identifier |
| slug | text | UNIQUE with status | URL-friendly identifier |
| name | text | NOT NULL | Hotel name |
| description | text | nullable | Hotel description |
| star_rating | integer | DEFAULT 3 | Star rating (1-5) |
| room_count | integer | DEFAULT 0 | Number of rooms |
| check_in_time | varchar(10) | nullable | Check-in time (HH:MM) |
| check_out_time | varchar(10) | nullable | Check-out time (HH:MM) |
| facilities | text[] | nullable | Array of facilities |
| room_types | text[] | nullable | Array of room types |
| address | jsonb | nullable | Address object |
| latitude | decimal(10,8) | NOT NULL | Latitude coordinate |
| longitude | decimal(11,8) | NOT NULL | Longitude coordinate |
| phone | varchar(20) | nullable | Contact phone |
| email | varchar(255) | nullable | Contact email |
| website | text | nullable | Website URL |
| primary_image_url | text | nullable | Main image URL |
| thumbnail_url | text | nullable | Thumbnail URL |
| price_min | decimal(10,2) | nullable | Minimum price |
| price_max | decimal(10,2) | nullable | Maximum price |
| currency | varchar(3) | DEFAULT 'INR' | Currency code |
| view_count | integer | DEFAULT 0 | View counter |
| rating_avg | decimal(3,2) | DEFAULT 0.00 | Average rating |
| rating_count | integer | DEFAULT 0 | Number of ratings |
| last_viewed_at | timestamp | nullable | Last view timestamp |
| popularity_score | decimal(10,4) | DEFAULT 0.0000 | Calculated popularity |
| status | varchar(20) | DEFAULT 'published' | Status |
| created_at | timestamp | NOT NULL | Creation timestamp |
| updated_at | timestamp | NOT NULL | Update timestamp |
| created_by | varchar(255) | nullable | Creator user ID |
| updated_by | varchar(255) | nullable | Updater user ID |
| metadata | jsonb | nullable | Additional metadata |

**Indexes:**
- Primary key: `id`
- Unique: `(slug, status)`
- Geospatial: `(latitude, longitude)`
- Filter: `facilities`, `(price_min, price_max)`, `star_rating`, `view_count`, `rating_avg`, `popularity_score`
- Composite: `(popularity_score, star_rating)`

---

## Common Use Cases

### 1. Find Hotels Near Location (within 5km)
```
GET /v1/hotels?latitude=19.9975&longitude=73.7898&radius_m=5000
```

### 2. Filter by Star Rating and Price
```
GET /v1/hotels?star_rating=4&star_rating=5&min_price=3000&max_price=10000
```

### 3. Search by Name
```
GET /v1/hotels?search_query=luxury
```

### 4. Filter by Facilities
```
GET /v1/hotels?facilities=wifi&facilities=pool&facilities=parking
```

### 5. Get Trending Hotels (viewed in last 7 days)
```
GET /v1/hotels?last_viewed_after=2025-11-08T00:00:00Z&sort=view_count&order=desc
```

### 6. Paginated List
```
GET /v1/hotels?limit=20&offset=40&sort=name&order=asc
```

---

## Validation Rules

### CreateHotelRequest
- `slug`: Required, min 1 character
- `name`: Required, min 1 character
- `star_rating`: Required, 1-5
- `location`: Required, valid coordinates
- `email`: Optional, valid email format
- `website`: Optional, valid URL
- `primary_image_url`: Optional, valid URL
- `thumbnail_url`: Optional, valid URL
- `price_min`: Optional, must be <= price_max if both provided

### HotelFilter
- `star_rating`: Array of integers 1-5
- `latitude`: -90 to 90
- `longitude`: -180 to 180
- `radius_m`: Max 15,000 meters (15km)
- `min_price`: Must be <= max_price if both provided

---

## Error Responses

### 400 Bad Request
```json
{
  "error": "Validation error",
  "hint": "Please check the request payload",
  "details": "star_rating must be between 1 and 5"
}
```

### 404 Not Found
```json
{
  "error": "Hotel not found",
  "hint": "The requested hotel does not exist"
}
```

### 409 Conflict
```json
{
  "error": "Hotel already exists",
  "hint": "A hotel with this slug already exists"
}
```

### 500 Internal Server Error
```json
{
  "error": "Internal server error",
  "hint": "An unexpected error occurred"
}
```

---

## Development Commands

```bash
# Generate Ent code
make generate-ent

# Run migrations
make migrate-ent

# Generate Swagger docs
make swagger

# Build application
go build -o bin/server ./cmd/server/main.go

# Run tests
go test ./...

# Run application
./bin/server
```

---

## Swagger Documentation

Access Swagger UI at:
```
http://localhost:8080/swagger/index.html
```

Download OpenAPI specs:
- Swagger 2.0: `/docs/swagger/swagger.json`
- OpenAPI 3.0: `/docs/swagger/swagger-3-0.json`

---

## Notes

- All timestamps are in UTC
- Geospatial queries use Haversine distance calculation
- Array filters use PostgreSQL array overlap operator
- Soft delete supported via status field
- Popularity score calculated from: `(view_count * 0.3) + (rating_avg * rating_count * 0.5) + (star_rating * 10)`

