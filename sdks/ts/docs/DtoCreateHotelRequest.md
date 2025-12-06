# DtoCreateHotelRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**address** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**check_in_time** | **string** |  | [optional] [default to undefined]
**check_out_time** | **string** |  | [optional] [default to undefined]
**currency** | **string** |  | [optional] [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**email** | **string** |  | [optional] [default to undefined]
**location** | [**TypesLocation**](TypesLocation.md) |  | [default to undefined]
**name** | **string** |  | [default to undefined]
**phone** | **string** |  | [optional] [default to undefined]
**price_max** | **number** |  | [optional] [default to undefined]
**price_min** | **number** |  | [optional] [default to undefined]
**primary_image_url** | **string** |  | [optional] [default to undefined]
**room_count** | **number** |  | [optional] [default to undefined]
**slug** | **string** |  | [default to undefined]
**star_rating** | **number** |  | [default to undefined]
**thumbnail_url** | **string** |  | [optional] [default to undefined]
**website** | **string** |  | [optional] [default to undefined]

## Example

```typescript
import { DtoCreateHotelRequest } from './api';

const instance: DtoCreateHotelRequest = {
    address,
    check_in_time,
    check_out_time,
    currency,
    description,
    email,
    location,
    name,
    phone,
    price_max,
    price_min,
    primary_image_url,
    room_count,
    slug,
    star_rating,
    thumbnail_url,
    website,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
