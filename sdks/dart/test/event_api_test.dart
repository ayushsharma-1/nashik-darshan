import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for EventApi
void main() {
  final instance = Openapi().getEventApi();

  group(EventApi, () {
    // List occurrences for event
    //
    // Get all occurrences for a specific event
    //
    //Future<BuiltList<DtoOccurrenceResponse>> eventsEventIdOccurrencesGet(String eventId) async
    test('test eventsEventIdOccurrencesGet', () async {
      // TODO
    });

    // List events
    //
    // Get a paginated list of events with filtering and pagination. Use expand=true with from_date and to_date to get expanded occurrences.
    //
    //Future<DtoListEventsResponse> eventsGet({ bool expand, String fromDate, int limit, int offset, String order, String placeId, String sort, String status, BuiltList<String> tags, String toDate, String type, bool expand2, String fromDate2, String toDate2 }) async
    test('test eventsGet', () async {
      // TODO
    });

    // Delete an event
    //
    // Soft delete an event
    //
    //Future eventsIdDelete(String id) async
    test('test eventsIdDelete', () async {
      // TODO
    });

    // Get event by ID
    //
    // Get an event by its ID
    //
    //Future<DtoEventResponse> eventsIdGet(String id) async
    test('test eventsIdGet', () async {
      // TODO
    });

    // Increment event interested count
    //
    // Increment the interested count for an event (user marked as interested)
    //
    //Future eventsIdInterestedPost(String id) async
    test('test eventsIdInterestedPost', () async {
      // TODO
    });

    // Update an event
    //
    // Update an existing event
    //
    //Future<DtoEventResponse> eventsIdPut(String id, DtoUpdateEventRequest request) async
    test('test eventsIdPut', () async {
      // TODO
    });

    // Increment event view count
    //
    // Increment the view count for an event (analytics)
    //
    //Future eventsIdViewPost(String id) async
    test('test eventsIdViewPost', () async {
      // TODO
    });

    // Delete occurrence
    //
    // Soft delete an event occurrence
    //
    //Future eventsOccurrencesIdDelete(String id) async
    test('test eventsOccurrencesIdDelete', () async {
      // TODO
    });

    // Get occurrence by ID
    //
    // Get an event occurrence by its ID
    //
    //Future<DtoOccurrenceResponse> eventsOccurrencesIdGet(String id) async
    test('test eventsOccurrencesIdGet', () async {
      // TODO
    });

    // Update occurrence
    //
    // Update an existing event occurrence
    //
    //Future<DtoOccurrenceResponse> eventsOccurrencesIdPut(String id, DtoUpdateOccurrenceRequest request) async
    test('test eventsOccurrencesIdPut', () async {
      // TODO
    });

    // Create event occurrence
    //
    // Create a new occurrence for an event
    //
    //Future<DtoOccurrenceResponse> eventsOccurrencesPost(DtoCreateOccurrenceRequest request) async
    test('test eventsOccurrencesPost', () async {
      // TODO
    });

    // Create a new event
    //
    // Create a new event with the provided details
    //
    //Future<DtoEventResponse> eventsPost(DtoCreateEventRequest request) async
    test('test eventsPost', () async {
      // TODO
    });

    // Get event by slug
    //
    // Get an event by its slug
    //
    //Future<DtoEventResponse> eventsSlugSlugGet(String slug) async
    test('test eventsSlugSlugGet', () async {
      // TODO
    });

  });
}
