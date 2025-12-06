# openapi.model.DtoEventResponse

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**coverImageUrl** | **String** | Media | [optional] 
**createdAt** | **String** |  | [optional] 
**createdBy** | **String** |  | [optional] 
**description** | **String** |  | [optional] 
**endDate** | **String** |  | [optional] 
**id** | **String** | Identity | [optional] 
**images** | **BuiltList&lt;String&gt;** |  | [optional] 
**interestedCount** | **int** |  | [optional] 
**latitude** | **num** | Location (for citywide) | [optional] 
**locationName** | **String** |  | [optional] 
**longitude** | **num** |  | [optional] 
**metadata** | **BuiltMap&lt;String, String&gt;** |  | [optional] 
**occurrences** | [**BuiltList&lt;EventEventOccurrence&gt;**](EventEventOccurrence.md) | Relations (populated when needed) | [optional] 
**placeId** | **String** | Association | [optional] 
**slug** | **String** |  | [optional] 
**startDate** | **String** | Validity | [optional] 
**status** | [**TypesStatus**](TypesStatus.md) |  | [optional] 
**subtitle** | **String** |  | [optional] 
**tags** | **BuiltList&lt;String&gt;** | Metadata | [optional] 
**title** | **String** |  | [optional] 
**type** | [**TypesEventType**](TypesEventType.md) | Core | [optional] 
**updatedAt** | **String** |  | [optional] 
**updatedBy** | **String** |  | [optional] 
**viewCount** | **int** | Stats | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


