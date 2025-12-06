import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for HotelApi
void main() {
  final instance = Openapi().getHotelApi();

  group(HotelApi, () {
    // List hotels
    //
    // Get a paginated list of hotels with filtering and pagination
    //
    //Future<DtoListHotelsResponse> hotelsGet({ String endTime, String expand, String lastViewedAfter, num latitude, int limit, num longitude, num maxPrice, num minPrice, int offset, String order, num radiusM, String searchQuery, BuiltList<String> slug, String sort, BuiltList<int> starRating, String startTime, String status }) async
    test('test hotelsGet', () async {
      // TODO
    });

    // Delete a hotel
    //
    // Soft delete a hotel
    //
    //Future hotelsIdDelete(String id) async
    test('test hotelsIdDelete', () async {
      // TODO
    });

    // Get hotel by ID
    //
    // Get a hotel by its ID
    //
    //Future<DtoHotelResponse> hotelsIdGet(String id) async
    test('test hotelsIdGet', () async {
      // TODO
    });

    // Update a hotel
    //
    // Update an existing hotel
    //
    //Future<DtoHotelResponse> hotelsIdPut(String id, DtoUpdateHotelRequest request) async
    test('test hotelsIdPut', () async {
      // TODO
    });

    // Create a new hotel
    //
    // Create a new hotel with the provided details
    //
    //Future<DtoHotelResponse> hotelsPost(DtoCreateHotelRequest request) async
    test('test hotelsPost', () async {
      // TODO
    });

    // Get hotel by slug
    //
    // Get a hotel by its slug
    //
    //Future<DtoHotelResponse> hotelsSlugSlugGet(String slug) async
    test('test hotelsSlugSlugGet', () async {
      // TODO
    });

  });
}
