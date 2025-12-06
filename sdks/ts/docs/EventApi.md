# EventApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**eventsEventIdOccurrencesGet**](#eventseventidoccurrencesget) | **GET** /events/{eventId}/occurrences | List occurrences for event|
|[**eventsGet**](#eventsget) | **GET** /events | List events|
|[**eventsIdDelete**](#eventsiddelete) | **DELETE** /events/{id} | Delete an event|
|[**eventsIdGet**](#eventsidget) | **GET** /events/{id} | Get event by ID|
|[**eventsIdInterestedPost**](#eventsidinterestedpost) | **POST** /events/{id}/interested | Increment event interested count|
|[**eventsIdPut**](#eventsidput) | **PUT** /events/{id} | Update an event|
|[**eventsIdViewPost**](#eventsidviewpost) | **POST** /events/{id}/view | Increment event view count|
|[**eventsOccurrencesIdDelete**](#eventsoccurrencesiddelete) | **DELETE** /events/occurrences/{id} | Delete occurrence|
|[**eventsOccurrencesIdGet**](#eventsoccurrencesidget) | **GET** /events/occurrences/{id} | Get occurrence by ID|
|[**eventsOccurrencesIdPut**](#eventsoccurrencesidput) | **PUT** /events/occurrences/{id} | Update occurrence|
|[**eventsOccurrencesPost**](#eventsoccurrencespost) | **POST** /events/occurrences | Create event occurrence|
|[**eventsPost**](#eventspost) | **POST** /events | Create a new event|
|[**eventsSlugSlugGet**](#eventsslugslugget) | **GET** /events/slug/{slug} | Get event by slug|

# **eventsEventIdOccurrencesGet**
> Array<DtoOccurrenceResponse> eventsEventIdOccurrencesGet()

Get all occurrences for a specific event

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let eventId: string; //Event ID (default to undefined)

const { status, data } = await apiInstance.eventsEventIdOccurrencesGet(
    eventId
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **eventId** | [**string**] | Event ID | defaults to undefined|


### Return type

**Array<DtoOccurrenceResponse>**

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

# **eventsGet**
> DtoListEventsResponse eventsGet()

Get a paginated list of events with filtering and pagination. Use expand=true with from_date and to_date to get expanded occurrences.

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let expand: boolean; //If true, expand occurrences in date range (optional) (default to undefined)
let fromDate: string; //ISO date YYYY-MM-DD (optional) (default to undefined)
let limit: number; // (optional) (default to undefined)
let offset: number; // (optional) (default to undefined)
let order: 'asc' | 'desc'; // (optional) (default to undefined)
let placeId: string; // (optional) (default to undefined)
let sort: string; // (optional) (default to undefined)
let status: 'published' | 'deleted' | 'archived' | 'inactive' | 'pending' | 'draft'; // (optional) (default to undefined)
let tags: Array<string>; // (optional) (default to undefined)
let toDate: string; //ISO date YYYY-MM-DD (optional) (default to undefined)
let type: 'AARTI' | 'FESTIVAL' | 'CULTURAL' | 'WORKSHOP' | 'SPECIAL_DARSHAN'; // (optional) (default to undefined)
let expand2: boolean; //Expand occurrences in date range (optional) (default to undefined)
let fromDate2: string; //Start date for expansion (YYYY-MM-DD) (optional) (default to undefined)
let toDate2: string; //End date for expansion (YYYY-MM-DD) (optional) (default to undefined)

const { status, data } = await apiInstance.eventsGet(
    expand,
    fromDate,
    limit,
    offset,
    order,
    placeId,
    sort,
    status,
    tags,
    toDate,
    type,
    expand2,
    fromDate2,
    toDate2
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **expand** | [**boolean**] | If true, expand occurrences in date range | (optional) defaults to undefined|
| **fromDate** | [**string**] | ISO date YYYY-MM-DD | (optional) defaults to undefined|
| **limit** | [**number**] |  | (optional) defaults to undefined|
| **offset** | [**number**] |  | (optional) defaults to undefined|
| **order** | [**&#39;asc&#39; | &#39;desc&#39;**]**Array<&#39;asc&#39; &#124; &#39;desc&#39;>** |  | (optional) defaults to undefined|
| **placeId** | [**string**] |  | (optional) defaults to undefined|
| **sort** | [**string**] |  | (optional) defaults to undefined|
| **status** | [**&#39;published&#39; | &#39;deleted&#39; | &#39;archived&#39; | &#39;inactive&#39; | &#39;pending&#39; | &#39;draft&#39;**]**Array<&#39;published&#39; &#124; &#39;deleted&#39; &#124; &#39;archived&#39; &#124; &#39;inactive&#39; &#124; &#39;pending&#39; &#124; &#39;draft&#39;>** |  | (optional) defaults to undefined|
| **tags** | **Array&lt;string&gt;** |  | (optional) defaults to undefined|
| **toDate** | [**string**] | ISO date YYYY-MM-DD | (optional) defaults to undefined|
| **type** | [**&#39;AARTI&#39; | &#39;FESTIVAL&#39; | &#39;CULTURAL&#39; | &#39;WORKSHOP&#39; | &#39;SPECIAL_DARSHAN&#39;**]**Array<&#39;AARTI&#39; &#124; &#39;FESTIVAL&#39; &#124; &#39;CULTURAL&#39; &#124; &#39;WORKSHOP&#39; &#124; &#39;SPECIAL_DARSHAN&#39;>** |  | (optional) defaults to undefined|
| **expand2** | [**boolean**] | Expand occurrences in date range | (optional) defaults to undefined|
| **fromDate2** | [**string**] | Start date for expansion (YYYY-MM-DD) | (optional) defaults to undefined|
| **toDate2** | [**string**] | End date for expansion (YYYY-MM-DD) | (optional) defaults to undefined|


### Return type

**DtoListEventsResponse**

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

# **eventsIdDelete**
> eventsIdDelete()

Soft delete an event

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Event ID (default to undefined)

const { status, data } = await apiInstance.eventsIdDelete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Event ID | defaults to undefined|


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

# **eventsIdGet**
> DtoEventResponse eventsIdGet()

Get an event by its ID

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Event ID (default to undefined)

const { status, data } = await apiInstance.eventsIdGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Event ID | defaults to undefined|


### Return type

**DtoEventResponse**

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

# **eventsIdInterestedPost**
> eventsIdInterestedPost()

Increment the interested count for an event (user marked as interested)

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Event ID (default to undefined)

const { status, data } = await apiInstance.eventsIdInterestedPost(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Event ID | defaults to undefined|


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
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsIdPut**
> DtoEventResponse eventsIdPut(request)

Update an existing event

### Example

```typescript
import {
    EventApi,
    Configuration,
    DtoUpdateEventRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Event ID (default to undefined)
let request: DtoUpdateEventRequest; //Update event request

const { status, data } = await apiInstance.eventsIdPut(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdateEventRequest**| Update event request | |
| **id** | [**string**] | Event ID | defaults to undefined|


### Return type

**DtoEventResponse**

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

# **eventsIdViewPost**
> eventsIdViewPost()

Increment the view count for an event (analytics)

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Event ID (default to undefined)

const { status, data } = await apiInstance.eventsIdViewPost(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Event ID | defaults to undefined|


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
|**404** | Not Found |  -  |
|**500** | Internal Server Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **eventsOccurrencesIdDelete**
> eventsOccurrencesIdDelete()

Soft delete an event occurrence

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Occurrence ID (default to undefined)

const { status, data } = await apiInstance.eventsOccurrencesIdDelete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Occurrence ID | defaults to undefined|


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

# **eventsOccurrencesIdGet**
> DtoOccurrenceResponse eventsOccurrencesIdGet()

Get an event occurrence by its ID

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Occurrence ID (default to undefined)

const { status, data } = await apiInstance.eventsOccurrencesIdGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Occurrence ID | defaults to undefined|


### Return type

**DtoOccurrenceResponse**

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

# **eventsOccurrencesIdPut**
> DtoOccurrenceResponse eventsOccurrencesIdPut(request)

Update an existing event occurrence

### Example

```typescript
import {
    EventApi,
    Configuration,
    DtoUpdateOccurrenceRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let id: string; //Occurrence ID (default to undefined)
let request: DtoUpdateOccurrenceRequest; //Update occurrence request

const { status, data } = await apiInstance.eventsOccurrencesIdPut(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdateOccurrenceRequest**| Update occurrence request | |
| **id** | [**string**] | Occurrence ID | defaults to undefined|


### Return type

**DtoOccurrenceResponse**

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

# **eventsOccurrencesPost**
> DtoOccurrenceResponse eventsOccurrencesPost(request)

Create a new occurrence for an event

### Example

```typescript
import {
    EventApi,
    Configuration,
    DtoCreateOccurrenceRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let request: DtoCreateOccurrenceRequest; //Create occurrence request

const { status, data } = await apiInstance.eventsOccurrencesPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreateOccurrenceRequest**| Create occurrence request | |


### Return type

**DtoOccurrenceResponse**

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

# **eventsPost**
> DtoEventResponse eventsPost(request)

Create a new event with the provided details

### Example

```typescript
import {
    EventApi,
    Configuration,
    DtoCreateEventRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let request: DtoCreateEventRequest; //Create event request

const { status, data } = await apiInstance.eventsPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreateEventRequest**| Create event request | |


### Return type

**DtoEventResponse**

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

# **eventsSlugSlugGet**
> DtoEventResponse eventsSlugSlugGet()

Get an event by its slug

### Example

```typescript
import {
    EventApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new EventApi(configuration);

let slug: string; //Event slug (default to undefined)

const { status, data } = await apiInstance.eventsSlugSlugGet(
    slug
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **slug** | [**string**] | Event slug | defaults to undefined|


### Return type

**DtoEventResponse**

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

