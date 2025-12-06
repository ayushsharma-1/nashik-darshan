import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:nashik_darshan_sdk/nashik_darshan_sdk.dart';

void main() async {
  // Initialize the SDK
  final openapi = Openapi(
    dio: Dio(),
    basePathOverride: 'https://api.example.com/api/v1',
  );

  // Get API clients
  openapi.getAuthApi();
  final placeApi = openapi.getPlaceApi();
  final feedApi = openapi.getFeedApi();

  print('Nashik Darshan SDK Example');
  print('==========================\n');

  // Example: Get places
  try {
    print('Fetching places...');
    final placesResponse = await placeApi.placesGet(
      limit: 5,
      offset: 0,
      status: 'published',
    );

    if (placesResponse.data?.items != null) {
      print('Found ${placesResponse.data!.items!.length} places:');
      for (final place in placesResponse.data!.items!) {
        print('  - ${place.title} (${place.placeType})');
      }
    }
  } catch (e) {
    print('Error fetching places: $e');
  }

  // Example: Search places
  try {
    print('\nSearching for hotels...');
    final searchResponse = await placeApi.placesGet(
      searchQuery: 'hotel',
      placeTypes: BuiltList.of(['hotel']),
      limit: 3,
    );

    if (searchResponse.data?.items != null) {
      print('Found ${searchResponse.data!.items!.length} hotels:');
      for (final place in searchResponse.data!.items!) {
        print('  - ${place.title}');
        if (place.ratingAvg != null) {
          print('    Rating: ${place.ratingAvg}/5');
        }
      }
    }
  } catch (e) {
    print('Error searching places: $e');
  }

  // Example: Get feed data
  try {
    print('\nFetching feed data...');
    final feedRequest = DtoFeedRequest(
      (b) => b
        ..sections.replace([
          DtoFeedSectionRequest((b) => b
            ..type = TypesFeedSectionType.SectionTypeLatest
            ..limit = 5),
          DtoFeedSectionRequest((b) => b
            ..type = TypesFeedSectionType.SectionTypePopular
            ..limit = 5),
        ]),
    );

    final feedResponse = await feedApi.feedPost(request: feedRequest);

    if (feedResponse.data?.sections != null) {
      print('Feed sections:');
      for (final section in feedResponse.data!.sections!) {
        print('  - ${section.type}: ${section.items?.length ?? 0} items');
      }
    }
  } catch (e) {
    print('Error fetching feed: $e');
  }

  print('\nExample completed!');
}
