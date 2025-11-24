# AuthApi

All URIs are relative to *http://localhost:8080/api/v1*

|Method | HTTP request | Description|
|------------- | ------------- | -------------|
|[**authSignupPost**](#authsignuppost) | **POST** /auth/signup | Signup|

# **authSignupPost**
> DtoSignupResponse authSignupPost(signupRequest)

Signup

### Example

```typescript
import {
    AuthApi,
    Configuration,
    DtoSignupRequest
} from './api';

const configuration = new Configuration();
const apiInstance = new AuthApi(configuration);

let signupRequest: DtoSignupRequest; //Signup request

const { status, data } = await apiInstance.authSignupPost(
    signupRequest
);
```

### Parameters

|Name | Type | Description  | Notes|
|------------- | ------------- | ------------- | -------------|
| **signupRequest** | **DtoSignupRequest**| Signup request | |


### Return type

**DtoSignupResponse**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
|**201** | Created |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

