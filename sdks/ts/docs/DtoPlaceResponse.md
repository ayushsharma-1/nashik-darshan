# DtoPlaceResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**address** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**amenities** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**categories** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**created_at** | **string** |  | [optional] [default to undefined]
**created_by** | **string** |  | [optional] [default to undefined]
**id** | **string** |  | [optional] [default to undefined]
**images** | [**Array&lt;DtoPlaceImageResponse&gt;**](DtoPlaceImageResponse.md) |  | [optional] [default to undefined]
**last_viewed_at** | **string** |  | [optional] [default to undefined]
**location** | [**TypesLocation**](TypesLocation.md) |  | [optional] [default to undefined]
**long_description** | **string** |  | [optional] [default to undefined]
**place_type** | **string** |  | [optional] [default to undefined]
**popularity_score** | **number** |  | [optional] [default to undefined]
**primary_image_url** | **string** |  | [optional] [default to undefined]
**rating_avg** | **number** |  | [optional] [default to undefined]
**rating_count** | **number** |  | [optional] [default to undefined]
**short_description** | **string** |  | [optional] [default to undefined]
**slug** | **string** |  | [optional] [default to undefined]
**status** | [**TypesStatus**](TypesStatus.md) |  | [optional] [default to undefined]
**subtitle** | **string** |  | [optional] [default to undefined]
**thumbnail_url** | **string** |  | [optional] [default to undefined]
**title** | **string** |  | [optional] [default to undefined]
**updated_at** | **string** |  | [optional] [default to undefined]
**updated_by** | **string** |  | [optional] [default to undefined]
**view_count** | **number** | Engagement fields for feed functionality | [optional] [default to undefined]

## Example

```typescript
import { DtoPlaceResponse } from './api';

const instance: DtoPlaceResponse = {
    address,
    amenities,
    categories,
    created_at,
    created_by,
    id,
    images,
    last_viewed_at,
    location,
    long_description,
    place_type,
    popularity_score,
    primary_image_url,
    rating_avg,
    rating_count,
    short_description,
    slug,
    status,
    subtitle,
    thumbnail_url,
    title,
    updated_at,
    updated_by,
    view_count,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
