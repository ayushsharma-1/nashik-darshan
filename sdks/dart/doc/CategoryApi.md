# openapi.api.CategoryApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**categoriesGet**](CategoryApi.md#categoriesget) | **GET** /categories | List categories
[**categoriesIdDelete**](CategoryApi.md#categoriesiddelete) | **DELETE** /categories/{id} | Delete a category
[**categoriesIdGet**](CategoryApi.md#categoriesidget) | **GET** /categories/{id} | Get category by ID
[**categoriesIdPut**](CategoryApi.md#categoriesidput) | **PUT** /categories/{id} | Update a category
[**categoriesPost**](CategoryApi.md#categoriespost) | **POST** /categories | Create a new category
[**categoriesSlugSlugGet**](CategoryApi.md#categoriesslugslugget) | **GET** /categories/slug/{slug} | Get category by slug


# **categoriesGet**
> DtoListCategoriesResponse categoriesGet(limit, offset, status, sort, order, slug, name)

List categories

Get a paginated list of categories with filtering and pagination

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoryApi();
final int limit = 56; // int | Limit
final int offset = 56; // int | Offset
final String status = status_example; // String | Status
final String sort = sort_example; // String | Sort field
final String order = order_example; // String | Sort order (asc/desc)
final BuiltList<String> slug = ; // BuiltList<String> | Filter by slugs
final BuiltList<String> name = ; // BuiltList<String> | Filter by names

try {
    final response = api.categoriesGet(limit, offset, status, sort, order, slug, name);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CategoryApi->categoriesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**| Limit | [optional] 
 **offset** | **int**| Offset | [optional] 
 **status** | **String**| Status | [optional] 
 **sort** | **String**| Sort field | [optional] 
 **order** | **String**| Sort order (asc/desc) | [optional] 
 **slug** | [**BuiltList&lt;String&gt;**](String.md)| Filter by slugs | [optional] 
 **name** | [**BuiltList&lt;String&gt;**](String.md)| Filter by names | [optional] 

### Return type

[**DtoListCategoriesResponse**](DtoListCategoriesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoriesIdDelete**
> categoriesIdDelete(id)

Delete a category

Soft delete a category

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getCategoryApi();
final String id = id_example; // String | Category ID

try {
    api.categoriesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling CategoryApi->categoriesIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Category ID | 

### Return type

void (empty response body)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoriesIdGet**
> DtoCategoryResponse categoriesIdGet(id)

Get category by ID

Get a category by its ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoryApi();
final String id = id_example; // String | Category ID

try {
    final response = api.categoriesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CategoryApi->categoriesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Category ID | 

### Return type

[**DtoCategoryResponse**](DtoCategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoriesIdPut**
> DtoCategoryResponse categoriesIdPut(id, request)

Update a category

Update an existing category

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getCategoryApi();
final String id = id_example; // String | Category ID
final DtoUpdateCategoryRequest request = ; // DtoUpdateCategoryRequest | Update category request

try {
    final response = api.categoriesIdPut(id, request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CategoryApi->categoriesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Category ID | 
 **request** | [**DtoUpdateCategoryRequest**](DtoUpdateCategoryRequest.md)| Update category request | 

### Return type

[**DtoCategoryResponse**](DtoCategoryResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoriesPost**
> DtoCategoryResponse categoriesPost(request)

Create a new category

Create a new category with the provided details

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Authorization
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Authorization').apiKeyPrefix = 'Bearer';

final api = Openapi().getCategoryApi();
final DtoCreateCategoryRequest request = ; // DtoCreateCategoryRequest | Create category request

try {
    final response = api.categoriesPost(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CategoryApi->categoriesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoCreateCategoryRequest**](DtoCreateCategoryRequest.md)| Create category request | 

### Return type

[**DtoCategoryResponse**](DtoCategoryResponse.md)

### Authorization

[Authorization](../README.md#Authorization)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **categoriesSlugSlugGet**
> DtoCategoryResponse categoriesSlugSlugGet(slug)

Get category by slug

Get a category by its slug

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoryApi();
final String slug = slug_example; // String | Category slug

try {
    final response = api.categoriesSlugSlugGet(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CategoryApi->categoriesSlugSlugGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Category slug | 

### Return type

[**DtoCategoryResponse**](DtoCategoryResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

