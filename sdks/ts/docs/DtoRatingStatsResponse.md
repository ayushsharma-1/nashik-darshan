# DtoRatingStatsResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**average_rating** | **number** |  | [optional] [default to undefined]
**entity_id** | **string** |  | [optional] [default to undefined]
**entity_type** | [**TypesReviewEntityType**](TypesReviewEntityType.md) |  | [optional] [default to undefined]
**five_star_count** | **number** |  | [optional] [default to undefined]
**four_star_count** | **number** |  | [optional] [default to undefined]
**one_star_count** | **number** |  | [optional] [default to undefined]
**rating_distribution** | **{ [key: string]: number; }** | rating -&gt; count | [optional] [default to undefined]
**reviews_with_content** | **number** |  | [optional] [default to undefined]
**reviews_with_images** | **number** |  | [optional] [default to undefined]
**three_star_count** | **number** |  | [optional] [default to undefined]
**total_reviews** | **number** |  | [optional] [default to undefined]
**two_star_count** | **number** |  | [optional] [default to undefined]
**verified_reviews** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { DtoRatingStatsResponse } from './api';

const instance: DtoRatingStatsResponse = {
    average_rating,
    entity_id,
    entity_type,
    five_star_count,
    four_star_count,
    one_star_count,
    rating_distribution,
    reviews_with_content,
    reviews_with_images,
    three_star_count,
    total_reviews,
    two_star_count,
    verified_reviews,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
