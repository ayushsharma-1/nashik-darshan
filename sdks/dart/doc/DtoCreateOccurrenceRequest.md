# openapi.model.DtoCreateOccurrenceRequest

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**dayOfMonth** | **int** | 1-31 for MONTHLY/YEARLY | [optional] 
**dayOfWeek** | **int** | 0-6 for WEEKLY | [optional] 
**endTime** | **String** | ISO 8601 format, optional/nillable | [optional] 
**eventId** | **String** |  | 
**exceptionDates** | **BuiltList&lt;String&gt;** | [\"2025-12-25\", ...] | [optional] 
**metadata** | **BuiltMap&lt;String, String&gt;** |  | [optional] 
**monthOfYear** | **int** | 1-12 for YEARLY | [optional] 
**recurrenceType** | [**TypesRecurrenceType**](TypesRecurrenceType.md) |  | 
**startTime** | **String** | ISO 8601 format, optional/nillable | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


