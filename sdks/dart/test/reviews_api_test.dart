import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for ReviewsApi
void main() {
  final instance = Openapi().getReviewsApi();

  group(ReviewsApi, () {
    // List reviews
    //
    // Get a paginated list of reviews with filtering
    //
    //Future<TypesListResponseDtoReviewResponse> reviewsGet({ int limit, int offset, String entityType, String entityId, String userId, num minRating, num maxRating }) async
    test('test reviewsGet', () async {
      // TODO
    });

    // Delete a review
    //
    // Delete a review
    //
    //Future reviewsIdDelete(String id) async
    test('test reviewsIdDelete', () async {
      // TODO
    });

    // Get review by ID
    //
    // Get a review by its ID
    //
    //Future<DtoReviewResponse> reviewsIdGet(String id) async
    test('test reviewsIdGet', () async {
      // TODO
    });

    // Update a review
    //
    // Update an existing review
    //
    //Future<DtoReviewResponse> reviewsIdPut(String id, DtoUpdateReviewRequest request) async
    test('test reviewsIdPut', () async {
      // TODO
    });

    // Create a new review
    //
    // Create a new review for a place or other entity
    //
    //Future<DtoReviewResponse> reviewsPost(DtoCreateReviewRequest request) async
    test('test reviewsPost', () async {
      // TODO
    });

    // Get rating statistics
    //
    // Get rating statistics for an entity (place, experience, etc.)
    //
    //Future<DtoRatingStatsResponse> reviewsStatsEntityTypeEntityIdGet(String entityType, String entityId) async
    test('test reviewsStatsEntityTypeEntityIdGet', () async {
      // TODO
    });

  });
}
