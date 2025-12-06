# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**userMeGet**](UserApi.md#usermeget) | **GET** /user/me | Get current user
[**userPut**](UserApi.md#userput) | **PUT** /user | Update current user


# **userMeGet**
> DtoMeResponse userMeGet()

Get current user

Get the current user's information

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();

try {
    final response = api.userMeGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userMeGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DtoMeResponse**](DtoMeResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userPut**
> DtoMeResponse userPut(request)

Update current user

Update the current user's information

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final DtoUpdateUserRequest request = ; // DtoUpdateUserRequest | Update user request

try {
    final response = api.userPut(request);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request** | [**DtoUpdateUserRequest**](DtoUpdateUserRequest.md)| Update user request | 

### Return type

[**DtoMeResponse**](DtoMeResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

