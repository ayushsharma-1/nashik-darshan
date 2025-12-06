# openapi.api.EventApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**eventsEventIdOccurrencesGet**](EventApi.md#eventseventidoccurrencesget) | **GET** /events/{eventId}/occurrences | List occurrences for event
[**eventsGet**](EventApi.md#eventsget) | **GET** /events | List events
[**eventsIdDelete**](EventApi.md#eventsiddelete) | **DELETE** /events/{id} | Delete an event
[**eventsIdGet**](EventApi.md#eventsidget) | **GET** /events/{id} | Get event by ID
[**eventsIdInterestedPost**](EventApi.md#eventsidinterestedpost) | **POST** /events/{id}/interested | Increment event interested count
[**eventsIdPut**](EventApi.md#eventsidput) | **PUT** /events/{id} | Update an event
[**eventsIdViewPost**](EventApi.md#eventsidviewpost) | **POST** /events/{id}/view | Increment event view count
[**eventsOccurrencesIdDelete**](EventApi.md#eventsoccurrencesiddelete) | **DELETE** /events/occurrences/{id} | Delete occurrence
[**eventsOccurrencesIdGet**](EventApi.md#eventsoccurrencesidget) | **GET** /events/occurrences/{id} | Get occurrence by ID
[**eventsOccurrencesIdPut**](EventApi.md#eventsoccurrencesidput) | **PUT** /events/occurrences/{id} | Update occurrence
[**eventsOccurrencesPost**](EventApi.md#eventsoccurrencespost) | **POST** /events/occurrences | Create event occurrence
[**eventsPost**](EventApi.md#eventspost) | **POST** /events | Create a new event
[**eventsSlugSlugGet**](EventApi.md#eventsslugslugget) | **GET** /events/slug/{slug} | Get event by slug


# **eventsEventIdOccurrencesGet**
> BuiltList<DtoOccurrenceResponse> eventsEventIdOccurrencesGet(eventId)

List occurrences for event

Get all occurrences for a specific event

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final String eventId = eventId_example; // String | Event ID

try {
    final response = api.eventsEventIdOccurrencesGet(eventId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsEventIdOccurrencesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventId** | **String**| Event ID | 

### Return type

[**BuiltList&lt;DtoOccurrenceResponse&gt;**](DtoOccurrenceResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsGet**
> DtoListEventsResponse eventsGet(expand, fromDate, limit, offset, order, placeId, sort, status, tags, toDate, type, expand2, fromDate2, toDate2)

List events

Get a paginated list of events with filtering and pagination. Use expand=true with from_date and to_date to get expanded occurrences.

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final bool expand = true; // bool | If true, expand occurrences in date range
final String fromDate = fromDate_example; // String | ISO date YYYY-MM-DD
final int limit = 56; // int | 
final int offset = 56; // int | 
final String order = order_example; // String | 
final String placeId = placeId_example; // String | 
final String sort = sort_example; // String | 
final String status = status_example; // String | 
final BuiltList<String> tags = ; // BuiltList<String> | 
final String toDate = toDate_example; // String | ISO date YYYY-MM-DD
final String type = type_example; // String | 
final bool expand2 = true; // bool | Expand occurrences in date range
final String fromDate2 = fromDate_example; // String | Start date for expansion (YYYY-MM-DD)
final String toDate2 = toDate_example; // String | End date for expansion (YYYY-MM-DD)

try {
    final response = api.eventsGet(expand, fromDate, limit, offset, order, placeId, sort, status, tags, toDate, type, expand2, fromDate2, toDate2);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **expand** | **bool**| If true, expand occurrences in date range | [optional] 
 **fromDate** | **String**| ISO date YYYY-MM-DD | [optional] 
 **limit** | **int**|  | [optional] 
 **offset** | **int**|  | [optional] 
 **order** | **String**|  | [optional] 
 **placeId** | **String**|  | [optional] 
 **sort** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 
 **tags** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] 
 **toDate** | **String**| ISO date YYYY-MM-DD | [optional] 
 **type** | **String**|  | [optional] 
 **expand2** | **bool**| Expand occurrences in date range | [optional] 
 **fromDate2** | **String**| Start date for expansion (YYYY-MM-DD) | [optional] 
 **toDate2** | **String**| End date for expansion (YYYY-MM-DD) | [optional] 

### Return type

[**DtoListEventsResponse**](DtoListEventsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsIdDelete**
> eventsIdDelete(id)

Delete an event

Soft delete an event

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final String id = id_example; // String | Event ID

try {
    api.eventsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Event ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsIdGet**
> DtoEventResponse eventsIdGet(id)

Get event by ID

Get an event by its ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final String id = id_example; // String | Event ID

try {
    final response = api.eventsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Event ID | 

### Return type

[**DtoEventResponse**](DtoEventResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsIdInterestedPost**
> eventsIdInterestedPost(id)

Increment event interested count

Increment the interested count for an event (user marked as interested)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final String id = id_example; // String | Event ID

try {
    api.eventsIdInterestedPost(id);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsIdInterestedPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Event ID | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsIdPut**
> DtoEventResponse eventsIdPut(id, request)

Update an event

Update an existing event

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final String id = id_example; // String | Event ID
final DtoUpdateEventRequest request = ; // DtoUpdateEventRequest | Update event request

try {
    final response = api.eventsIdPut(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Event ID | 
 **request** | [**DtoUpdateEventRequest**](DtoUpdateEventRequest.md)| Update event request | 

### Return type

[**DtoEventResponse**](DtoEventResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsIdViewPost**
> eventsIdViewPost(id)

Increment event view count

Increment the view count for an event (analytics)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final String id = id_example; // String | Event ID

try {
    api.eventsIdViewPost(id);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsIdViewPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Event ID | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsOccurrencesIdDelete**
> eventsOccurrencesIdDelete(id)

Delete occurrence

Soft delete an event occurrence

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final String id = id_example; // String | Occurrence ID

try {
    api.eventsOccurrencesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsOccurrencesIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Occurrence ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsOccurrencesIdGet**
> DtoOccurrenceResponse eventsOccurrencesIdGet(id)

Get occurrence by ID

Get an event occurrence by its ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final String id = id_example; // String | Occurrence ID

try {
    final response = api.eventsOccurrencesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsOccurrencesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Occurrence ID | 

### Return type

[**DtoOccurrenceResponse**](DtoOccurrenceResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsOccurrencesIdPut**
> DtoOccurrenceResponse eventsOccurrencesIdPut(id, request)

Update occurrence

Update an existing event occurrence

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final String id = id_example; // String | Occurrence ID
final DtoUpdateOccurrenceRequest request = ; // DtoUpdateOccurrenceRequest | Update occurrence request

try {
    final response = api.eventsOccurrencesIdPut(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsOccurrencesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Occurrence ID | 
 **request** | [**DtoUpdateOccurrenceRequest**](DtoUpdateOccurrenceRequest.md)| Update occurrence request | 

### Return type

[**DtoOccurrenceResponse**](DtoOccurrenceResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsOccurrencesPost**
> DtoOccurrenceResponse eventsOccurrencesPost(request)

Create event occurrence

Create a new occurrence for an event

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final DtoCreateOccurrenceRequest request = ; // DtoCreateOccurrenceRequest | Create occurrence request

try {
    final response = api.eventsOccurrencesPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsOccurrencesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoCreateOccurrenceRequest**](DtoCreateOccurrenceRequest.md)| Create occurrence request | 

### Return type

[**DtoOccurrenceResponse**](DtoOccurrenceResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsPost**
> DtoEventResponse eventsPost(request)

Create a new event

Create a new event with the provided details

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final DtoCreateEventRequest request = ; // DtoCreateEventRequest | Create event request

try {
    final response = api.eventsPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoCreateEventRequest**](DtoCreateEventRequest.md)| Create event request | 

### Return type

[**DtoEventResponse**](DtoEventResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsSlugSlugGet**
> DtoEventResponse eventsSlugSlugGet(slug)

Get event by slug

Get an event by its slug

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final String slug = slug_example; // String | Event slug

try {
    final response = api.eventsSlugSlugGet(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EventApi->eventsSlugSlugGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Event slug | 

### Return type

[**DtoEventResponse**](DtoEventResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

