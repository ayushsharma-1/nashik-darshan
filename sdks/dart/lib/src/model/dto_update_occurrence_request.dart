//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_recurrence_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_update_occurrence_request.g.dart';

/// DtoUpdateOccurrenceRequest
///
/// Properties:
/// * [dayOfMonth] 
/// * [dayOfWeek] 
/// * [endTime] - ISO 8601 format, optional/nillable
/// * [exceptionDates] 
/// * [metadata] 
/// * [monthOfYear] 
/// * [recurrenceType] 
/// * [startTime] - ISO 8601 format, optional/nillable
@BuiltValue()
abstract class DtoUpdateOccurrenceRequest implements Built<DtoUpdateOccurrenceRequest, DtoUpdateOccurrenceRequestBuilder> {
  @BuiltValueField(wireName: r'day_of_month')
  int? get dayOfMonth;

  @BuiltValueField(wireName: r'day_of_week')
  int? get dayOfWeek;

  /// ISO 8601 format, optional/nillable
  @BuiltValueField(wireName: r'end_time')
  String? get endTime;

  @BuiltValueField(wireName: r'exception_dates')
  BuiltList<String>? get exceptionDates;

  @BuiltValueField(wireName: r'metadata')
  BuiltMap<String, String>? get metadata;

  @BuiltValueField(wireName: r'month_of_year')
  int? get monthOfYear;

  @BuiltValueField(wireName: r'recurrence_type')
  TypesRecurrenceType? get recurrenceType;
  // enum recurrenceTypeEnum {  NONE,  DAILY,  WEEKLY,  MONTHLY,  YEARLY,  };

  /// ISO 8601 format, optional/nillable
  @BuiltValueField(wireName: r'start_time')
  String? get startTime;

  DtoUpdateOccurrenceRequest._();

  factory DtoUpdateOccurrenceRequest([void updates(DtoUpdateOccurrenceRequestBuilder b)]) = _$DtoUpdateOccurrenceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoUpdateOccurrenceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoUpdateOccurrenceRequest> get serializer => _$DtoUpdateOccurrenceRequestSerializer();
}

class _$DtoUpdateOccurrenceRequestSerializer implements PrimitiveSerializer<DtoUpdateOccurrenceRequest> {
  @override
  final Iterable<Type> types = const [DtoUpdateOccurrenceRequest, _$DtoUpdateOccurrenceRequest];

  @override
  final String wireName = r'DtoUpdateOccurrenceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoUpdateOccurrenceRequest object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoUpdateOccurrenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoUpdateOccurrenceRequestBuilder result,
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
  DtoUpdateOccurrenceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoUpdateOccurrenceRequestBuilder();
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

