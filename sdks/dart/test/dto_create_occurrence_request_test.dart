import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';

// tests for DtoCreateOccurrenceRequest
void main() {
  final instance = DtoCreateOccurrenceRequestBuilder();
  // TODO add properties to the builder and call build()

  group(DtoCreateOccurrenceRequest, () {
    // 1-31 for MONTHLY/YEARLY
    // int dayOfMonth
    test('to test the property `dayOfMonth`', () async {
      // TODO
    });

    // 0-6 for WEEKLY
    // int dayOfWeek
    test('to test the property `dayOfWeek`', () async {
      // TODO
    });

    // ISO 8601 format, optional/nillable
    // String endTime
    test('to test the property `endTime`', () async {
      // TODO
    });

    // String eventId
    test('to test the property `eventId`', () async {
      // TODO
    });

    // [\"2025-12-25\", ...]
    // BuiltList<String> exceptionDates
    test('to test the property `exceptionDates`', () async {
      // TODO
    });

    // BuiltMap<String, String> metadata
    test('to test the property `metadata`', () async {
      // TODO
    });

    // 1-12 for YEARLY
    // int monthOfYear
    test('to test the property `monthOfYear`', () async {
      // TODO
    });

    // TypesRecurrenceType recurrenceType
    test('to test the property `recurrenceType`', () async {
      // TODO
    });

    // ISO 8601 format, optional/nillable
    // String startTime
    test('to test the property `startTime`', () async {
      // TODO
    });

  });
}
