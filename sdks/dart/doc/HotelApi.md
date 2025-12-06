# openapi.api.HotelApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**hotelsGet**](HotelApi.md#hotelsget) | **GET** /hotels | List hotels
[**hotelsIdDelete**](HotelApi.md#hotelsiddelete) | **DELETE** /hotels/{id} | Delete a hotel
[**hotelsIdGet**](HotelApi.md#hotelsidget) | **GET** /hotels/{id} | Get hotel by ID
[**hotelsIdPut**](HotelApi.md#hotelsidput) | **PUT** /hotels/{id} | Update a hotel
[**hotelsPost**](HotelApi.md#hotelspost) | **POST** /hotels | Create a new hotel
[**hotelsSlugSlugGet**](HotelApi.md#hotelsslugslugget) | **GET** /hotels/slug/{slug} | Get hotel by slug


# **hotelsGet**
> DtoListHotelsResponse hotelsGet(endTime, expand, lastViewedAfter, latitude, limit, longitude, maxPrice, minPrice, offset, order, radiusM, searchQuery, slug, sort, starRating, startTime, status)

List hotels

Get a paginated list of hotels with filtering and pagination

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHotelApi();
final String endTime = endTime_example; // String | 
final String expand = expand_example; // String | 
final String lastViewedAfter = lastViewedAfter_example; // String | Trending filter
final num latitude = 8.14; // num | Geospatial filters
final int limit = 56; // int | 
final num longitude = 8.14; // num | 
final num maxPrice = 8.14; // num | 
final num minPrice = 8.14; // num | Price range filters
final int offset = 56; // int | 
final String order = order_example; // String | 
final num radiusM = 8.14; // num | radius in meters
final String searchQuery = searchQuery_example; // String | Search
final BuiltList<String> slug = ; // BuiltList<String> | Custom filters
final String sort = sort_example; // String | 
final BuiltList<int> starRating = ; // BuiltList<int> | 
final String startTime = startTime_example; // String | 
final String status = status_example; // String | 

try {
    final response = api.hotelsGet(endTime, expand, lastViewedAfter, latitude, limit, longitude, maxPrice, minPrice, offset, order, radiusM, searchQuery, slug, sort, starRating, startTime, status);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HotelApi->hotelsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **endTime** | **String**|  | [optional] 
 **expand** | **String**|  | [optional] 
 **lastViewedAfter** | **String**| Trending filter | [optional] 
 **latitude** | **num**| Geospatial filters | [optional] 
 **limit** | **int**|  | [optional] 
 **longitude** | **num**|  | [optional] 
 **maxPrice** | **num**|  | [optional] 
 **minPrice** | **num**| Price range filters | [optional] 
 **offset** | **int**|  | [optional] 
 **order** | **String**|  | [optional] 
 **radiusM** | **num**| radius in meters | [optional] 
 **searchQuery** | **String**| Search | [optional] 
 **slug** | [**BuiltList&lt;String&gt;**](String.md)| Custom filters | [optional] 
 **sort** | **String**|  | [optional] 
 **starRating** | [**BuiltList&lt;int&gt;**](int.md)|  | [optional] 
 **startTime** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 

### Return type

[**DtoListHotelsResponse**](DtoListHotelsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsIdDelete**
> hotelsIdDelete(id)

Delete a hotel

Soft delete a hotel

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getHotelApi();
final String id = id_example; // String | Hotel ID

try {
    api.hotelsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling HotelApi->hotelsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Hotel ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsIdGet**
> DtoHotelResponse hotelsIdGet(id)

Get hotel by ID

Get a hotel by its ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHotelApi();
final String id = id_example; // String | Hotel ID

try {
    final response = api.hotelsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HotelApi->hotelsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Hotel ID | 

### Return type

[**DtoHotelResponse**](DtoHotelResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsIdPut**
> DtoHotelResponse hotelsIdPut(id, request)

Update a hotel

Update an existing hotel

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getHotelApi();
final String id = id_example; // String | Hotel ID
final DtoUpdateHotelRequest request = ; // DtoUpdateHotelRequest | Update hotel request

try {
    final response = api.hotelsIdPut(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HotelApi->hotelsIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Hotel ID | 
 **request** | [**DtoUpdateHotelRequest**](DtoUpdateHotelRequest.md)| Update hotel request | 

### Return type

[**DtoHotelResponse**](DtoHotelResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsPost**
> DtoHotelResponse hotelsPost(request)

Create a new hotel

Create a new hotel with the provided details

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getHotelApi();
final DtoCreateHotelRequest request = ; // DtoCreateHotelRequest | Create hotel request

try {
    final response = api.hotelsPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HotelApi->hotelsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoCreateHotelRequest**](DtoCreateHotelRequest.md)| Create hotel request | 

### Return type

[**DtoHotelResponse**](DtoHotelResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsSlugSlugGet**
> DtoHotelResponse hotelsSlugSlugGet(slug)

Get hotel by slug

Get a hotel by its slug

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getHotelApi();
final String slug = slug_example; // String | Hotel slug

try {
    final response = api.hotelsSlugSlugGet(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HotelApi->hotelsSlugSlugGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Hotel slug | 

### Return type

[**DtoHotelResponse**](DtoHotelResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

