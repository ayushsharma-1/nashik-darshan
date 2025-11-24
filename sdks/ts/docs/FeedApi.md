# FeedApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**feedPost**](#feedpost) | **POST** /feed | Get feed data|
|[**placesIdViewPost**](#placesidviewpost) | **POST** /places/{id}/view | Increment view count for a place|

# **feedPost**
> DtoFeedResponse feedPost(request)

Get feed data with multiple sections (trending, popular, latest, nearby)

### Example

```typescript
import {
    FeedApi,
    Configuration,
    DtoFeedRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new FeedApi(configuration);

let request: DtoFeedRequest; //Feed request with sections

const { status, data } = await apiInstance.feedPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoFeedRequest**| Feed request with sections | |


### Return type

**DtoFeedResponse**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**200** | OK |  -  |
|**400** | Bad Request |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdViewPost**
> placesIdViewPost()

Increment the view count for a specific place

### Example

```typescript
import {
    FeedApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new FeedApi(configuration);

let id: string; //Place ID (default to undefined)

const { status, data } = await apiInstance.placesIdViewPost(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Place ID | defaults to undefined|


### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**204** | No Content |  -  |
|**400** | Bad Request |  -  |
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

