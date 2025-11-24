# DtoCreatePlaceRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**address** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**amenities** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**categories** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**location** | [**TypesLocation**](TypesLocation.md) |  | [default to undefined]
**long_description** | **string** |  | [optional] [default to undefined]
**place_type** | **string** |  | [default to undefined]
**primary_image_url** | **string** |  | [optional] [default to undefined]
**short_description** | **string** |  | [optional] [default to undefined]
**slug** | **string** |  | [default to undefined]
**subtitle** | **string** |  | [optional] [default to undefined]
**thumbnail_url** | **string** |  | [optional] [default to undefined]
**title** | **string** |  | [default to undefined]

## Example

```typescript
import { DtoCreatePlaceRequest } from './api';

const instance: DtoCreatePlaceRequest = {
    address,
    amenities,
    categories,
    location,
    long_description,
    place_type,
    primary_image_url,
    short_description,
    slug,
    subtitle,
    thumbnail_url,
    title,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
