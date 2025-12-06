# DtoUpdateOccurrenceRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**day_of_month** | **number** |  | [optional] [default to undefined]
**day_of_week** | **number** |  | [optional] [default to undefined]
**end_time** | **string** | ISO 8601 format, optional/nillable | [optional] [default to undefined]
**exception_dates** | **Array&lt;string&gt;** |  | [optional] [default to undefined]
**metadata** | **{ [key: string]: string; }** |  | [optional] [default to undefined]
**month_of_year** | **number** |  | [optional] [default to undefined]
**recurrence_type** | [**TypesRecurrenceType**](TypesRecurrenceType.md) |  | [optional] [default to undefined]
**start_time** | **string** | ISO 8601 format, optional/nillable | [optional] [default to undefined]

## Example

```typescript
import { DtoUpdateOccurrenceRequest } from './api';

const instance: DtoUpdateOccurrenceRequest = {
    day_of_month,
    day_of_week,
    end_time,
    exception_dates,
    metadata,
    month_of_year,
    recurrence_type,
    start_time,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
