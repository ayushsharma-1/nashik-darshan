# ReviewsApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**reviewsGet**](#reviewsget) | **GET** /reviews | List reviews|
|[**reviewsIdDelete**](#reviewsiddelete) | **DELETE** /reviews/{id} | Delete a review|
|[**reviewsIdGet**](#reviewsidget) | **GET** /reviews/{id} | Get review by ID|
|[**reviewsIdPut**](#reviewsidput) | **PUT** /reviews/{id} | Update a review|
|[**reviewsPost**](#reviewspost) | **POST** /reviews | Create a new review|
|[**reviewsStatsEntityTypeEntityIdGet**](#reviewsstatsentitytypeentityidget) | **GET** /reviews/stats/{entityType}/{entityId} | Get rating statistics|

# **reviewsGet**
> TypesListResponseDtoReviewResponse reviewsGet()

Get a paginated list of reviews with filtering

### Example

```typescript
import {
    ReviewsApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new ReviewsApi(configuration);

let limit: number; //Limit (optional) (default to undefined)
let offset: number; //Offset (optional) (default to undefined)
let entityType: string; //Entity type (place, experience, etc.) (optional) (default to undefined)
let entityId: string; //Entity ID (optional) (default to undefined)
let userId: string; //User ID (optional) (default to undefined)
let minRating: number; //Minimum rating (optional) (default to undefined)
let maxRating: number; //Maximum rating (optional) (default to undefined)

const { status, data } = await apiInstance.reviewsGet(
    limit,
    offset,
    entityType,
    entityId,
    userId,
    minRating,
    maxRating
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **limit** | [**number**] | Limit | (optional) defaults to undefined|
| **offset** | [**number**] | Offset | (optional) defaults to undefined|
| **entityType** | [**string**] | Entity type (place, experience, etc.) | (optional) defaults to undefined|
| **entityId** | [**string**] | Entity ID | (optional) defaults to undefined|
| **userId** | [**string**] | User ID | (optional) defaults to undefined|
| **minRating** | [**number**] | Minimum rating | (optional) defaults to undefined|
| **maxRating** | [**number**] | Maximum rating | (optional) defaults to undefined|


### Return type

**TypesListResponseDtoReviewResponse**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**200** | OK |  -  |
|**400** | Bad Request |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsIdDelete**
> reviewsIdDelete()

Delete a review

### Example

```typescript
import {
    ReviewsApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new ReviewsApi(configuration);

let id: string; //Review ID (default to undefined)

const { status, data } = await apiInstance.reviewsIdDelete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Review ID | defaults to undefined|


### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**204** | No Content |  -  |
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsIdGet**
> DtoReviewResponse reviewsIdGet()

Get a review by its ID

### Example

```typescript
import {
    ReviewsApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new ReviewsApi(configuration);

let id: string; //Review ID (default to undefined)

const { status, data } = await apiInstance.reviewsIdGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Review ID | defaults to undefined|


### Return type

**DtoReviewResponse**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**200** | OK |  -  |
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsIdPut**
> DtoReviewResponse reviewsIdPut(request)

Update an existing review

### Example

```typescript
import {
    ReviewsApi,
    Configuration,
    DtoUpdateReviewRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new ReviewsApi(configuration);

let id: string; //Review ID (default to undefined)
let request: DtoUpdateReviewRequest; //Update review request

const { status, data } = await apiInstance.reviewsIdPut(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdateReviewRequest**| Update review request | |
| **id** | [**string**] | Review ID | defaults to undefined|


### Return type

**DtoReviewResponse**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**200** | OK |  -  |
|**400** | Bad Request |  -  |
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsPost**
> DtoReviewResponse reviewsPost(request)

Create a new review for a place or other entity

### Example

```typescript
import {
    ReviewsApi,
    Configuration,
    DtoCreateReviewRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new ReviewsApi(configuration);

let request: DtoCreateReviewRequest; //Create review request

const { status, data } = await apiInstance.reviewsPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreateReviewRequest**| Create review request | |


### Return type

**DtoReviewResponse**

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**201** | Created |  -  |
|**400** | Bad Request |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewsStatsEntityTypeEntityIdGet**
> DtoRatingStatsResponse reviewsStatsEntityTypeEntityIdGet()

Get rating statistics for an entity (place, experience, etc.)

### Example

```typescript
import {
    ReviewsApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new ReviewsApi(configuration);

let entityType: string; //Entity type (place, experience, etc.) (default to undefined)
let entityId: string; //Entity ID (default to undefined)

const { status, data } = await apiInstance.reviewsStatsEntityTypeEntityIdGet(
    entityType,
    entityId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **entityType** | [**string**] | Entity type (place, experience, etc.) | defaults to undefined|
| **entityId** | [**string**] | Entity ID | defaults to undefined|


### Return type

**DtoRatingStatsResponse**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**200** | OK |  -  |
|**400** | Bad Request |  -  |
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

