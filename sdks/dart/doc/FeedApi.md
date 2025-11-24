# openapi.api.FeedApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**feedPost**](FeedApi.md#feedpost) | **POST** /feed | Get feed data
[**placesIdViewPost**](FeedApi.md#placesidviewpost) | **POST** /places/{id}/view | Increment view count for a place


# **feedPost**
> DtoFeedResponse feedPost(request)

Get feed data

Get feed data with multiple sections (trending, popular, latest, nearby)

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFeedApi();
final DtoFeedRequest request = ; // DtoFeedRequest | Feed request with sections

try {
    final response = api.feedPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FeedApi->feedPost: $e\n');
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

# **placesIdViewPost**
> placesIdViewPost(id)

Increment view count for a place

Increment the view count for a specific place

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFeedApi();
final String id = id_example; // String | Place ID

try {
    api.placesIdViewPost(id);
} catch on DioException (e) {
    print('Exception when calling FeedApi->placesIdViewPost: $e\n');
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

