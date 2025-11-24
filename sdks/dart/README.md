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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';

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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';
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

## Integration with Freezed, Clean Architecture, Flutter Bloc & Cubits

This section demonstrates how to integrate the SDK seamlessly with Freezed, Clean Architecture pattern, Flutter Bloc, and Cubits for a production-ready Flutter application.

### Project Structure

```
lib/
├── core/
│   ├── api/
│   │   └── api_client.dart          # SDK initialization
│   ├── error/
│   │   └── failures.dart            # Error handling
│   └── usecases/
│       └── usecase.dart             # Base use case
├── features/
│   └── places/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── places_remote_datasource.dart
│       │   ├── models/
│       │   │   └── place_model.dart # Freezed model
│       │   └── repositories/
│       │       └── places_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── place.dart       # Domain entity
│       │   ├── repositories/
│       │   │   └── places_repository.dart
│       │   └── usecases/
│       │       ├── get_places.dart
│       │       └── search_places.dart
│       └── presentation/
│           ├── bloc/
│           │   └── places_bloc.dart
│           └── cubit/
│               └── places_cubit.dart
```

### Step 1: Setup Dependencies

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  nashik_darshan_sdk: ^1.0.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dio: ^5.4.0

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

### Step 2: Initialize API Client (Core Layer)

```dart
// lib/core/api/api_client.dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static Openapi? _instance;

  static Openapi get instance {
    _instance ??= _createClient();
    return _instance!;
  }

  static Openapi _createClient() {
    final dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment(
        'API_URL',
        defaultValue: 'https://api.example.com/api/v1',
      ),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        final token = _getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Handle errors globally
        return handler.next(error);
      },
    ));

    return Openapi(
      dio: dio,
    );
  }

  static String? _getAuthToken() {
    // Implement your token retrieval logic
    // e.g., from SharedPreferences, secure storage, etc.
    return null;
  }

  static void setAuthToken(String token) {
    instance.setBearerAuth('default', token);
  }
}
```

### Step 3: Create Domain Entities (Freezed)

```dart
// lib/features/places/domain/entities/place.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    required String title,
    String? subtitle,
    String? description,
    String? placeType,
    double? ratingAvg,
    int? reviewCount,
    String? thumbnailUrl,
    String? primaryImageUrl,
    double? latitude,
    double? longitude,
  }) = _Place;
}
```

### Step 4: Create Data Models (Freezed with JSON)

```dart
// lib/features/places/data/models/place_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nashik_darshan_sdk/model/dto_place_response.dart';
import '../../domain/entities/place.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
class PlaceModel with _$PlaceModel {
  const factory PlaceModel({
    required String id,
    required String title,
    String? subtitle,
    String? description,
    String? placeType,
    double? ratingAvg,
    int? reviewCount,
    String? thumbnailUrl,
    String? primaryImageUrl,
    double? latitude,
    double? longitude,
  }) = _PlaceModel;

  // Convert from SDK model
  factory PlaceModel.fromDto(DtoPlaceResponse dto) {
    return PlaceModel(
      id: dto.id ?? '',
      title: dto.title ?? '',
      subtitle: dto.subtitle,
      description: dto.description,
      placeType: dto.placeType,
      ratingAvg: dto.ratingAvg,
      reviewCount: dto.reviewCount,
      thumbnailUrl: dto.thumbnailUrl,
      primaryImageUrl: dto.primaryImageUrl,
      latitude: dto.location?.latitude,
      longitude: dto.location?.longitude,
    );
  }

  // Convert to domain entity
  Place toEntity() {
    return Place(
      id: id,
      title: title,
      subtitle: subtitle,
      description: description,
      placeType: placeType,
      ratingAvg: ratingAvg,
      reviewCount: reviewCount,
      thumbnailUrl: thumbnailUrl,
      primaryImageUrl: primaryImageUrl,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}
```

### Step 5: Create Remote Data Source

```dart
// lib/features/places/data/datasources/places_remote_datasource.dart
import 'package:nashik_darshan_sdk/openapi.dart';
import 'package:nashik_darshan_sdk/api/place_api.dart';
import 'package:nashik_darshan_sdk/model/dto_list_places_response.dart';
import '../models/place_model.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PlacesRemoteDataSource {
  Future<Either<Failure, List<PlaceModel>>> getPlaces({
    int? limit,
    int? offset,
    String? status,
  });

  Future<Either<Failure, List<PlaceModel>>> searchPlaces({
    String? searchQuery,
    List<String>? placeTypes,
    double? minRating,
    int? limit,
  });

  Future<Either<Failure, PlaceModel>> getPlaceById(String id);
}

class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  final PlaceApi _placeApi;

  PlacesRemoteDataSourceImpl({PlaceApi? placeApi})
      : _placeApi = placeApi ?? ApiClient.instance.getPlaceApi();

  @override
  Future<Either<Failure, List<PlaceModel>>> getPlaces({
    int? limit,
    int? offset,
    String? status,
  }) async {
    try {
      final response = await _placeApi.placesGet(
        limit: limit,
        offset: offset,
        status: status,
      );

      if (response.data?.items == null) {
        return Left(ServerFailure('No places found'));
      }

      final places = response.data!.items!
          .map((dto) => PlaceModel.fromDto(dto))
          .toList();

      return Right(places);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> searchPlaces({
    String? searchQuery,
    List<String>? placeTypes,
    double? minRating,
    int? limit,
  }) async {
    try {
      final response = await _placeApi.placesGet(
        searchQuery: searchQuery,
        placeTypes: placeTypes,
        minRating: minRating,
        limit: limit,
      );

      if (response.data?.items == null) {
        return Left(ServerFailure('No places found'));
      }

      final places = response.data!.items!
          .map((dto) => PlaceModel.fromDto(dto))
          .toList();

      return Right(places);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlaceModel>> getPlaceById(String id) async {
    try {
      final response = await _placeApi.placesIdGet(id);

      if (response.data == null) {
        return Left(ServerFailure('Place not found'));
      }

      return Right(PlaceModel.fromDto(response.data!));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      if (statusCode == 401) {
        return AuthenticationFailure('Unauthorized');
      } else if (statusCode == 404) {
        return NotFoundFailure('Resource not found');
      } else {
        return ServerFailure('Server error: $statusCode');
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkFailure('Connection timeout');
    } else {
      return NetworkFailure('Network error: ${error.message}');
    }
  }
}
```

### Step 6: Create Failures (Error Handling)

```dart
// lib/core/error/failures.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.authentication(String message) = AuthenticationFailure;
  const factory Failure.notFound(String message) = NotFoundFailure;
  const factory Failure.cache(String message) = CacheFailure;
}
```

### Step 7: Create Repository Interface (Domain Layer)

```dart
// lib/features/places/domain/repositories/places_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/place.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<Place>>> getPlaces({
    int? limit,
    int? offset,
    String? status,
  });

  Future<Either<Failure, List<Place>>> searchPlaces({
    String? searchQuery,
    List<String>? placeTypes,
    double? minRating,
    int? limit,
  });

  Future<Either<Failure, Place>> getPlaceById(String id);
}
```

### Step 8: Implement Repository (Data Layer)

```dart
// lib/features/places/data/repositories/places_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/place.dart';
import '../../domain/repositories/places_repository.dart';
import '../datasources/places_remote_datasource.dart';
import '../models/place_model.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesRemoteDataSource remoteDataSource;

  PlacesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Place>>> getPlaces({
    int? limit,
    int? offset,
    String? status,
  }) async {
    final result = await remoteDataSource.getPlaces(
      limit: limit,
      offset: offset,
      status: status,
    );

    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<Place>>> searchPlaces({
    String? searchQuery,
    List<String>? placeTypes,
    double? minRating,
    int? limit,
  }) async {
    final result = await remoteDataSource.searchPlaces(
      searchQuery: searchQuery,
      placeTypes: placeTypes,
      minRating: minRating,
      limit: limit,
    );

    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Place>> getPlaceById(String id) async {
    final result = await remoteDataSource.getPlaceById(id);

    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }
}
```

### Step 9: Create Use Cases (Domain Layer)

```dart
// lib/core/usecases/usecase.dart
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
```

```dart
// lib/features/places/domain/usecases/get_places.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/place.dart';
import '../repositories/places_repository.dart';

class GetPlaces implements UseCase<List<Place>, GetPlacesParams> {
  final PlacesRepository repository;

  GetPlaces(this.repository);

  @override
  Future<Either<Failure, List<Place>>> call(GetPlacesParams params) async {
    return await repository.getPlaces(
      limit: params.limit,
      offset: params.offset,
      status: params.status,
    );
  }
}

class GetPlacesParams {
  final int? limit;
  final int? offset;
  final String? status;

  GetPlacesParams({
    this.limit,
    this.offset,
    this.status,
  });
}
```

```dart
// lib/features/places/domain/usecases/search_places.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/place.dart';
import '../repositories/places_repository.dart';

class SearchPlaces implements UseCase<List<Place>, SearchPlacesParams> {
  final PlacesRepository repository;

  SearchPlaces(this.repository);

  @override
  Future<Either<Failure, List<Place>>> call(SearchPlacesParams params) async {
    return await repository.searchPlaces(
      searchQuery: params.searchQuery,
      placeTypes: params.placeTypes,
      minRating: params.minRating,
      limit: params.limit,
    );
  }
}

class SearchPlacesParams {
  final String? searchQuery;
  final List<String>? placeTypes;
  final double? minRating;
  final int? limit;

  SearchPlacesParams({
    this.searchQuery,
    this.placeTypes,
    this.minRating,
    this.limit,
  });
}
```

### Step 10: Create Bloc (State Management)

```dart
// lib/features/places/presentation/bloc/places_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/place.dart';
import '../../domain/usecases/get_places.dart';
import '../../domain/usecases/search_places.dart';
import '../../../../core/error/failures.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final GetPlaces getPlaces;
  final SearchPlaces searchPlaces;

  PlacesBloc({
    required this.getPlaces,
    required this.searchPlaces,
  }) : super(PlacesInitial()) {
    on<GetPlacesEvent>(_onGetPlaces);
    on<SearchPlacesEvent>(_onSearchPlaces);
    on<RefreshPlacesEvent>(_onRefreshPlaces);
  }

  Future<void> _onGetPlaces(
    GetPlacesEvent event,
    Emitter<PlacesState> emit,
  ) async {
    emit(PlacesLoading());

    final result = await getPlaces(GetPlacesParams(
      limit: event.limit,
      offset: event.offset,
      status: event.status,
    ));

    result.fold(
      (failure) => emit(PlacesError(_mapFailureToMessage(failure))),
      (places) => emit(PlacesLoaded(places)),
    );
  }

  Future<void> _onSearchPlaces(
    SearchPlacesEvent event,
    Emitter<PlacesState> emit,
  ) async {
    emit(PlacesLoading());

    final result = await searchPlaces(SearchPlacesParams(
      searchQuery: event.searchQuery,
      placeTypes: event.placeTypes,
      minRating: event.minRating,
      limit: event.limit,
    ));

    result.fold(
      (failure) => emit(PlacesError(_mapFailureToMessage(failure))),
      (places) => emit(PlacesLoaded(places)),
    );
  }

  Future<void> _onRefreshPlaces(
    RefreshPlacesEvent event,
    Emitter<PlacesState> emit,
  ) async {
    add(GetPlacesEvent(
      limit: event.limit,
      offset: event.offset,
      status: event.status,
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      server: (message) => 'Server error: $message',
      network: (message) => 'Network error: $message',
      authentication: (message) => 'Authentication error: $message',
      notFound: (message) => 'Not found: $message',
      cache: (message) => 'Cache error: $message',
    );
  }
}
```

```dart
// lib/features/places/presentation/bloc/places_event.dart
part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object?> get props => [];
}

class GetPlacesEvent extends PlacesEvent {
  final int? limit;
  final int? offset;
  final String? status;

  const GetPlacesEvent({
    this.limit,
    this.offset,
    this.status,
  });

  @override
  List<Object?> get props => [limit, offset, status];
}

class SearchPlacesEvent extends PlacesEvent {
  final String? searchQuery;
  final List<String>? placeTypes;
  final double? minRating;
  final int? limit;

  const SearchPlacesEvent({
    this.searchQuery,
    this.placeTypes,
    this.minRating,
    this.limit,
  });

  @override
  List<Object?> get props => [searchQuery, placeTypes, minRating, limit];
}

class RefreshPlacesEvent extends PlacesEvent {
  final int? limit;
  final int? offset;
  final String? status;

  const RefreshPlacesEvent({
    this.limit,
    this.offset,
    this.status,
  });

  @override
  List<Object?> get props => [limit, offset, status];
}
```

```dart
// lib/features/places/presentation/bloc/places_state.dart
part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;

  const PlacesLoaded(this.places);

  @override
  List<Object?> get props => [places];
}

class PlacesError extends PlacesState {
  final String message;

  const PlacesError(this.message);

  @override
  List<Object?> get props => [message];
}
```

### Step 11: Create Cubit (Alternative to Bloc)

```dart
// lib/features/places/presentation/cubit/places_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/place.dart';
import '../../domain/usecases/get_places.dart';
import '../../domain/usecases/search_places.dart';
import '../../../../core/error/failures.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final GetPlaces getPlaces;
  final SearchPlaces searchPlaces;

  PlacesCubit({
    required this.getPlaces,
    required this.searchPlaces,
  }) : super(PlacesInitial());

  Future<void> loadPlaces({
    int? limit,
    int? offset,
    String? status,
  }) async {
    emit(PlacesLoading());

    final result = await getPlaces(GetPlacesParams(
      limit: limit,
      offset: offset,
      status: status,
    ));

    result.fold(
      (failure) => emit(PlacesError(_mapFailureToMessage(failure))),
      (places) => emit(PlacesLoaded(places)),
    );
  }

  Future<void> search({
    String? searchQuery,
    List<String>? placeTypes,
    double? minRating,
    int? limit,
  }) async {
    emit(PlacesLoading());

    final result = await searchPlaces(SearchPlacesParams(
      searchQuery: searchQuery,
      placeTypes: placeTypes,
      minRating: minRating,
      limit: limit,
    ));

    result.fold(
      (failure) => emit(PlacesError(_mapFailureToMessage(failure))),
      (places) => emit(PlacesLoaded(places)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      server: (message) => 'Server error: $message',
      network: (message) => 'Network error: $message',
      authentication: (message) => 'Authentication error: $message',
      notFound: (message) => 'Not found: $message',
      cache: (message) => 'Cache error: $message',
    );
  }
}

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;

  const PlacesLoaded(this.places);

  @override
  List<Object?> get props => [places];
}

class PlacesError extends PlacesState {
  final String message;

  const PlacesError(this.message);

  @override
  List<Object?> get props => [message];
}
```

### Step 12: Dependency Injection Setup

```dart
// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'core/api/api_client.dart';
import 'features/places/data/datasources/places_remote_datasource.dart';
import 'features/places/data/repositories/places_repository_impl.dart';
import 'features/places/domain/repositories/places_repository.dart';
import 'features/places/domain/usecases/get_places.dart';
import 'features/places/domain/usecases/search_places.dart';
import 'features/places/presentation/bloc/places_bloc.dart';
import 'features/places/presentation/cubit/places_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Places
  // Bloc
  sl.registerFactory(
    () => PlacesBloc(
      getPlaces: sl(),
      searchPlaces: sl(),
    ),
  );

  // Cubit (alternative)
  sl.registerFactory(
    () => PlacesCubit(
      getPlaces: sl(),
      searchPlaces: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPlaces(sl()));
  sl.registerLazySingleton(() => SearchPlaces(sl()));

  // Repository
  sl.registerLazySingleton<PlacesRepository>(
    () => PlacesRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PlacesRemoteDataSource>(
    () => PlacesRemoteDataSourceImpl(),
  );
}
```

### Step 13: Usage in Flutter Widget (Bloc)

```dart
// lib/features/places/presentation/pages/places_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/places_bloc.dart';
import '../../../../injection_container.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PlacesBloc>()..add(const GetPlacesEvent(limit: 20)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Places')),
        body: BlocBuilder<PlacesBloc, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlacesLoaded) {
              return ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (context, index) {
                  final place = state.places[index];
                  return ListTile(
                    title: Text(place.title),
                    subtitle: Text(place.placeType ?? ''),
                    trailing: place.ratingAvg != null
                        ? Text('⭐ ${place.ratingAvg!.toStringAsFixed(1)}')
                        : null,
                  );
                },
              );
            } else if (state is PlacesError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<PlacesBloc>().add(
              const SearchPlacesEvent(
                searchQuery: 'hotel',
                limit: 10,
              ),
            );
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
```

### Step 14: Usage in Flutter Widget (Cubit)

```dart
// lib/features/places/presentation/pages/places_page_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/places_cubit.dart';
import '../../../../injection_container.dart';

class PlacesPageCubit extends StatelessWidget {
  const PlacesPageCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PlacesCubit>()..loadPlaces(limit: 20),
      child: Scaffold(
        appBar: AppBar(title: const Text('Places')),
        body: BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlacesLoaded) {
              return ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (context, index) {
                  final place = state.places[index];
                  return ListTile(
                    title: Text(place.title),
                    subtitle: Text(place.placeType ?? ''),
                    trailing: place.ratingAvg != null
                        ? Text('⭐ ${place.ratingAvg!.toStringAsFixed(1)}')
                        : null,
                  );
                },
              );
            } else if (state is PlacesError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<PlacesCubit>().search(
              searchQuery: 'hotel',
              limit: 10,
            );
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
```

### Step 15: Run Code Generation

After creating your Freezed models, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate the necessary `.freezed.dart` and `.g.dart` files.

### Key Benefits of This Architecture

1. **Separation of Concerns**: Clear boundaries between data, domain, and presentation layers
2. **Testability**: Easy to mock repositories and test use cases independently
3. **Maintainability**: Changes in one layer don't affect others
4. **Type Safety**: Freezed ensures immutability and compile-time safety
5. **Reusability**: Use cases can be reused across different features
6. **Error Handling**: Centralized error handling with Either type from dartz

### Additional Tips

- Use `dartz` package for functional programming patterns (Either, Option)
- Implement caching layer in repository for offline support
- Add pagination support in your data models
- Use `freezed` unions for better error handling
- Consider using `injectable` or `get_it` for dependency injection
- Add logging interceptor to Dio for debugging

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
