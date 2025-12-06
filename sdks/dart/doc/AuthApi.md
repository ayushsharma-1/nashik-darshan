# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authSignupPost**](AuthApi.md#authsignuppost) | **POST** /auth/signup | Signup


# **authSignupPost**
> DtoSignupResponse authSignupPost(signupRequest)

Signup

Signup

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final DtoSignupRequest signupRequest = ; // DtoSignupRequest | Signup request

try {
    final response = api.authSignupPost(signupRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignupPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signupRequest** | [**DtoSignupRequest**](DtoSignupRequest.md)| Signup request | 

### Return type

[**DtoSignupResponse**](DtoSignupResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

