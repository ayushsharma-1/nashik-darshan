# nashik_darshan_sdk

Official Dart SDK for the Nashik Darshan API - A comprehensive tourism and travel discovery platform for Nashik city.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  nashik_darshan_sdk: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Requirements

- Dart SDK >= 2.18.0

## Quick Start

### Basic Setup

```dart
import 'package:nashik_darshan_sdk/openapi.dart';

// Initialize the SDK
final openapi = Openapi(
  basePathOverride: 'https://api.nashikdarshan.com/api/v1', // Your API base URL
);

// Access API clients
final authApi = openapi.getAuthApi();
final placeApi = openapi.getPlaceApi();
```

### Authentication

The SDK supports Bearer token authentication. Configure authentication when initializing:

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:dio/dio.dart';

final dio = Dio();
dio.options.headers['Authorization'] = 'Bearer your-access-token-here';

final openapi = Openapi(
  basePathOverride: 'https://api.nashikdarshan.com/api/v1',
  dio: dio,
);
```

### Example: User Signup

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:nashik_darshan_sdk/api/auth_api.dart';

final openapi = Openapi(
  basePathOverride: 'https://api.nashikdarshan.com/api/v1',
);

final authApi = openapi.getAuthApi();

final signupRequest = DtoSignupRequest((b) => b
  ..name = 'John Doe'
  ..email = 'john@example.com'
  ..phone = '+1234567890'
  ..accessToken = 'your-oauth-access-token', // From OAuth provider
);

try {
  final response = await authApi.authSignupPost(signupRequest);
  print('User ID: ${response.data.id}');
  print('Access Token: ${response.data.accessToken}');
} catch (e) {
  print('Signup failed: $e');
}
```

### Example: Get Places

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:nashik_darshan_sdk/api/place_api.dart';

final openapi = Openapi(
  basePathOverride: 'https://api.nashikdarshan.com/api/v1',
);

final placeApi = openapi.getPlaceApi();

try {
  // Get places with pagination
  final response = await placeApi.placesGet(
    limit: 10,
    offset: 0,
    status: 'published',
  );
  
  print('Total places: ${response.data.pagination?.total}');
  response.data.items?.forEach((place) {
    print('${place.title} - ${place.placeType}');
  });
} catch (e) {
  print('Failed to fetch places: $e');
}
```

### Example: Search Places

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:nashik_darshan_sdk/api/place_api.dart';

final openapi = Openapi(
  basePathOverride: 'https://api.nashikdarshan.com/api/v1',
);

final placeApi = openapi.getPlaceApi();

try {
  // Search with filters
  final response = await placeApi.placesGet(
    searchQuery: 'hotel',
    placeTypes: ['hotel'],
    minRating: 4.0,
    limit: 20,
  );
  
  response.data.items?.forEach((place) {
    print('${place.title} - Rating: ${place.ratingAvg}/5');
  });
} catch (e) {
  print('Search failed: $e');
}
```

### Example: Get Feed Data

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:nashik_darshan_sdk/api/feed_api.dart';

final openapi = Openapi(
  basePathOverride: 'https://api.nashikdarshan.com/api/v1',
);

final feedApi = openapi.getFeedApi();

final feedRequest = DtoFeedRequest((b) => b
  ..sections = [
    DtoFeedSectionRequest((b) => b
      ..type = TypesFeedSectionType.sectionTypeTrending
      ..limit = 10,
    ),
    DtoFeedSectionRequest((b) => b
      ..type = TypesFeedSectionType.sectionTypePopular
      ..limit = 10,
    ),
    DtoFeedSectionRequest((b) => b
      ..type = TypesFeedSectionType.sectionTypeNearby
      ..latitude = 19.9975
      ..longitude = 73.7898
      ..radiusKm = 5.0
      ..limit = 10,
    ),
  ],
);

try {
  final response = await feedApi.feedPost(feedRequest);
  
  response.data.sections?.forEach((section) {
    print('Section: ${section.type}');
    section.items?.forEach((item) {
      print('  - ${item.title}');
    });
  });
} catch (e) {
  print('Failed to fetch feed: $e');
}
```

## API Clients

The SDK provides the following API clients:

- **AuthApi** - User authentication and signup
- **CategoryApi** - Category management
- **FeedApi** - Feed data (trending, popular, latest, nearby)
- **PlaceApi** - Places, hotels, restaurants, attractions
- **ReviewsApi** - Reviews and ratings
- **UserApi** - User profile management

## Configuration Options

```dart
Openapi({
  Dio? dio,                    // Custom Dio instance
  Serializers? serializers,    // Custom serializers
  String? basePathOverride,    // Override base URL
  List<Interceptor>? interceptors, // Custom interceptors
})
```

## Error Handling

All API calls can throw exceptions. Handle them appropriately:

```dart
import 'package:dio/dio.dart';

try {
  final response = await placeApi.placesIdGet('place-id');
  // Handle success
} on DioException catch (e) {
  if (e.response != null) {
    // Server responded with error
    print('API Error: ${e.response?.statusCode}');
    print('Error data: ${e.response?.data}');
  } else if (e.requestOptions != null) {
    // Request made but no response
    print('Network Error: ${e.message}');
  } else {
    // Something else happened
    print('Error: ${e.message}');
  }
} catch (e) {
  print('Unexpected error: $e');
}
```

## Type Safety

The SDK uses `built_value` for type-safe serialization. All types are strongly typed and immutable:

```dart
import 'package:nashik_darshan_sdk/model/dto_place_response.dart';
import 'package:nashik_darshan_sdk/model/types_status.dart';

final place = DtoPlaceResponse((b) => b
  ..id = 'place-id'
  ..title = 'Example Place'
  ..status = TypesStatus.statusPublished,
);
```

## Environment Variables

For production, configure the API base URL via environment variables:

```dart
import 'dart:io';

final apiUrl = Platform.environment['NASHIK_DARSHAN_API_URL'] ?? 
               'https://api.nashikdarshan.com/api/v1';

final openapi = Openapi(
  basePathOverride: apiUrl,
);
```

## License

This SDK is proprietary software. See [LICENSE](./LICENSE) for details.

- **Personal and non-commercial use**: Permitted
- **Commercial use**: Requires explicit permission from Caygnus
- Contact: support@caygnus.com for commercial licensing

## Support

- **Documentation**: [GitHub Repository](https://github.com/Caygnus/nashik-darshan-v2)
- **API Docs**: Available at `/swagger/index.html` when server is running
- **Issues**: [GitHub Issues](https://github.com/Caygnus/nashik-darshan-v2/issues)
- **Email**: support@caygnus.com

## Version

Current version: See `pubspec.yaml` or run:

```bash
dart pub deps | grep nashik_darshan_sdk
```

## Contributing

This SDK is auto-generated from the OpenAPI specification. To contribute:

1. Make changes to the API specification
2. Regenerate the SDK using the project's Makefile
3. Submit a pull request with your changes

For more information, see the [main repository](https://github.com/Caygnus/nashik-darshan-v2).
