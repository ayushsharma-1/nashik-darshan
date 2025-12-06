# Changelog

All notable changes to this project will be documented in this file.

## 1.0.2

### Fixed

- Fixed SDK generation scripts to handle paths with spaces in directory names
- Improved SDK regeneration process reliability
- Updated generated SDKs to match latest API specification

### Changed

- Regenerated SDKs from updated OpenAPI specification
- Enhanced error handling in generated code

## 1.0.1

### Added

- Event management endpoints:
  - Create, read, update, and delete events
  - Get events by ID or slug
  - List events with filtering and pagination
- Event occurrence management:
  - Create, read, update, and delete event occurrences
  - List occurrences for a specific event
- Hotel management endpoints:
  - Create, read, update, and delete hotels
  - Get hotels by ID or slug
  - List hotels with filtering and pagination
- Additional place features:
  - Place image management (create, update, delete)
  - View count tracking for places
- Event interaction endpoints:
  - Mark events as interested
  - Track event views
- Enhanced feed API with support for multiple section types

### Changed

- Updated API models to include new event and hotel entities
- Improved type definitions for better type safety

## 1.0.0

- Initial release of Nashik Darshan SDK for Dart
- Support for all API endpoints:
  - Authentication (signup, login)
  - Places management (list, search, get by ID)
  - Categories management
  - Feed data (trending, popular, latest, nearby)
  - Reviews and ratings
  - User profile management
- Custom Dio instance support with interceptors
- Comprehensive documentation with examples
- Integration guide for Freezed, Clean Architecture, Bloc, and Cubits
- Type-safe models using built_value
- Full error handling support
- Built with OpenAPI Generator
- Uses Dio for HTTP requests
- Compatible with Dart SDK >= 2.18.0
