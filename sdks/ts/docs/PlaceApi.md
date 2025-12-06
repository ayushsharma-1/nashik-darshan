# PlaceApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**feedPost**](#feedpost) | **POST** /feed | Get feed data|
|[**placesGet**](#placesget) | **GET** /places | List places|
|[**placesIdDelete**](#placesiddelete) | **DELETE** /places/{id} | Delete a place|
|[**placesIdGet**](#placesidget) | **GET** /places/{id} | Get place by ID|
|[**placesIdImagesGet**](#placesidimagesget) | **GET** /places/{id}/images | Get place images|
|[**placesIdImagesPost**](#placesidimagespost) | **POST** /places/{id}/images | Add image to place|
|[**placesIdPut**](#placesidput) | **PUT** /places/{id} | Update a place|
|[**placesIdViewPost**](#placesidviewpost) | **POST** /places/{id}/view | Increment view count for a place|
|[**placesImagesImageIdDelete**](#placesimagesimageiddelete) | **DELETE** /places/images/{image_id} | Delete place image|
|[**placesImagesImageIdPut**](#placesimagesimageidput) | **PUT** /places/images/{image_id} | Update place image|
|[**placesPost**](#placespost) | **POST** /places | Create a new place|
|[**placesSlugSlugGet**](#placesslugslugget) | **GET** /places/slug/{slug} | Get place by slug|

# **feedPost**
> DtoFeedResponse feedPost(request)

Get feed data with multiple sections (trending, popular, latest, nearby)

### Example

```typescript
import {
    PlaceApi,
    Configuration,
    DtoFeedRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

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

# **placesGet**
> DtoListPlacesResponse placesGet()

Get a paginated list of places with filtering and pagination

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let limit: number; //Limit (optional) (default to undefined)
let offset: number; //Offset (optional) (default to undefined)
let status: string; //Status (optional) (default to undefined)
let sort: string; //Sort field (optional) (default to undefined)
let order: string; //Sort order (asc/desc) (optional) (default to undefined)
let slug: Array<string>; //Filter by slugs (optional) (default to undefined)
let placeTypes: Array<string>; //Filter by place types (optional) (default to undefined)
let categories: Array<string>; //Filter by categories (optional) (default to undefined)
let amenities: Array<string>; //Filter by amenities (optional) (default to undefined)
let minRating: number; //Minimum rating (optional) (default to undefined)
let maxRating: number; //Maximum rating (optional) (default to undefined)
let latitude: number; //Latitude for geospatial filtering (optional) (default to undefined)
let longitude: number; //Longitude for geospatial filtering (optional) (default to undefined)
let radiusKm: number; //Radius in kilometers for geospatial filtering (optional) (default to undefined)
let searchQuery: string; //Search query (optional) (default to undefined)

const { status, data } = await apiInstance.placesGet(
    limit,
    offset,
    status,
    sort,
    order,
    slug,
    placeTypes,
    categories,
    amenities,
    minRating,
    maxRating,
    latitude,
    longitude,
    radiusKm,
    searchQuery
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **limit** | [**number**] | Limit | (optional) defaults to undefined|
| **offset** | [**number**] | Offset | (optional) defaults to undefined|
| **status** | [**string**] | Status | (optional) defaults to undefined|
| **sort** | [**string**] | Sort field | (optional) defaults to undefined|
| **order** | [**string**] | Sort order (asc/desc) | (optional) defaults to undefined|
| **slug** | **Array&lt;string&gt;** | Filter by slugs | (optional) defaults to undefined|
| **placeTypes** | **Array&lt;string&gt;** | Filter by place types | (optional) defaults to undefined|
| **categories** | **Array&lt;string&gt;** | Filter by categories | (optional) defaults to undefined|
| **amenities** | **Array&lt;string&gt;** | Filter by amenities | (optional) defaults to undefined|
| **minRating** | [**number**] | Minimum rating | (optional) defaults to undefined|
| **maxRating** | [**number**] | Maximum rating | (optional) defaults to undefined|
| **latitude** | [**number**] | Latitude for geospatial filtering | (optional) defaults to undefined|
| **longitude** | [**number**] | Longitude for geospatial filtering | (optional) defaults to undefined|
| **radiusKm** | [**number**] | Radius in kilometers for geospatial filtering | (optional) defaults to undefined|
| **searchQuery** | [**string**] | Search query | (optional) defaults to undefined|


### Return type

**DtoListPlacesResponse**

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

# **placesIdDelete**
> placesIdDelete()

Soft delete a place

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let id: string; //Place ID (default to undefined)

const { status, data } = await apiInstance.placesIdDelete(
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

# **placesIdGet**
> DtoPlaceResponse placesIdGet()

Get a place by its ID

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let id: string; //Place ID (default to undefined)

const { status, data } = await apiInstance.placesIdGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Place ID | defaults to undefined|


### Return type

**DtoPlaceResponse**

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

# **placesIdImagesGet**
> Array<DtoPlaceImageResponse> placesIdImagesGet()

Get all images for a place

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let id: string; //Place ID (default to undefined)

const { status, data } = await apiInstance.placesIdImagesGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Place ID | defaults to undefined|


### Return type

**Array<DtoPlaceImageResponse>**

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

# **placesIdImagesPost**
> DtoPlaceImageResponse placesIdImagesPost(request)

Add an image to a place

### Example

```typescript
import {
    PlaceApi,
    Configuration,
    DtoCreatePlaceImageRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let id: string; //Place ID (default to undefined)
let request: DtoCreatePlaceImageRequest; //Create place image request

const { status, data } = await apiInstance.placesIdImagesPost(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreatePlaceImageRequest**| Create place image request | |
| **id** | [**string**] | Place ID | defaults to undefined|


### Return type

**DtoPlaceImageResponse**

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
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **placesIdPut**
> DtoPlaceResponse placesIdPut(request)

Update an existing place

### Example

```typescript
import {
    PlaceApi,
    Configuration,
    DtoUpdatePlaceRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let id: string; //Place ID (default to undefined)
let request: DtoUpdatePlaceRequest; //Update place request

const { status, data } = await apiInstance.placesIdPut(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdatePlaceRequest**| Update place request | |
| **id** | [**string**] | Place ID | defaults to undefined|


### Return type

**DtoPlaceResponse**

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

# **placesIdViewPost**
> placesIdViewPost()

Increment the view count for a specific place

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

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

# **placesImagesImageIdDelete**
> placesImagesImageIdDelete()

Delete a place image

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let imageId: string; //Image ID (default to undefined)

const { status, data } = await apiInstance.placesImagesImageIdDelete(
    imageId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **imageId** | [**string**] | Image ID | defaults to undefined|


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

# **placesImagesImageIdPut**
> DtoPlaceImageResponse placesImagesImageIdPut(request)

Update an existing place image

### Example

```typescript
import {
    PlaceApi,
    Configuration,
    DtoUpdatePlaceImageRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let imageId: string; //Image ID (default to undefined)
let request: DtoUpdatePlaceImageRequest; //Update place image request

const { status, data } = await apiInstance.placesImagesImageIdPut(
    imageId,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdatePlaceImageRequest**| Update place image request | |
| **imageId** | [**string**] | Image ID | defaults to undefined|


### Return type

**DtoPlaceImageResponse**

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

# **placesPost**
> DtoPlaceResponse placesPost(request)

Create a new place with the provided details

### Example

```typescript
import {
    PlaceApi,
    Configuration,
    DtoCreatePlaceRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let request: DtoCreatePlaceRequest; //Create place request

const { status, data } = await apiInstance.placesPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreatePlaceRequest**| Create place request | |


### Return type

**DtoPlaceResponse**

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

# **placesSlugSlugGet**
> DtoPlaceResponse placesSlugSlugGet()

Get a place by its slug

### Example

```typescript
import {
    PlaceApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new PlaceApi(configuration);

let slug: string; //Place slug (default to undefined)

const { status, data } = await apiInstance.placesSlugSlugGet(
    slug
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **slug** | [**string**] | Place slug | defaults to undefined|


### Return type

**DtoPlaceResponse**

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

