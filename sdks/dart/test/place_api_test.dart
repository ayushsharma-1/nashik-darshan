import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for PlaceApi
void main() {
  final instance = Openapi().getPlaceApi();

  group(PlaceApi, () {
    // List places
    //
    // Get a paginated list of places with filtering and pagination
    //
    //Future<DtoListPlacesResponse> placesGet({ int limit, int offset, String status, String sort, String order, BuiltList<String> slug, BuiltList<String> placeTypes, BuiltList<String> categories, BuiltList<String> amenities, num minRating, num maxRating, num latitude, num longitude, num radiusKm, String searchQuery }) async
    test('test placesGet', () async {
      // TODO
    });

    // Delete a place
    //
    // Soft delete a place
    //
    //Future placesIdDelete(String id) async
    test('test placesIdDelete', () async {
      // TODO
    });

    // Get place by ID
    //
    // Get a place by its ID
    //
    //Future<DtoPlaceResponse> placesIdGet(String id) async
    test('test placesIdGet', () async {
      // TODO
    });

    // Get place images
    //
    // Get all images for a place
    //
    //Future<BuiltList<DtoPlaceImageResponse>> placesIdImagesGet(String id) async
    test('test placesIdImagesGet', () async {
      // TODO
    });

    // Add image to place
    //
    // Add an image to a place
    //
    //Future<DtoPlaceImageResponse> placesIdImagesPost(String id, DtoCreatePlaceImageRequest request) async
    test('test placesIdImagesPost', () async {
      // TODO
    });

    // Update a place
    //
    // Update an existing place
    //
    //Future<DtoPlaceResponse> placesIdPut(String id, DtoUpdatePlaceRequest request) async
    test('test placesIdPut', () async {
      // TODO
    });

    // Delete place image
    //
    // Delete a place image
    //
    //Future placesImagesImageIdDelete(String imageId) async
    test('test placesImagesImageIdDelete', () async {
      // TODO
    });

    // Update place image
    //
    // Update an existing place image
    //
    //Future<DtoPlaceImageResponse> placesImagesImageIdPut(String imageId, DtoUpdatePlaceImageRequest request) async
    test('test placesImagesImageIdPut', () async {
      // TODO
    });

    // Create a new place
    //
    // Create a new place with the provided details
    //
    //Future<DtoPlaceResponse> placesPost(DtoCreatePlaceRequest request) async
    test('test placesPost', () async {
      // TODO
    });

    // Get place by slug
    //
    // Get a place by its slug
    //
    //Future<DtoPlaceResponse> placesSlugSlugGet(String slug) async
    test('test placesSlugSlugGet', () async {
      // TODO
    });

  });
}
