# Nashik Darshan v2 Backend

A modern, scalable tourism and travel discovery platform backend for Nashik city, built with Go and clean architecture principles.

## 📋 Table of Contents

- [About](#about)
- [Technology Stack](#technology-stack)
- [Core Features](#core-features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [API Documentation](#api-documentation)
- [Development Workflow](#development-workflow)
- [Deployment](#deployment)
- [Future Scope](#future-scope)
- [Project Structure](#project-structure)
- [Best Practices](#best-practices)
- [Contributing](#contributing)

## About

**Nashik Darshan v2** is a comprehensive backend service for a tourism and travel discovery platform focused on Nashik city. It serves as the foundation for helping local tourists, international travelers, and travel businesses discover, explore, and review places of interest including hotels, restaurants, attractions, apartments, and unique experiences.

### Target Audience

- **Local Tourists**: Residents and nearby visitors exploring Nashik
- **International Tourists**: Travelers from around the world discovering Nashik
- **Travel Businesses**: Hotels, restaurants, and experience providers
- **Tour Operators**: Travel agencies and tour management companies

### Key Value Propositions

- **Smart Place Discovery**: Advanced filtering and search capabilities
- **Geospatial Search**: Location-based queries with radius filtering
- **Community Reviews**: User-generated ratings and reviews with images
- **Intelligent Feed System**: Personalized content sections (Latest, Trending, Popular, Nearby)
- **Engagement Analytics**: View tracking and popularity scoring

## Technology Stack

### Core Technologies

- **Language**: Go 1.24
- **Web Framework**: Gin (High-performance HTTP router)
- **Database**: PostgreSQL 14+
- **ORM**: Ent (Facebook's Entity Framework)
- **Authentication**: Supabase Auth

### Architecture & Design

- **Architecture Pattern**: Clean Architecture with Domain-Driven Design (DDD)
- **Dependency Injection**: Uber Fx
- **Logging**: Uber Zap (Structured logging)
- **Validation**: Go Playground Validator
- **API Documentation**: Swagger/OpenAPI 3.0

### Additional Libraries

- **Decimal Handling**: shopspring/decimal (precise financial calculations)
- **Error Handling**: cockroachdb/errors (enhanced error context)
- **ID Generation**: ULID (Universally Unique Lexicographically Sortable Identifier)

## Core Features

### 🏛️ Places Management

- Support for multiple place types: Hotels, Restaurants, Attractions, Apartments, Experiences
- Comprehensive place information: title, descriptions, addresses, coordinates
- Primary and thumbnail images
- Amenities tracking
- Slug-based URLs for SEO

### 🏷️ Categories & Filtering

- Multi-category support per place
- Advanced filtering capabilities:
  - By place type
  - By categories
  - By amenities
  - By status (active/inactive)
  - Time range filters
  - Search queries

### 📍 Geospatial Search

- Location-based place discovery
- Radius filtering (up to 15km)
- Coordinate validation
- Bounding box queries
- Nearby places recommendation

### ⭐ Review System

- Generic review system for any entity type
- Star ratings (1.0 to 5.0)
- Review titles and content
- Image attachments support
- Review tags (family-friendly, romantic, budget, etc.)
- Helpful/Not helpful voting
- Verified review badges
- Featured review highlighting

### 📱 Feed System

Multiple feed sections for content discovery:

- **Latest**: Recently added places
- **Trending**: Places with recent high engagement (48-hour lookback)
- **Popular**: Highest-rated and most-viewed places
- **Nearby**: Geographically close places

### 👥 User Management

- Supabase-based authentication
- Role-based access control (User, Admin)
- User profiles with email and phone
- Secure JWT token validation

### 🖼️ Image Management

- Multiple images per place
- Image ordering and positioning
- Alt text support
- Image captions
- Primary image designation

### 📊 Engagement Tracking

- View count tracking
- Popularity score calculation
- Last viewed timestamp
- Rating aggregation (average and count)
- Automated trending detection

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns across multiple layers:

### Layer Overview

```
┌─────────────────────────────────────┐
│         API Layer (HTTP)            │
│    (Handlers, Middleware, DTOs)     │
├─────────────────────────────────────┤
│         Service Layer               │
│      (Business Logic)               │
├─────────────────────────────────────┤
│         Domain Layer                │
│   (Models, Interfaces)              │
├─────────────────────────────────────┤
│       Repository Layer              │
│      (Data Access)                  │
├─────────────────────────────────────┤
│       Database (PostgreSQL)         │
└─────────────────────────────────────┘
```

### Key Architectural Components

#### 1. Domain Layer (`internal/domain/`)

- Contains business models and interfaces
- Defines repository interfaces
- Platform-agnostic business rules
- Entity definitions

#### 2. Repository Layer (`internal/repository/`)

- Implements domain repository interfaces
- Uses Ent ORM for data access
- Handles database queries and transactions
- Query option builders

#### 3. Service Layer (`internal/service/`)

- Implements business logic
- Orchestrates between repositories
- Handles complex operations
- Error handling and logging

#### 4. API Layer (`internal/api/`)

- HTTP request handlers (`v1/`)
- Request/Response DTOs (`dto/`)
- Middleware (auth, CORS, error handling)
- Input validation

#### 5. Types System (`internal/types/`)

- Shared type definitions
- Filter structures
- Pagination types
- Common utilities

#### 6. Error Handling (`internal/errors/`)

- Structured error building
- Error categorization
- HTTP status code mapping
- User-friendly error messages

### Ent Schema Approach

Database schema is defined using Ent's code-first approach in `ent/schema/`:

- Type-safe schema definitions
- Automatic migration generation
- Index optimization
- Edge (relationship) definitions

## Getting Started

### Prerequisites

- **Go**: 1.24 or higher
- **PostgreSQL**: 14 or higher
- **Supabase Account**: For authentication (free tier available)
- **Git**: For version control

### Installation Steps

#### 1. Clone the Repository

```bash
git clone https://github.com/Caygnus/nashik-darshan-v2.git
cd nashik-darshan-v2
```

#### 2. Install Dependencies

```bash
go mod download
```

#### 3. Setup Configuration

See the [Configuration](#configuration) section below for detailed setup instructions.

Quick start: Create a `config.yaml` file (see `CONFIG.md` for complete guide):

```yaml
server:
  address: ":8080"

logging:
  level: "debug"

postgres:
  host: "localhost"
  port: 5432
  user: "your_username"
  password: "your_password"
  dbname: "nashik_darshan"
  sslmode: "disable"
  auto_migrate: true

supabase:
  url: "https://your-project.supabase.co"
  key: "your-supabase-anon-key"
  jwt_secret: "your-jwt-secret"
```

#### 4. Generate Cryptographic Keys

For development:

```bash
make generate-dev-keys
```

For production:

```bash
make generate-keys
```

#### 5. Generate Ent Code

```bash
make generate-ent
```

#### 6. Run Database Migrations

```bash
make migrate-ent
```

#### 7. Generate API Documentation

```bash
make swagger
```

#### 8. Start Development Server

```bash
make run
```

The server will start on `http://localhost:8080` (or your configured address).

### Verify Installation

Test the health endpoint:

```bash
curl http://localhost:8080/api/v1/health
```

Expected response:

```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## Configuration

This application supports multiple configuration methods with the following priority:

1. **Environment Variables** (highest priority)
2. **Config YAML file** (`config.yaml`)
3. **`.env` file**
4. **Key files** in `./keys/` folder (lowest priority)

### Required Configuration

- **Server**: Address and port
- **Logging**: Log level
- **PostgreSQL**: Database connection details
- **Supabase**: Authentication configuration
- **Secrets**: Private and public keys for cryptography

### Configuration Methods

#### Method 1: YAML File (Recommended for Development)

Create `config.yaml` in the project root or `internal/config/` directory.

See the [Getting Started](#getting-started) section for a minimal example.

#### Method 2: Environment Variables

All configuration values can be set via environment variables with the `CAYGNUS_` prefix:

```bash
export CAYGNUS_SERVER_ADDRESS=":8080"
export CAYGNUS_POSTGRES_HOST="localhost"
export CAYGNUS_POSTGRES_PORT=5432
# ... etc
```

#### Method 3: .env File

Create a `.env` file in the project root with `CAYGNUS_` prefixed variables.

#### Method 4: Key Files

Place RSA key files in the `./keys/` directory:

- `private_key.pem` - Private key
- `public_key.pem` - Public key

### Detailed Configuration Guide

For comprehensive configuration documentation, including all available options, validation rules, and security best practices, see **[CONFIG.md](./CONFIG.md)**.

## API Documentation

### Swagger UI

Once the server is running, access the interactive API documentation:

```
http://localhost:8080/swagger/index.html
```

### OpenAPI Specification

The project supports both Swagger 2.0 and OpenAPI 3.0 specifications:

- **Swagger 2.0**: `docs/swagger/swagger.json`
- **OpenAPI 3.0**: `docs/swagger/swagger-3-0.json`
- **YAML Format**: `docs/swagger/swagger.yaml`

### API Versioning

All API endpoints are versioned under `/api/v1/`:

- `/api/v1/health` - Health check
- `/api/v1/places` - Places management
- `/api/v1/categories` - Categories
- `/api/v1/reviews` - Reviews
- `/api/v1/feed` - Feed system
- `/api/v1/users` - User management
- `/api/v1/auth` - Authentication

### Regenerating Documentation

```bash
make swagger
```

This command:

1. Generates Swagger 2.0 documentation
2. Converts to OpenAPI 3.0
3. Fixes any reference issues

## Development Workflow

### Available Make Commands

```bash
# Code Generation
make generate-ent          # Generate Ent ORM code from schema
make swagger              # Generate API documentation

# Database
make migrate-ent          # Run database migrations

# Development
make run                  # Start development server
make build                # Build production binary

# Code Quality
make lint-fix             # Auto-fix linting issues
make install-hooks        # Install git pre-commit hooks
make run-hooks            # Manually run git hooks

# Security
make generate-dev-keys    # Generate unencrypted RSA keys (dev only)
make generate-keys        # Generate encrypted RSA keys (production)
```

### Development Process

#### 1. Install Git Hooks

```bash
make install-hooks
```

This ensures code quality checks run before commits.

#### 2. Schema Changes

When modifying Ent schemas in `ent/schema/`:

```bash
make generate-ent         # Generate code
make migrate-ent          # Apply migrations
```

#### 3. API Changes

After modifying API handlers or DTOs:

```bash
make swagger              # Update documentation
```

#### 4. Code Quality

Before committing:

```bash
make lint-fix             # Auto-fix issues
make run-hooks            # Verify all checks pass
```

### Adding New Features

#### Step 1: Define Domain Model

Create schema in `ent/schema/`:

```go
// ent/schema/feature.go
package schema

import (
    "entgo.io/ent"
    "entgo.io/ent/schema/field"
)

type Feature struct {
    ent.Schema
}

func (Feature) Fields() []ent.Field {
    return []ent.Field{
        field.String("id"),
        field.String("name"),
    }
}
```

#### Step 2: Generate Code

```bash
make generate-ent
```

#### Step 3: Create Domain Interface

In `internal/domain/feature/`:

```go
// repository.go
type Repository interface {
    Create(ctx context.Context, f *Feature) error
    Get(ctx context.Context, id string) (*Feature, error)
    // ... other methods
}
```

#### Step 4: Implement Repository

In `internal/repository/ent/`:

```go
// feature.go
type featureRepository struct {
    client *ent.Client
}

func (r *featureRepository) Create(ctx context.Context, f *feature.Feature) error {
    // Implementation
}
```

#### Step 5: Create Service

In `internal/service/`:

```go
// feature.go
type FeatureService interface {
    Create(ctx context.Context, req *dto.CreateFeatureRequest) (*dto.FeatureResponse, error)
}
```

#### Step 6: Create API Handler

In `internal/api/v1/`:

```go
// feature.go
// @Summary Create feature
// @Router /api/v1/features [post]
func (h *FeatureHandler) Create(c *gin.Context) {
    // Implementation
}
```

#### Step 7: Register Routes

In `internal/api/router.go`, add routes to the router setup.

#### Step 8: Update Documentation

```bash
make swagger
```

## Deployment

### Deployment Options

#### Option 1: Render (Platform-as-a-Service)

**Render** provides easy deployment with automatic SSL and scaling.

##### Steps:

1. **Create PostgreSQL Database**

   - Go to Render Dashboard → New → PostgreSQL
   - Note the internal database URL

2. **Create Web Service**

   - Go to Render Dashboard → New → Web Service
   - Connect your GitHub repository
   - Configure:
     - **Build Command**: `go build -o server cmd/server/main.go`
     - **Start Command**: `./server`
     - **Environment**: Add all required `CAYGNUS_*` variables

3. **Environment Variables**

   ```
   CAYGNUS_SERVER_ADDRESS=:10000
   CAYGNUS_POSTGRES_HOST=<from-render-db>
   CAYGNUS_POSTGRES_PORT=5432
   CAYGNUS_POSTGRES_USER=<from-render-db>
   CAYGNUS_POSTGRES_PASSWORD=<from-render-db>
   CAYGNUS_POSTGRES_DBNAME=<from-render-db>
   CAYGNUS_POSTGRES_SSLMODE=require
   CAYGNUS_POSTGRES_AUTO_MIGRATE=true
   CAYGNUS_SUPABASE_URL=<your-supabase-url>
   CAYGNUS_SUPABASE_KEY=<your-supabase-key>
   CAYGNUS_SUPABASE_JWT_SECRET=<your-jwt-secret>
   CAYGNUS_SECRETS_PRIVATE_KEY=<your-private-key>
   CAYGNUS_SECRETS_PUBLIC_KEY=<your-public-key>
   CAYGNUS_LOGGING_LEVEL=info
   ```

4. **Deploy**
   - Render will automatically build and deploy
   - Access your API at `https://your-app.onrender.com`

##### Health Check

Configure health check in Render:

- **Path**: `/api/v1/health`
- **Expected Status**: 200

#### Option 2: VPS Setup (Self-Hosted)

Deploy on a Virtual Private Server (DigitalOcean, Linode, AWS EC2, etc.)

##### Prerequisites:

- Ubuntu 20.04+ (or similar Linux distribution)
- Root or sudo access
- Domain name (optional, for SSL)

##### Steps:

1. **Install Dependencies**

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Go
wget https://go.dev/dl/go1.24.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib -y
```

2. **Setup PostgreSQL**

```bash
sudo -u postgres psql

# In PostgreSQL prompt:
CREATE DATABASE nashik_darshan;
CREATE USER your_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE nashik_darshan TO your_user;
\q
```

3. **Clone and Build Application**

```bash
cd /opt
sudo git clone https://github.com/omkar273/nashikdarshan.git
cd nashik-darshan-v2-be
sudo go mod download
make generate-ent
make build
```

4. **Create Configuration**

```bash
sudo nano config.yaml
# Add your configuration (see Configuration section)
```

5. **Create Systemd Service**

```bash
sudo nano /etc/systemd/system/nashik-darshan.service
```

Content:

```ini
[Unit]
Description=Nashik Darshan v2 Backend
After=network.target postgresql.service

[Service]
Type=simple
User=www-data
WorkingDirectory=/opt/nashik-darshan-v2-be
ExecStart=/opt/nashik-darshan-v2-be/server
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

6. **Start Service**

```bash
sudo systemctl daemon-reload
sudo systemctl enable nashik-darshan
sudo systemctl start nashik-darshan
sudo systemctl status nashik-darshan
```

7. **Setup Nginx (Reverse Proxy)**

```bash
sudo apt install nginx -y
sudo nano /etc/nginx/sites-available/nashik-darshan
```

Content:

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/nashik-darshan /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

8. **Setup SSL with Let's Encrypt**

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d your-domain.com
```

### Database Migrations

On first deployment, ensure `CAYGNUS_POSTGRES_AUTO_MIGRATE=true` is set, or run migrations manually:

```bash
make migrate-ent
```

### Monitoring

Monitor application logs:

**Render**: View logs in the Render dashboard

**VPS**: View systemd logs

```bash
sudo journalctl -u nashik-darshan -f
```

## Future Scope

The following features and enhancements are planned for future releases:

### Phase 1: Core Enhancements

#### 🎫 Booking Integration

- Hotel room booking system
- Experience reservation management
- Table reservations for restaurants
- Booking confirmation and management
- Calendar availability system

#### 💳 Payment Gateway

- Integrated payment processing
- Multiple payment methods (cards, UPI, wallets)
- Secure transaction handling
- Payment history and receipts
- Refund management

#### 🌐 Multi-language Support

- Internationalization (i18n) framework
- Support for multiple languages (English, Hindi, Marathi)
- Localized content management
- RTL language support
- Currency localization

### Phase 2: Intelligence & Personalization

#### 🤖 AI Recommendations

- Machine learning-based place suggestions
- Personalized recommendations based on user behavior
- Collaborative filtering
- Content-based recommendations
- Trending prediction algorithms

#### 📊 Advanced Analytics

- Visitor insights and demographics
- Heatmap visualization
- Traffic pattern analysis
- Conversion tracking
- Business intelligence dashboards

#### 🎯 Smart Notifications

- Push notification system
- Personalized alerts
- Geofencing notifications
- Event reminders
- Price drop alerts

### Phase 3: Immersive Experiences

#### 🥽 AR/VR Tours

- Augmented reality place previews
- Virtual reality tours
- 360° panoramic views
- Interactive experiences
- Virtual walk-throughs

#### 📱 Mobile SDK

- Native mobile app integration
- iOS and Android SDKs
- Offline mode support
- Real-time synchronization
- Native performance optimization

### Phase 4: Social & Community

#### 👥 Social Features

- User follow system
- Social sharing
- Saved places and favorites
- Travel itinerary planning
- Collaborative trip planning
- Activity feeds
- User badges and achievements

#### 💬 Community Engagement

- Discussion forums
- Q&A system
- Travel tips and guides
- User-generated content
- Community moderation tools

### Phase 5: Business Tools

#### 📈 Business Dashboard

- Analytics portal for travel operators
- Revenue tracking
- Customer insights
- Performance metrics
- Booking management
- Inventory management

#### 🎪 Event Management

- Festival and event listings
- Event calendar
- Ticket booking integration
- Event notifications
- Special event promotions
- Cultural event coverage for Nashik

#### 🏢 Vendor Portal

- Self-service business registration
- Content management for businesses
- Review response system
- Analytics and reporting
- Promotional tools

### Phase 6: Advanced Features

#### 🗺️ Enhanced Geospatial

- Route planning and optimization
- Multi-stop itinerary planning
- Real-time traffic integration
- Public transport integration
- Distance and time calculations

#### 🔍 Advanced Search

- Natural language search
- Voice search capability
- Image-based search
- Filters by price range, ratings, distance
- Search result ranking optimization

#### ⚡ Performance & Scale

- CDN integration for media
- Redis caching layer
- GraphQL API support
- WebSocket for real-time features
- Microservices architecture migration

#### 🔐 Security Enhancements

- Two-factor authentication (2FA)
- OAuth provider integrations
- Advanced fraud detection
- GDPR compliance tools
- Data encryption at rest

## Project Structure

```
nashik-darshan-v2-be/
├── cmd/                          # Application entry points
│   ├── server/                   # Main HTTP server
│   │   └── main.go
│   └── migrate/                  # Database migration utility
│       └── main.go
│
├── ent/                          # Ent ORM (generated & schemas)
│   ├── schema/                   # Database schema definitions
│   │   ├── place.go             # Place entity schema
│   │   ├── place_image.go       # Place image schema
│   │   ├── category.go          # Category schema
│   │   ├── review.go            # Review schema
│   │   └── user.go              # User schema
│   ├── migrate/                  # Migration files
│   ├── mixin/                    # Reusable schema mixins
│   │   ├── base.go              # Base fields (ID, status, timestamps)
│   │   └── metadata.go          # Metadata fields
│   └── [generated files]         # Auto-generated Ent code
│
├── internal/                     # Private application code
│   ├── api/                      # HTTP layer
│   │   ├── dto/                  # Data Transfer Objects
│   │   │   ├── auth.go
│   │   │   ├── place.go
│   │   │   ├── review.go
│   │   │   ├── feed.go
│   │   │   ├── category.go
│   │   │   └── user.go
│   │   ├── v1/                   # API version 1 handlers
│   │   │   ├── place.go
│   │   │   ├── review.go
│   │   │   ├── feed.go
│   │   │   ├── category.go
│   │   │   ├── user.go
│   │   │   ├── auth.go
│   │   │   └── health.go
│   │   └── router.go             # Route definitions
│   │
│   ├── auth/                     # Authentication providers
│   │   ├── provider.go           # Auth provider interface
│   │   └── supabase.go           # Supabase implementation
│   │
│   ├── config/                   # Configuration management
│   │   ├── config.go             # Config loader
│   │   └── config.yaml           # Default config template
│   │
│   ├── domain/                   # Domain layer (business models)
│   │   ├── place/
│   │   │   ├── model.go          # Place domain model
│   │   │   └── repository.go     # Place repository interface
│   │   ├── review/
│   │   │   ├── model.go
│   │   │   └── repository.go
│   │   ├── category/
│   │   │   ├── model.go
│   │   │   └── repository.go
│   │   └── user/
│   │       ├── model.go
│   │       └── repository.go
│   │
│   ├── errors/                   # Error handling system
│   │   ├── errors.go             # Error types
│   │   ├── builder.go            # Error builder
│   │   └── dto.go                # Error DTOs
│   │
│   ├── logger/                   # Logging configuration
│   │   └── logger.go             # Zap logger setup
│   │
│   ├── postgres/                 # PostgreSQL client
│   │   └── client.go             # Database connection
│   │
│   ├── repository/               # Repository implementations
│   │   ├── ent/                  # Ent-based repositories
│   │   │   ├── place.go
│   │   │   ├── review.go
│   │   │   ├── category.go
│   │   │   ├── user.go
│   │   │   └── queryoptions.go   # Query builders
│   │   └── factory.go            # Repository factory
│   │
│   ├── rest/                     # REST utilities
│   │   └── middleware/           # HTTP middleware
│   │       ├── auth.go           # Authentication middleware
│   │       ├── cors.go           # CORS middleware
│   │       ├── errhandler.go     # Error handling middleware
│   │       └── request.go        # Request processing
│   │
│   ├── security/                 # Security utilities
│   │   └── encryption.go         # Cryptographic operations
│   │
│   ├── service/                  # Service layer (business logic)
│   │   ├── place.go              # Place service
│   │   ├── review.go             # Review service
│   │   ├── feed.go               # Feed service
│   │   ├── category.go           # Category service
│   │   ├── user.go               # User service
│   │   ├── auth.go               # Auth service
│   │   ├── onboarding.go         # Onboarding service
│   │   └── factory.go            # Service factory
│   │
│   ├── types/                    # Shared type definitions
│   │   ├── place.go              # Place types & filters
│   │   ├── review.go             # Review types
│   │   ├── feed.go               # Feed types
│   │   ├── category.go           # Category types
│   │   ├── user.go               # User types
│   │   ├── filter.go             # Base filter types
│   │   ├── pagination.go         # Pagination types
│   │   ├── location.go           # Geospatial types
│   │   ├── status.go             # Status enums
│   │   ├── uuid.go               # ULID utilities
│   │   └── [other types]
│   │
│   └── validator/                # Request validation
│       └── validator.go          # Validator setup
│
├── docs/                         # Documentation
│   ├── swagger/                  # API documentation
│   │   ├── docs.go              # Generated Swagger docs
│   │   ├── swagger.json         # Swagger 2.0 spec
│   │   ├── swagger-3-0.json     # OpenAPI 3.0 spec
│   │   └── swagger.yaml         # YAML spec
│   └── GEOGRAPHY_COMPARISON.md   # Technical documentation
│
├── scripts/                      # Utility scripts
│   ├── generate-keys.sh          # Production key generation
│   ├── generate-dev-keys.sh      # Development key generation
│   ├── fix_swagger_refs.sh       # Swagger post-processing
│   ├── internal/
│   │   └── generate_ent.go       # Ent code generation
│   └── main.go                   # Script runner
│
├── keys/                         # Cryptographic keys (gitignored)
│   ├── private_key.pem
│   └── public_key.pem
│
├── .gitignore                    # Git ignore rules
├── go.mod                        # Go module definition
├── go.sum                        # Go dependencies lock
├── Makefile                      # Build automation
├── config.yaml                   # Application configuration
├── CONFIG.md                     # Configuration guide
└── README.md                     # This file
```

### Key Directory Responsibilities

- **`cmd/`**: Application entry points and executables
- **`ent/`**: Database schema and ORM code (Ent framework)
- **`internal/api/`**: HTTP handlers, routing, and DTOs
- **`internal/domain/`**: Core business logic and interfaces
- **`internal/repository/`**: Data access implementations
- **`internal/service/`**: Business logic orchestration
- **`internal/types/`**: Shared type definitions and utilities
- **`docs/`**: API documentation and specifications
- **`scripts/`**: Development and deployment utilities

## Best Practices

### Code Organization

1. **Package Naming**

   - Use short, lowercase package names
   - Avoid generic names like `util` or `common`
   - Name packages after what they provide, not what they contain

2. **Interface Placement**

   - Define interfaces in the package that uses them
   - Repository interfaces live in `internal/domain/`
   - Service interfaces live in `internal/service/`

3. **Dependency Flow**
   - API → Service → Repository → Database
   - Never skip layers
   - Dependencies flow inward (domain has no external dependencies)

### Error Handling

1. **Use Error Builder**

```go
import ierr "github.com/omkar273/nashikdarshan/internal/errors"

// Create detailed errors
return ierr.NewError("place not found").
    WithHint("Please check the place ID and try again").
    WithDetails(map[string]interface{}{"place_id": id}).
    Mark(ierr.ErrNotFound)
```

2. **Error Types**

   - `ErrValidation`: Invalid input
   - `ErrNotFound`: Resource not found
   - `ErrUnauthorized`: Authentication required
   - `ErrForbidden`: Permission denied
   - `ErrConflict`: Resource conflict
   - `ErrInternal`: Internal server error

3. **Context Propagation**
   - Always wrap errors with context
   - Use `errors.Wrap()` for additional context
   - Log errors at service layer

### ID Generation

Use ULID-based IDs with prefixes:

```go
// Automatic generation in Ent schema
field.String("id").
    DefaultFunc(func() string {
        return types.GenerateUUIDWithPrefix(types.UUID_PREFIX_PLACE)
    })

// Prefixes:
// place_xxx... - Places
// user_xxx... - Users
// review_xxx... - Reviews
// cat_xxx... - Categories
// img_xxx... - Images
```

### Status Field Usage

All entities have a status field for soft deletion:

```go
const (
    StatusActive   Status = "active"
    StatusInactive Status = "inactive"
    StatusDeleted  Status = "deleted"
)

// Querying active records
filter.Status = string(types.StatusActive)

// Soft delete
entity.Status = types.StatusDeleted
```

### Database Queries

1. **Use Query Options**

```go
// Build filters
filter := types.NewPlaceFilter()
filter.QueryFilter.Limit = &limit
filter.QueryFilter.Offset = &offset
filter.PlaceTypes = []string{"hotel", "restaurant"}

// Execute
places, err := repo.List(ctx, filter)
```

2. **Pagination**

   - Always include pagination for list endpoints
   - Default limit: 20
   - Maximum limit: 100

3. **Indexes**
   - Add indexes for frequently queried fields
   - Use composite indexes for multi-field queries
   - Indexes defined in Ent schemas

### Validation

1. **Request Validation**

```go
// In DTOs
type CreatePlaceRequest struct {
    Title string `json:"title" binding:"required,min=3,max=255"`
    Slug  string `json:"slug" binding:"required,slug"`
}

// Custom validation
func (r *CreatePlaceRequest) Validate() error {
    // Additional business logic validation
}
```

2. **Domain Validation**

```go
// In domain models
func (p *Place) Validate() error {
    if err := types.ValidateCoordinates(p.Latitude, p.Longitude); err != nil {
        return err
    }
    return nil
}
```

### Testing

1. **Unit Tests**

   - Test business logic in services
   - Mock repository dependencies
   - Use table-driven tests

2. **Integration Tests**

   - Test repository implementations
   - Use test database
   - Clean up test data

3. **API Tests**
   - Test HTTP handlers
   - Verify response formats
   - Check error handling

### Logging

Use structured logging with Zap:

```go
logger.Infow("place created",
    "place_id", place.ID,
    "user_id", userID,
)

logger.Errorw("failed to create place",
    "error", err,
    "user_id", userID,
)
```

### Security

1. **Authentication**

   - All protected endpoints require JWT token
   - Token validated via Supabase
   - User context extracted in middleware

2. **Input Sanitization**

   - Validate all inputs
   - Use parameterized queries (Ent handles this)
   - Escape HTML in user-generated content

3. **Secrets Management**
   - Never commit secrets to version control
   - Use environment variables in production
   - Rotate keys regularly

## Contributing

We welcome contributions! Please follow these guidelines:

### Getting Started

1. **Fork the Repository**

Go to the main repository and click "Fork" to create your own copy.

2. **Clone Your Fork**

```bash
git clone https://github.com/YOUR-USERNAME/nashik-darshan-v2.git
cd nashik-darshan-v2
```

3. **Add Upstream Remote**

Add the main repository as upstream to sync with the latest changes:

```bash
git remote add upstream https://github.com/Caygnus/nashik-darshan-v2.git
git remote -v  # Verify remotes
```

You should see:

```
origin    https://github.com/YOUR-USERNAME/nashik-darshan-v2.git (fetch)
origin    https://github.com/YOUR-USERNAME/nashik-darshan-v2.git (push)
upstream  https://github.com/Caygnus/nashik-darshan-v2.git (fetch)
upstream  https://github.com/Caygnus/nashik-darshan-v2.git (push)
```

4. **Sync with Upstream Dev Branch**

Before starting work, always sync with the latest dev branch:

```bash
git checkout dev
git fetch upstream
git rebase upstream/dev
git push origin dev
```

5. **Create a Feature Branch**

Always branch from `dev`:

```bash
git checkout dev
git checkout -b feature/your-feature-name
```

6. **Make Your Changes**

   - Follow the code organization principles
   - Write tests for new features
   - Update documentation

7. **Test Your Changes**

```bash
make lint-fix             # Fix linting issues
make generate-ent         # Regenerate Ent code if schemas changed
make swagger              # Update API docs if APIs changed
make run                  # Test locally
```

8. **Keep Your Branch Updated**

Regularly sync your feature branch with upstream dev:

```bash
git fetch upstream
git rebase upstream/dev
```

If conflicts occur, resolve them and continue:

```bash
# Resolve conflicts in your editor
git add .
git rebase --continue
```

9. **Commit Your Changes**

```bash
git add .
git commit -m "feat: add new feature description"
```

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `test:` Test additions/changes
- `chore:` Maintenance tasks

10. **Push to Your Fork**

```bash
git push origin feature/your-feature-name
```

If you rebased and need to force push:

```bash
git push origin feature/your-feature-name --force-with-lease
```

11. **Create Pull Request Against Dev Branch**

- Go to your fork on GitHub
- Click "Compare & pull request"
- **Important**: Set the base repository to `Caygnus/nashik-darshan-v2` and base branch to `dev`
- Set the compare branch to your feature branch
- Fill in the PR template with:
  - Clear description of changes
  - Related issue numbers (if any)
  - Screenshots (if UI changes)
  - Testing steps
- Submit the pull request

### Code Review Process

- All PRs require review before merging
- Address review comments promptly
- Keep PRs focused and reasonably sized
- Ensure all CI checks pass

### Reporting Issues

When reporting bugs, include:

- Go version
- PostgreSQL version
- Steps to reproduce
- Expected vs actual behavior
- Relevant logs or error messages

### Feature Requests

For feature requests:

- Check existing issues first
- Describe the use case
- Explain the expected behavior
- Consider implementation approach

## License

This project is proprietary software developed by Caygnus. All rights reserved.

## Support

For questions, issues, or support:

- **Email**: support@caygnus.com
- **Documentation**: See `CONFIG.md` for configuration help
- **API Docs**: `/swagger/index.html` when server is running

---

**Built with ❤️ for Nashik by the Caygnus Team**
