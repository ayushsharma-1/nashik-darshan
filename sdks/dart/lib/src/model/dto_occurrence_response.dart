//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_recurrence_type.dart';
import 'package:nashik_darshan_sdk/src/model/types_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_occurrence_response.g.dart';

/// DtoOccurrenceResponse
///
/// Properties:
/// * [createdAt] 
/// * [createdBy] 
/// * [dayOfMonth] - 1-31
/// * [dayOfWeek] - Day specifics
/// * [durationMinutes] 
/// * [endTime] 
/// * [eventId] 
/// * [exceptionDates] - Exceptions
/// * [id] - Identity
/// * [metadata] - Metadata
/// * [monthOfYear] - 1-12 (renamed from Month)
/// * [recurrenceType] - Recurrence
/// * [startTime] - Time
/// * [status] 
/// * [updatedAt] 
/// * [updatedBy] 
@BuiltValue()
abstract class DtoOccurrenceResponse implements Built<DtoOccurrenceResponse, DtoOccurrenceResponseBuilder> {
  @BuiltValueField(wireName: r'created_at')
  String? get createdAt;

  @BuiltValueField(wireName: r'created_by')
  String? get createdBy;

  /// 1-31
  @BuiltValueField(wireName: r'day_of_month')
  int? get dayOfMonth;

  /// Day specifics
  @BuiltValueField(wireName: r'day_of_week')
  int? get dayOfWeek;

  @BuiltValueField(wireName: r'duration_minutes')
  int? get durationMinutes;

  @BuiltValueField(wireName: r'end_time')
  String? get endTime;

  @BuiltValueField(wireName: r'event_id')
  String? get eventId;

  /// Exceptions
  @BuiltValueField(wireName: r'exception_dates')
  BuiltList<String>? get exceptionDates;

  /// Identity
  @BuiltValueField(wireName: r'id')
  String? get id;

  /// Metadata
  @BuiltValueField(wireName: r'metadata')
  BuiltMap<String, String>? get metadata;

  /// 1-12 (renamed from Month)
  @BuiltValueField(wireName: r'month_of_year')
  int? get monthOfYear;

  /// Recurrence
  @BuiltValueField(wireName: r'recurrence_type')
  TypesRecurrenceType? get recurrenceType;
  // enum recurrenceTypeEnum {  NONE,  DAILY,  WEEKLY,  MONTHLY,  YEARLY,  };

  /// Time
  @BuiltValueField(wireName: r'start_time')
  String? get startTime;

  @BuiltValueField(wireName: r'status')
  TypesStatus? get status;
  // enum statusEnum {  published,  deleted,  archived,  inactive,  pending,  draft,  };

  @BuiltValueField(wireName: r'updated_at')
  String? get updatedAt;

  @BuiltValueField(wireName: r'updated_by')
  String? get updatedBy;

  DtoOccurrenceResponse._();

  factory DtoOccurrenceResponse([void updates(DtoOccurrenceResponseBuilder b)]) = _$DtoOccurrenceResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoOccurrenceResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoOccurrenceResponse> get serializer => _$DtoOccurrenceResponseSerializer();
}

class _$DtoOccurrenceResponseSerializer implements PrimitiveSerializer<DtoOccurrenceResponse> {
  @override
  final Iterable<Type> types = const [DtoOccurrenceResponse, _$DtoOccurrenceResponse];

  @override
  final String wireName = r'DtoOccurrenceResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoOccurrenceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdBy != null) {
      yield r'created_by';
      yield serializers.serialize(
        object.createdBy,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.durationMinutes != null) {
      yield r'duration_minutes';
      yield serializers.serialize(
        object.durationMinutes,
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
    if (object.eventId != null) {
      yield r'event_id';
      yield serializers.serialize(
        object.eventId,
        specifiedType: const FullType(String),
      );
    }
    if (object.exceptionDates != null) {
      yield r'exception_dates';
      yield serializers.serialize(
        object.exceptionDates,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
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
    if (object.recurrenceType != null) {
      yield r'recurrence_type';
      yield serializers.serialize(
        object.recurrenceType,
        specifiedType: const FullType(TypesRecurrenceType),
      );
    }
    if (object.startTime != null) {
      yield r'start_time';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TypesStatus),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.updatedBy != null) {
      yield r'updated_by';
      yield serializers.serialize(
        object.updatedBy,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoOccurrenceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoOccurrenceResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdBy = valueDes;
          break;
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
        case r'duration_minutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationMinutes = valueDes;
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
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesStatus),
          ) as TypesStatus;
          result.status = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.updatedAt = valueDes;
          break;
        case r'updated_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.updatedBy = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoOccurrenceResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoOccurrenceResponseBuilder();
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

