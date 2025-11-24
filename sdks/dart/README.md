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
// basePathOverride should be the FULL URL including protocol (http:// or https://)
final openapi = Openapi(
  basePathOverride: 'https://api.example.com/api/v1', // Full URL required
);

// Access API clients
// All API clients share the same Openapi instance and basePath
final authApi = openapi.getAuthApi();
final placeApi = openapi.getPlaceApi();
```

**Note about basePathOverride:**
- `basePathOverride` must be the **complete URL** including protocol (e.g., `https://api.example.com/api/v1`)
- You only need to set it **once** when creating the Openapi instance
- All API clients created from the same Openapi instance will use the same basePath
- If using a custom Dio instance with `baseUrl` set, you can omit `basePathOverride` (see Custom Dio section)

### Authentication

The SDK supports Bearer token authentication. Configure authentication when initializing:

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:dio/dio.dart';

final openapi = Openapi(
  basePathOverride: 'https://api.example.com/api/v1',
);

// Set Bearer token
openapi.setBearerAuth('default', 'your-access-token-here');

// Or use custom Dio with headers
final dio = Dio();
dio.options.headers['Authorization'] = 'Bearer your-access-token-here';

final openapiWithDio = Openapi(
  basePathOverride: 'https://api.example.com/api/v1',
  dio: dio,
);
```

### Using Custom Dio Instance

You can configure the SDK to use your own Dio instance with custom interceptors, default headers, or other configurations. This is useful when you want to share Dio configuration across your application.

#### Basic Custom Dio Setup

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:dio/dio.dart';

// Create your custom Dio instance
// If you set baseUrl in Dio, you don't need to set basePathOverride
final customDio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com/api/v1', // Full URL with protocol
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
  headers: {
    'Content-Type': 'application/json',
  },
));

// Add request interceptor (e.g., for authentication)
customDio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    // Add auth token from your auth system
    final token = getAuthToken(); // Your token retrieval logic
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  },
  onError: (error, handler) {
    if (error.response?.statusCode == 401) {
      // Handle unauthorized - redirect to login, refresh token, etc.
      print('Unauthorized - please login');
    }
    return handler.next(error);
  },
));

// Use custom Dio instance with SDK
// Since Dio has baseUrl set, basePathOverride is optional
final openapi = Openapi(
  dio: customDio,
  // basePathOverride not needed if dio.baseUrl is set
);

// All API clients will use the custom Dio instance
final authApi = openapi.getAuthApi();
final placeApi = openapi.getPlaceApi();
```

#### Using Global Dio Configuration

If you have a global Dio instance configured elsewhere in your application, you can reuse it:

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:dio/dio.dart';

// Your global Dio instance (configured elsewhere in your app)
// This might be in a separate file like: lib/api/dio_client.dart
final globalDio = Dio(BaseOptions(
  baseUrl: const String.fromEnvironment('API_URL', 
    defaultValue: 'https://api.example.com/api/v1'), // Full URL
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
));

// Add global interceptors (if not already added)
globalDio.interceptors.add(/* your request interceptor */);
globalDio.interceptors.add(/* your response interceptor */);

// Use with SDK
// Since Dio has baseUrl set, basePathOverride is optional
final openapi = Openapi(
  dio: globalDio,
  // basePathOverride not needed if dio.baseUrl is set
);

// All API clients will use your global Dio instance
final authApi = openapi.getAuthApi();
final placeApi = openapi.getPlaceApi();
```

#### Advanced: Shared Dio Instance Across All APIs

For better code organization, create a helper function to initialize the SDK with a shared Dio instance:

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:dio/dio.dart';

// Create shared Dio instance with interceptors
Dio createDioInstance() {
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_URL',
      defaultValue: 'https://api.example.com/api/v1'),
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  // Request interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = getAuthToken(); // Your token retrieval logic
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ));

  // Response interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        // Handle token refresh or redirect
        await handleUnauthorized();
      }
      return handler.next(error);
    },
  ));

  return dio;
}

// Initialize SDK with shared Dio instance
final dioInstance = createDioInstance();
final openapi = Openapi(dio: dioInstance);

// Export API clients
final apis = {
  'auth': openapi.getAuthApi(),
  'places': openapi.getPlaceApi(),
  'categories': openapi.getCategoryApi(),
  'feed': openapi.getFeedApi(),
  'reviews': openapi.getReviewsApi(),
  'user': openapi.getUserApi(),
};

// Use in your application
final places = await apis['places']!.placesGet(limit: 10);
```

### Understanding basePathOverride vs Dio baseUrl

**Important:** You don't need to set the URL multiple times. The SDK uses this priority:

1. **If Dio instance has `baseUrl` set** → Uses that (no need for `basePathOverride`)
2. **Otherwise** → Uses `basePathOverride` (must be full URL with protocol)
3. **Otherwise** → Uses default `http://localhost:8080/api/v1`

**Key points:**
- Set the URL **once** in either `basePathOverride` OR `Dio.baseUrl`
- `basePathOverride` must be the **complete URL** including protocol (e.g., `https://api.example.com/api/v1`)
- If using custom Dio with `baseUrl`, you can omit `basePathOverride`
- All API clients created from the same Openapi instance share the same basePath/Dio

### Example: User Signup

```dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:nashik_darshan_sdk/api/auth_api.dart';

// Create Openapi instance once (reuse for all API clients)
final openapi = Openapi(
  basePathOverride: 'https://api.example.com/api/v1',
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

// Reuse the same Openapi instance (don't create a new one)
final openapi = Openapi(
  basePathOverride: 'https://api.example.com/api/v1',
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

// Reuse the same Openapi instance
final openapi = Openapi(
  basePathOverride: 'https://api.example.com/api/v1',
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

// Reuse the same Openapi instance
final openapi = Openapi(
  basePathOverride: 'https://api.example.com/api/v1',
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
               'https://api.example.com/api/v1';

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
