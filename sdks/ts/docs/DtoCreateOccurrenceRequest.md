# DtoCreateOccurrenceRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**day_of_month** | **number** | 1-31 for MONTHLY/YEARLY | [optional] [default to undefined]
**day_of_week** | **number** | 0-6 for WEEKLY | [optional] [default to undefined]
**end_time** | **string** | ISO 8601 format, optional/nillable | [optional] [default to undefined]
**event_id** | **string** |  | [default to undefined]
**exception_dates** | **Array&lt;string&gt;** | [\&quot;2025-12-25\&quot;, ...] | [optional] [default to undefined]
**metadata** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**month_of_year** | **number** | 1-12 for YEARLY | [optional] [default to undefined]
**recurrence_type** | [**TypesRecurrenceType**](TypesRecurrenceType.md) |  | [default to undefined]
**start_time** | **string** | ISO 8601 format, optional/nillable | [optional] [default to undefined]

## Example

```typescript
import { DtoCreateOccurrenceRequest } from './api';

const instance: DtoCreateOccurrenceRequest = {
    day_of_month,
    day_of_week,
    end_time,
    event_id,
    exception_dates,
    metadata,
    month_of_year,
    recurrence_type,
    start_time,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
