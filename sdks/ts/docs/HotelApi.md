# HotelApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**hotelsGet**](#hotelsget) | **GET** /hotels | List hotels|
|[**hotelsIdDelete**](#hotelsiddelete) | **DELETE** /hotels/{id} | Delete a hotel|
|[**hotelsIdGet**](#hotelsidget) | **GET** /hotels/{id} | Get hotel by ID|
|[**hotelsIdPut**](#hotelsidput) | **PUT** /hotels/{id} | Update a hotel|
|[**hotelsPost**](#hotelspost) | **POST** /hotels | Create a new hotel|
|[**hotelsSlugSlugGet**](#hotelsslugslugget) | **GET** /hotels/slug/{slug} | Get hotel by slug|

# **hotelsGet**
> DtoListHotelsResponse hotelsGet()

Get a paginated list of hotels with filtering and pagination

### Example

```typescript
import {
    HotelApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new HotelApi(configuration);

let endTime: string; // (optional) (default to undefined)
let expand: string; // (optional) (default to undefined)
let lastViewedAfter: string; //Trending filter (optional) (default to undefined)
let latitude: number; //Geospatial filters (optional) (default to undefined)
let limit: number; // (optional) (default to undefined)
let longitude: number; // (optional) (default to undefined)
let maxPrice: number; // (optional) (default to undefined)
let minPrice: number; //Price range filters (optional) (default to undefined)
let offset: number; // (optional) (default to undefined)
let order: 'asc' | 'desc'; // (optional) (default to undefined)
let radiusM: number; //radius in meters (optional) (default to undefined)
let searchQuery: string; //Search (optional) (default to undefined)
let slug: Array<string>; //Custom filters (optional) (default to undefined)
let sort: string; // (optional) (default to undefined)
let starRating: Array<number>; // (optional) (default to undefined)
let startTime: string; // (optional) (default to undefined)
let status: 'published' | 'deleted' | 'archived' | 'inactive' | 'pending' | 'draft'; // (optional) (default to undefined)

const { status, data } = await apiInstance.hotelsGet(
    endTime,
    expand,
    lastViewedAfter,
    latitude,
    limit,
    longitude,
    maxPrice,
    minPrice,
    offset,
    order,
    radiusM,
    searchQuery,
    slug,
    sort,
    starRating,
    startTime,
    status
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **endTime** | [**string**] |  | (optional) defaults to undefined|
| **expand** | [**string**] |  | (optional) defaults to undefined|
| **lastViewedAfter** | [**string**] | Trending filter | (optional) defaults to undefined|
| **latitude** | [**number**] | Geospatial filters | (optional) defaults to undefined|
| **limit** | [**number**] |  | (optional) defaults to undefined|
| **longitude** | [**number**] |  | (optional) defaults to undefined|
| **maxPrice** | [**number**] |  | (optional) defaults to undefined|
| **minPrice** | [**number**] | Price range filters | (optional) defaults to undefined|
| **offset** | [**number**] |  | (optional) defaults to undefined|
| **order** | [**&#39;asc&#39; | &#39;desc&#39;**]**Array<&#39;asc&#39; &#124; &#39;desc&#39;>** |  | (optional) defaults to undefined|
| **radiusM** | [**number**] | radius in meters | (optional) defaults to undefined|
| **searchQuery** | [**string**] | Search | (optional) defaults to undefined|
| **slug** | **Array&lt;string&gt;** | Custom filters | (optional) defaults to undefined|
| **sort** | [**string**] |  | (optional) defaults to undefined|
| **starRating** | **Array&lt;number&gt;** |  | (optional) defaults to undefined|
| **startTime** | [**string**] |  | (optional) defaults to undefined|
| **status** | [**&#39;published&#39; | &#39;deleted&#39; | &#39;archived&#39; | &#39;inactive&#39; | &#39;pending&#39; | &#39;draft&#39;**]**Array<&#39;published&#39; &#124; &#39;deleted&#39; &#124; &#39;archived&#39; &#124; &#39;inactive&#39; &#124; &#39;pending&#39; &#124; &#39;draft&#39;>** |  | (optional) defaults to undefined|


### Return type

**DtoListHotelsResponse**

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

# **hotelsIdDelete**
> hotelsIdDelete()

Soft delete a hotel

### Example

```typescript
import {
    HotelApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new HotelApi(configuration);

let id: string; //Hotel ID (default to undefined)

const { status, data } = await apiInstance.hotelsIdDelete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Hotel ID | defaults to undefined|


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

# **hotelsIdGet**
> DtoHotelResponse hotelsIdGet()

Get a hotel by its ID

### Example

```typescript
import {
    HotelApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new HotelApi(configuration);

let id: string; //Hotel ID (default to undefined)

const { status, data } = await apiInstance.hotelsIdGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Hotel ID | defaults to undefined|


### Return type

**DtoHotelResponse**

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

# **hotelsIdPut**
> DtoHotelResponse hotelsIdPut(request)

Update an existing hotel

### Example

```typescript
import {
    HotelApi,
    Configuration,
    DtoUpdateHotelRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new HotelApi(configuration);

let id: string; //Hotel ID (default to undefined)
let request: DtoUpdateHotelRequest; //Update hotel request

const { status, data } = await apiInstance.hotelsIdPut(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdateHotelRequest**| Update hotel request | |
| **id** | [**string**] | Hotel ID | defaults to undefined|


### Return type

**DtoHotelResponse**

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
|**409** | Conflict |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsPost**
> DtoHotelResponse hotelsPost(request)

Create a new hotel with the provided details

### Example

```typescript
import {
    HotelApi,
    Configuration,
    DtoCreateHotelRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new HotelApi(configuration);

let request: DtoCreateHotelRequest; //Create hotel request

const { status, data } = await apiInstance.hotelsPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreateHotelRequest**| Create hotel request | |


### Return type

**DtoHotelResponse**

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
|**409** | Conflict |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hotelsSlugSlugGet**
> DtoHotelResponse hotelsSlugSlugGet()

Get a hotel by its slug

### Example

```typescript
import {
    HotelApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new HotelApi(configuration);

let slug: string; //Hotel slug (default to undefined)

const { status, data } = await apiInstance.hotelsSlugSlugGet(
    slug
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **slug** | [**string**] | Hotel slug | defaults to undefined|


### Return type

**DtoHotelResponse**

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

