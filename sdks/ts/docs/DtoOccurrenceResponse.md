# DtoOccurrenceResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**created_at** | **string** |  | [optional] [default to undefined]
**created_by** | **string** |  | [optional] [default to undefined]
**day_of_month** | **number** | 1-31 | [optional] [default to undefined]
**day_of_week** | **number** | Day specifics | [optional] [default to undefined]
**duration_minutes** | **number** |  | [optional] [default to undefined]
**end_time** | **string** |  | [optional] [default to undefined]
**event_id** | **string** |  | [optional] [default to undefined]
**exception_dates** | **Array&lt;string&gt;** | Exceptions | [optional] [default to undefined]
**id** | **string** | Identity | [optional] [default to undefined]
**metadata** | **{ [key: string]: string; }** | Metadata | [optional] [default to undefined]
**month_of_year** | **number** | 1-12 (renamed from Month) | [optional] [default to undefined]
**recurrence_type** | [**TypesRecurrenceType**](TypesRecurrenceType.md) | Recurrence | [optional] [default to undefined]
**start_time** | **string** | Time | [optional] [default to undefined]
**status** | [**TypesStatus**](TypesStatus.md) |  | [optional] [default to undefined]
**updated_at** | **string** |  | [optional] [default to undefined]
**updated_by** | **string** |  | [optional] [default to undefined]

## Example

```typescript
import { DtoOccurrenceResponse } from './api';

const instance: DtoOccurrenceResponse = {
    created_at,
    created_by,
    day_of_month,
    day_of_week,
    duration_minutes,
    end_time,
    event_id,
    exception_dates,
    id,
    metadata,
    month_of_year,
    recurrence_type,
    start_time,
    status,
    updated_at,
    updated_by,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
