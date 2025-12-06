# DtoFeedSectionRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**end_time** | **string** |  | [optional] [default to undefined]
**expand** | **string** |  | [optional] [default to undefined]
**latitude** | **number** | Geospatial fields (for nearby section) | [optional] [default to undefined]
**limit** | **number** |  | [optional] [default to undefined]
**longitude** | **number** |  | [optional] [default to undefined]
**offset** | **number** |  | [optional] [default to undefined]
**order** | **string** |  | [optional] [default to undefined]
**radius_km** | **number** |  | [optional] [default to undefined]
**sort** | **string** |  | [optional] [default to undefined]
**start_time** | **string** |  | [optional] [default to undefined]
**status** | [**TypesStatus**](TypesStatus.md) |  | [optional] [default to undefined]
**type** | [**TypesFeedSectionType**](TypesFeedSectionType.md) |  | [default to undefined]

## Example

```typescript
import { DtoFeedSectionRequest } from './api';

const instance: DtoFeedSectionRequest = {
    end_time,
    expand,
    latitude,
    limit,
    longitude,
    offset,
    order,
    radius_km,
    sort,
    start_time,
    status,
    type,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
