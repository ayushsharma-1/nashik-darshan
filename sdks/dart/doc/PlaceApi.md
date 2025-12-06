# openapi.api.PlaceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**feedPost**](PlaceApi.md#feedpost) | **POST** /feed | Get feed data
[**placesGet**](PlaceApi.md#placesget) | **GET** /places | List places
[**placesIdDelete**](PlaceApi.md#placesiddelete) | **DELETE** /places/{id} | Delete a place
[**placesIdGet**](PlaceApi.md#placesidget) | **GET** /places/{id} | Get place by ID
[**placesIdImagesGet**](PlaceApi.md#placesidimagesget) | **GET** /places/{id}/images | Get place images
[**placesIdImagesPost**](PlaceApi.md#placesidimagespost) | **POST** /places/{id}/images | Add image to place
[**placesIdPut**](PlaceApi.md#placesidput) | **PUT** /places/{id} | Update a place
[**placesIdViewPost**](PlaceApi.md#placesidviewpost) | **POST** /places/{id}/view | Increment view count for a place
[**placesImagesImageIdDelete**](PlaceApi.md#placesimagesimageiddelete) | **DELETE** /places/images/{image_id} | Delete place image
[**placesImagesImageIdPut**](PlaceApi.md#placesimagesimageidput) | **PUT** /places/images/{image_id} | Update place image
[**placesPost**](PlaceApi.md#placespost) | **POST** /places | Create a new place
[**placesSlugSlugGet**](PlaceApi.md#placesslugslugget) | **GET** /places/slug/{slug} | Get place by slug


# **feedPost**
> DtoFeedResponse feedPost(request)

Get feed data

Get feed data with multiple sections (trending, popular, latest, nearby)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPlaceApi();
final DtoFeedRequest request = ; // DtoFeedRequest | Feed request with sections

try {
    final response = api.feedPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->feedPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoFeedRequest**](DtoFeedRequest.md)| Feed request with sections | 

### Return type

[**DtoFeedResponse**](DtoFeedResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesGet**
> DtoListPlacesResponse placesGet(limit, offset, status, sort, order, slug, placeTypes, categories, amenities, minRating, maxRating, latitude, longitude, radiusKm, searchQuery)

List places

Get a paginated list of places with filtering and pagination

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPlaceApi();
final int limit = 56; // int | Limit
final int offset = 56; // int | Offset
final String status = status_example; // String | Status
final String sort = sort_example; // String | Sort field
final String order = order_example; // String | Sort order (asc/desc)
final BuiltList<String> slug = ; // BuiltList<String> | Filter by slugs
final BuiltList<String> placeTypes = ; // BuiltList<String> | Filter by place types
final BuiltList<String> categories = ; // BuiltList<String> | Filter by categories
final BuiltList<String> amenities = ; // BuiltList<String> | Filter by amenities
final num minRating = 8.14; // num | Minimum rating
final num maxRating = 8.14; // num | Maximum rating
final num latitude = 8.14; // num | Latitude for geospatial filtering
final num longitude = 8.14; // num | Longitude for geospatial filtering
final num radiusKm = 8.14; // num | Radius in kilometers for geospatial filtering
final String searchQuery = searchQuery_example; // String | Search query

try {
    final response = api.placesGet(limit, offset, status, sort, order, slug, placeTypes, categories, amenities, minRating, maxRating, latitude, longitude, radiusKm, searchQuery);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**| Limit | [optional] 
 **offset** | **int**| Offset | [optional] 
 **status** | **String**| Status | [optional] 
 **sort** | **String**| Sort field | [optional] 
 **order** | **String**| Sort order (asc/desc) | [optional] 
 **slug** | [**BuiltList&lt;String&gt;**](String.md)| Filter by slugs | [optional] 
 **placeTypes** | [**BuiltList&lt;String&gt;**](String.md)| Filter by place types | [optional] 
 **categories** | [**BuiltList&lt;String&gt;**](String.md)| Filter by categories | [optional] 
 **amenities** | [**BuiltList&lt;String&gt;**](String.md)| Filter by amenities | [optional] 
 **minRating** | **num**| Minimum rating | [optional] 
 **maxRating** | **num**| Maximum rating | [optional] 
 **latitude** | **num**| Latitude for geospatial filtering | [optional] 
 **longitude** | **num**| Longitude for geospatial filtering | [optional] 
 **radiusKm** | **num**| Radius in kilometers for geospatial filtering | [optional] 
 **searchQuery** | **String**| Search query | [optional] 

### Return type

[**DtoListPlacesResponse**](DtoListPlacesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdDelete**
> placesIdDelete(id)

Delete a place

Soft delete a place

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getPlaceApi();
final String id = id_example; // String | Place ID

try {
    api.placesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Place ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdGet**
> DtoPlaceResponse placesIdGet(id)

Get place by ID

Get a place by its ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPlaceApi();
final String id = id_example; // String | Place ID

try {
    final response = api.placesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Place ID | 

### Return type

[**DtoPlaceResponse**](DtoPlaceResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdImagesGet**
> BuiltList<DtoPlaceImageResponse> placesIdImagesGet(id)

Get place images

Get all images for a place

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPlaceApi();
final String id = id_example; // String | Place ID

try {
    final response = api.placesIdImagesGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesIdImagesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Place ID | 

### Return type

[**BuiltList&lt;DtoPlaceImageResponse&gt;**](DtoPlaceImageResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdImagesPost**
> DtoPlaceImageResponse placesIdImagesPost(id, request)

Add image to place

Add an image to a place

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getPlaceApi();
final String id = id_example; // String | Place ID
final DtoCreatePlaceImageRequest request = ; // DtoCreatePlaceImageRequest | Create place image request

try {
    final response = api.placesIdImagesPost(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesIdImagesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Place ID | 
 **request** | [**DtoCreatePlaceImageRequest**](DtoCreatePlaceImageRequest.md)| Create place image request | 

### Return type

[**DtoPlaceImageResponse**](DtoPlaceImageResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdPut**
> DtoPlaceResponse placesIdPut(id, request)

Update a place

Update an existing place

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getPlaceApi();
final String id = id_example; // String | Place ID
final DtoUpdatePlaceRequest request = ; // DtoUpdatePlaceRequest | Update place request

try {
    final response = api.placesIdPut(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Place ID | 
 **request** | [**DtoUpdatePlaceRequest**](DtoUpdatePlaceRequest.md)| Update place request | 

### Return type

[**DtoPlaceResponse**](DtoPlaceResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdViewPost**
> placesIdViewPost(id)

Increment view count for a place

Increment the view count for a specific place

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPlaceApi();
final String id = id_example; // String | Place ID

try {
    api.placesIdViewPost(id);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesIdViewPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Place ID | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesImagesImageIdDelete**
> placesImagesImageIdDelete(imageId)

Delete place image

Delete a place image

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getPlaceApi();
final String imageId = imageId_example; // String | Image ID

try {
    api.placesImagesImageIdDelete(imageId);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesImagesImageIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **imageId** | **String**| Image ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesImagesImageIdPut**
> DtoPlaceImageResponse placesImagesImageIdPut(imageId, request)

Update place image

Update an existing place image

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getPlaceApi();
final String imageId = imageId_example; // String | Image ID
final DtoUpdatePlaceImageRequest request = ; // DtoUpdatePlaceImageRequest | Update place image request

try {
    final response = api.placesImagesImageIdPut(imageId, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesImagesImageIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **imageId** | **String**| Image ID | 
 **request** | [**DtoUpdatePlaceImageRequest**](DtoUpdatePlaceImageRequest.md)| Update place image request | 

### Return type

[**DtoPlaceImageResponse**](DtoPlaceImageResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesPost**
> DtoPlaceResponse placesPost(request)

Create a new place

Create a new place with the provided details

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getPlaceApi();
final DtoCreatePlaceRequest request = ; // DtoCreatePlaceRequest | Create place request

try {
    final response = api.placesPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoCreatePlaceRequest**](DtoCreatePlaceRequest.md)| Create place request | 

### Return type

[**DtoPlaceResponse**](DtoPlaceResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesSlugSlugGet**
> DtoPlaceResponse placesSlugSlugGet(slug)

Get place by slug

Get a place by its slug

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPlaceApi();
final String slug = slug_example; // String | Place slug

try {
    final response = api.placesSlugSlugGet(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PlaceApi->placesSlugSlugGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Place slug | 

### Return type

[**DtoPlaceResponse**](DtoPlaceResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

