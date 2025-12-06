# CategoryApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**categoriesGet**](#categoriesget) | **GET** /categories | List categories|
|[**categoriesIdDelete**](#categoriesiddelete) | **DELETE** /categories/{id} | Delete a category|
|[**categoriesIdGet**](#categoriesidget) | **GET** /categories/{id} | Get category by ID|
|[**categoriesIdPut**](#categoriesidput) | **PUT** /categories/{id} | Update a category|
|[**categoriesPost**](#categoriespost) | **POST** /categories | Create a new category|
|[**categoriesSlugSlugGet**](#categoriesslugslugget) | **GET** /categories/slug/{slug} | Get category by slug|

# **categoriesGet**
> DtoListCategoriesResponse categoriesGet()

Get a paginated list of categories with filtering and pagination

### Example

```typescript
import {
    CategoryApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new CategoryApi(configuration);

let limit: number; //Limit (optional) (default to undefined)
let offset: number; //Offset (optional) (default to undefined)
let status: string; //Status (optional) (default to undefined)
let sort: string; //Sort field (optional) (default to undefined)
let order: string; //Sort order (asc/desc) (optional) (default to undefined)
let slug: Array<string>; //Filter by slugs (optional) (default to undefined)
let name: Array<string>; //Filter by names (optional) (default to undefined)

const { status, data } = await apiInstance.categoriesGet(
    limit,
    offset,
    status,
    sort,
    order,
    slug,
    name
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
| **name** | **Array&lt;string&gt;** | Filter by names | (optional) defaults to undefined|


### Return type

**DtoListCategoriesResponse**

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

# **categoriesIdDelete**
> categoriesIdDelete()

Soft delete a category

### Example

```typescript
import {
    CategoryApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new CategoryApi(configuration);

let id: string; //Category ID (default to undefined)

const { status, data } = await apiInstance.categoriesIdDelete(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Category ID | defaults to undefined|


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

# **categoriesIdGet**
> DtoCategoryResponse categoriesIdGet()

Get a category by its ID

### Example

```typescript
import {
    CategoryApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new CategoryApi(configuration);

let id: string; //Category ID (default to undefined)

const { status, data } = await apiInstance.categoriesIdGet(
    id
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **id** | [**string**] | Category ID | defaults to undefined|


### Return type

**DtoCategoryResponse**

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

# **categoriesIdPut**
> DtoCategoryResponse categoriesIdPut(request)

Update an existing category

### Example

```typescript
import {
    CategoryApi,
    Configuration,
    DtoUpdateCategoryRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new CategoryApi(configuration);

let id: string; //Category ID (default to undefined)
let request: DtoUpdateCategoryRequest; //Update category request

const { status, data } = await apiInstance.categoriesIdPut(
    id,
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoUpdateCategoryRequest**| Update category request | |
| **id** | [**string**] | Category ID | defaults to undefined|


### Return type

**DtoCategoryResponse**

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

# **categoriesPost**
> DtoCategoryResponse categoriesPost(request)

Create a new category with the provided details

### Example

```typescript
import {
    CategoryApi,
    Configuration,
    DtoCreateCategoryRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new CategoryApi(configuration);

let request: DtoCreateCategoryRequest; //Create category request

const { status, data } = await apiInstance.categoriesPost(
    request
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **request** | **DtoCreateCategoryRequest**| Create category request | |


### Return type

**DtoCategoryResponse**

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

# **categoriesSlugSlugGet**
> DtoCategoryResponse categoriesSlugSlugGet()

Get a category by its slug

### Example

```typescript
import {
    CategoryApi,
    Configuration
} from './api';

const configuration = new Configuration();
const apiInstance = new CategoryApi(configuration);

let slug: string; //Category slug (default to undefined)

const { status, data } = await apiInstance.categoriesSlugSlugGet(
    slug
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **slug** | [**string**] | Category slug | defaults to undefined|


### Return type

**DtoCategoryResponse**

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

