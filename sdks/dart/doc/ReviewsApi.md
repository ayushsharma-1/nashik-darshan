# openapi.api.ReviewsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reviewsGet**](ReviewsApi.md#reviewsget) | **GET** /reviews | List reviews
[**reviewsIdDelete**](ReviewsApi.md#reviewsiddelete) | **DELETE** /reviews/{id} | Delete a review
[**reviewsIdGet**](ReviewsApi.md#reviewsidget) | **GET** /reviews/{id} | Get review by ID
[**reviewsIdPut**](ReviewsApi.md#reviewsidput) | **PUT** /reviews/{id} | Update a review
[**reviewsPost**](ReviewsApi.md#reviewspost) | **POST** /reviews | Create a new review
[**reviewsStatsEntityTypeEntityIdGet**](ReviewsApi.md#reviewsstatsentitytypeentityidget) | **GET** /reviews/stats/{entityType}/{entityId} | Get rating statistics


# **reviewsGet**
> TypesListResponseDtoReviewResponse reviewsGet(limit, offset, entityType, entityId, userId, minRating, maxRating)

List reviews

Get a paginated list of reviews with filtering

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getReviewsApi();
final int limit = 56; // int | Limit
final int offset = 56; // int | Offset
final String entityType = entityType_example; // String | Entity type (place, experience, etc.)
final String entityId = entityId_example; // String | Entity ID
final String userId = userId_example; // String | User ID
final num minRating = 8.14; // num | Minimum rating
final num maxRating = 8.14; // num | Maximum rating

try {
    final response = api.reviewsGet(limit, offset, entityType, entityId, userId, minRating, maxRating);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewsApi->reviewsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**| Limit | [optional] 
 **offset** | **int**| Offset | [optional] 
 **entityType** | **String**| Entity type (place, experience, etc.) | [optional] 
 **entityId** | **String**| Entity ID | [optional] 
 **userId** | **String**| User ID | [optional] 
 **minRating** | **num**| Minimum rating | [optional] 
 **maxRating** | **num**| Maximum rating | [optional] 

### Return type

[**TypesListResponseDtoReviewResponse**](TypesListResponseDtoReviewResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsIdDelete**
> reviewsIdDelete(id)

Delete a review

Delete a review

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getReviewsApi();
final String id = id_example; // String | Review ID

try {
    api.reviewsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ReviewsApi->reviewsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Review ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsIdGet**
> DtoReviewResponse reviewsIdGet(id)

Get review by ID

Get a review by its ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getReviewsApi();
final String id = id_example; // String | Review ID

try {
    final response = api.reviewsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewsApi->reviewsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Review ID | 

### Return type

[**DtoReviewResponse**](DtoReviewResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsIdPut**
> DtoReviewResponse reviewsIdPut(id, request)

Update a review

Update an existing review

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getReviewsApi();
final String id = id_example; // String | Review ID
final DtoUpdateReviewRequest request = ; // DtoUpdateReviewRequest | Update review request

try {
    final response = api.reviewsIdPut(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewsApi->reviewsIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Review ID | 
 **request** | [**DtoUpdateReviewRequest**](DtoUpdateReviewRequest.md)| Update review request | 

### Return type

[**DtoReviewResponse**](DtoReviewResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsPost**
> DtoReviewResponse reviewsPost(request)

Create a new review

Create a new review for a place or other entity

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getReviewsApi();
final DtoCreateReviewRequest request = ; // DtoCreateReviewRequest | Create review request

try {
    final response = api.reviewsPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewsApi->reviewsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoCreateReviewRequest**](DtoCreateReviewRequest.md)| Create review request | 

### Return type

[**DtoReviewResponse**](DtoReviewResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsStatsEntityTypeEntityIdGet**
> DtoRatingStatsResponse reviewsStatsEntityTypeEntityIdGet(entityType, entityId)

Get rating statistics

Get rating statistics for an entity (place, experience, etc.)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getReviewsApi();
final String entityType = entityType_example; // String | Entity type (place, experience, etc.)
final String entityId = entityId_example; // String | Entity ID

try {
    final response = api.reviewsStatsEntityTypeEntityIdGet(entityType, entityId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewsApi->reviewsStatsEntityTypeEntityIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **entityType** | **String**| Entity type (place, experience, etc.) | 
 **entityId** | **String**| Entity ID | 

### Return type

[**DtoRatingStatsResponse**](DtoRatingStatsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

