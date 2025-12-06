# DtoEventResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**cover_image_url** | **string** | Media | [optional] [default to undefined]
**created_at** | **string** |  | [optional] [default to undefined]
**created_by** | **string** |  | [optional] [default to undefined]
**description** | **string** |  | [optional] [default to undefined]
**end_date** | **string** |  | [optional] [default to undefined]
**id** | **string** | Identity | [optional] [default to undefined]
**images** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**interested_count** | **number** |  | [optional] [default to undefined]
**latitude** | **number** | Location (for citywide) | [optional] [default to undefined]
**location_name** | **string** |  | [optional] [default to undefined]
**longitude** | **number** |  | [optional] [default to undefined]
**metadata** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**occurrences** | [**Array&lt;EventEventOccurrence&gt;**](EventEventOccurrence.md) | Relations (populated when needed) | [optional] [default to undefined]
**place_id** | **string** | Association | [optional] [default to undefined]
**slug** | **string** |  | [optional] [default to undefined]
**start_date** | **string** | Validity | [optional] [default to undefined]
**status** | [**TypesStatus**](TypesStatus.md) |  | [optional] [default to undefined]
**subtitle** | **string** |  | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** | Metadata | [optional] [default to undefined]
**title** | **string** |  | [optional] [default to undefined]
**type** | [**TypesEventType**](TypesEventType.md) | Core | [optional] [default to undefined]
**updated_at** | **string** |  | [optional] [default to undefined]
**updated_by** | **string** |  | [optional] [default to undefined]
**view_count** | **number** | Stats | [optional] [default to undefined]

## Example

```typescript
import { DtoEventResponse } from './api';

const instance: DtoEventResponse = {
    cover_image_url,
    created_at,
    created_by,
    description,
    end_date,
    id,
    images,
    interested_count,
    latitude,
    location_name,
    longitude,
    metadata,
    occurrences,
    place_id,
    slug,
    start_date,
    status,
    subtitle,
    tags,
    title,
    type,
    updated_at,
    updated_by,
    view_count,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
