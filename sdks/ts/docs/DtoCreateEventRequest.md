# DtoCreateEventRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**cover_image_url** | **string** |  | [optional] [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**end_date** | **string** |  | [optional] [default to undefined]
**images** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**latitude** | **number** |  | [optional] [default to undefined]
**location_name** | **string** |  | [optional] [default to undefined]
**longitude** | **number** |  | [optional] [default to undefined]
**metadata** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**place_id** | **string** |  | [optional] [default to undefined]
**slug** | **string** |  | [default to undefined]
**start_date** | **string** | Required, defaults to now() if zero value | [optional] [default to undefined]
**subtitle** | **string** |  | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**title** | **string** |  | [default to undefined]
**type** | [**TypesEventType**](TypesEventType.md) |  | [default to undefined]

## Example

```typescript
import { DtoCreateEventRequest } from './api';

const instance: DtoCreateEventRequest = {
    cover_image_url,
    description,
    end_date,
    images,
    latitude,
    location_name,
    longitude,
    metadata,
    place_id,
    slug,
    start_date,
    subtitle,
    tags,
    title,
    type,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
