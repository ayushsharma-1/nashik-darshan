# DtoFeedRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**end_time** | **string** |  | [optional] [default to undefined]
**expand** | **string** |  | [optional] [default to undefined]
**limit** | **number** |  | [optional] [default to undefined]
**offset** | **number** |  | [optional] [default to undefined]
**order** | **string** |  | [optional] [default to undefined]
**sections** | [**Array&lt;DtoFeedSectionRequest&gt;**](DtoFeedSectionRequest.md) |  | [default to undefined]
**sort** | **string** |  | [optional] [default to undefined]
**start_time** | **string** |  | [optional] [default to undefined]
**status** | [**TypesStatus**](TypesStatus.md) |  | [optional] [default to undefined]

## Example

```typescript
import { DtoFeedRequest } from './api';

const instance: DtoFeedRequest = {
    end_time,
    expand,
    limit,
    offset,
    order,
    sections,
    sort,
    start_time,
    status,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
