import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for FeedApi
void main() {
  final instance = Openapi().getFeedApi();

  group(FeedApi, () {
    // Get feed data
    //
    // Get feed data with multiple sections (trending, popular, latest, nearby)
    //
    //Future<DtoFeedResponse> feedPost(DtoFeedRequest request) async
    test('test feedPost', () async {
      // TODO
    });

    // Increment view count for a place
    //
    // Increment the view count for a specific place
    //
    //Future placesIdViewPost(String id) async
    test('test placesIdViewPost', () async {
      // TODO
    });

  });
}
