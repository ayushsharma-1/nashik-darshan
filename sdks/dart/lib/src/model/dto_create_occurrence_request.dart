//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_recurrence_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_create_occurrence_request.g.dart';

/// DtoCreateOccurrenceRequest
///
/// Properties:
/// * [dayOfMonth] - 1-31 for MONTHLY/YEARLY
/// * [dayOfWeek] - 0-6 for WEEKLY
/// * [endTime] - ISO 8601 format, optional/nillable
/// * [eventId] 
/// * [exceptionDates] - [\"2025-12-25\", ...]
/// * [metadata] 
/// * [monthOfYear] - 1-12 for YEARLY
/// * [recurrenceType] 
/// * [startTime] - ISO 8601 format, optional/nillable
@BuiltValue()
abstract class DtoCreateOccurrenceRequest implements Built<DtoCreateOccurrenceRequest, DtoCreateOccurrenceRequestBuilder> {
  /// 1-31 for MONTHLY/YEARLY
  @BuiltValueField(wireName: r'day_of_month')
  int? get dayOfMonth;

  /// 0-6 for WEEKLY
  @BuiltValueField(wireName: r'day_of_week')
  int? get dayOfWeek;

  /// ISO 8601 format, optional/nillable
  @BuiltValueField(wireName: r'end_time')
  String? get endTime;

  @BuiltValueField(wireName: r'event_id')
  String get eventId;

  /// [\"2025-12-25\", ...]
  @BuiltValueField(wireName: r'exception_dates')
  BuiltList<String>? get exceptionDates;

  @BuiltValueField(wireName: r'metadata')
  BuiltMap<String, String>? get metadata;

  /// 1-12 for YEARLY
  @BuiltValueField(wireName: r'month_of_year')
  int? get monthOfYear;

  @BuiltValueField(wireName: r'recurrence_type')
  TypesRecurrenceType get recurrenceType;
  // enum recurrenceTypeEnum {  NONE,  DAILY,  WEEKLY,  MONTHLY,  YEARLY,  };

  /// ISO 8601 format, optional/nillable
  @BuiltValueField(wireName: r'start_time')
  String? get startTime;

  DtoCreateOccurrenceRequest._();

  factory DtoCreateOccurrenceRequest([void updates(DtoCreateOccurrenceRequestBuilder b)]) = _$DtoCreateOccurrenceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoCreateOccurrenceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoCreateOccurrenceRequest> get serializer => _$DtoCreateOccurrenceRequestSerializer();
}

class _$DtoCreateOccurrenceRequestSerializer implements PrimitiveSerializer<DtoCreateOccurrenceRequest> {
  @override
  final Iterable<Type> types = const [DtoCreateOccurrenceRequest, _$DtoCreateOccurrenceRequest];

  @override
  final String wireName = r'DtoCreateOccurrenceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoCreateOccurrenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.dayOfMonth != null) {
      yield r'day_of_month';
      yield serializers.serialize(
        object.dayOfMonth,
        specifiedType: const FullType(int),
      );
    }
    if (object.dayOfWeek != null) {
      yield r'day_of_week';
      yield serializers.serialize(
        object.dayOfWeek,
        specifiedType: const FullType(int),
      );
    }
    if (object.endTime != null) {
      yield r'end_time';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(String),
      );
    }
    yield r'event_id';
    yield serializers.serialize(
      object.eventId,
      specifiedType: const FullType(String),
    );
    if (object.exceptionDates != null) {
      yield r'exception_dates';
      yield serializers.serialize(
        object.exceptionDates,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.metadata != null) {
      yield r'metadata';
      yield serializers.serialize(
        object.metadata,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.monthOfYear != null) {
      yield r'month_of_year';
      yield serializers.serialize(
        object.monthOfYear,
        specifiedType: const FullType(int),
      );
    }
    yield r'recurrence_type';
    yield serializers.serialize(
      object.recurrenceType,
      specifiedType: const FullType(TypesRecurrenceType),
    );
    if (object.startTime != null) {
      yield r'start_time';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoCreateOccurrenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoCreateOccurrenceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'day_of_month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dayOfMonth = valueDes;
          break;
        case r'day_of_week':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dayOfWeek = valueDes;
          break;
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endTime = valueDes;
          break;
        case r'event_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.eventId = valueDes;
          break;
        case r'exception_dates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.exceptionDates.replace(valueDes);
          break;
        case r'metadata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>;
          result.metadata.replace(valueDes);
          break;
        case r'month_of_year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.monthOfYear = valueDes;
          break;
        case r'recurrence_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesRecurrenceType),
          ) as TypesRecurrenceType;
          result.recurrenceType = valueDes;
          break;
        case r'start_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.startTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoCreateOccurrenceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoCreateOccurrenceRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

