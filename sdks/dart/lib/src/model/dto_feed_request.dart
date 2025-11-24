//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/dto_feed_section_request.dart';
import 'package:nashik_darshan_sdk/src/model/types_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_feed_request.g.dart';

/// DtoFeedRequest
///
/// Properties:
/// * [endTime] 
/// * [expand] 
/// * [limit] 
/// * [offset] 
/// * [order] 
/// * [sections] 
/// * [sort] 
/// * [startTime] 
/// * [status] 
@BuiltValue()
abstract class DtoFeedRequest implements Built<DtoFeedRequest, DtoFeedRequestBuilder> {
  @BuiltValueField(wireName: r'end_time')
  String? get endTime;

  @BuiltValueField(wireName: r'expand')
  String? get expand;

  @BuiltValueField(wireName: r'limit')
  int? get limit;

  @BuiltValueField(wireName: r'offset')
  int? get offset;

  @BuiltValueField(wireName: r'order')
  DtoFeedRequestOrderEnum? get order;
  // enum orderEnum {  asc,  desc,  };

  @BuiltValueField(wireName: r'sections')
  BuiltList<DtoFeedSectionRequest> get sections;

  @BuiltValueField(wireName: r'sort')
  String? get sort;

  @BuiltValueField(wireName: r'start_time')
  String? get startTime;

  @BuiltValueField(wireName: r'status')
  TypesStatus? get status;
  // enum statusEnum {  published,  deleted,  archived,  inactive,  pending,  };

  DtoFeedRequest._();

  factory DtoFeedRequest([void updates(DtoFeedRequestBuilder b)]) = _$DtoFeedRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoFeedRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoFeedRequest> get serializer => _$DtoFeedRequestSerializer();
}

class _$DtoFeedRequestSerializer implements PrimitiveSerializer<DtoFeedRequest> {
  @override
  final Iterable<Type> types = const [DtoFeedRequest, _$DtoFeedRequest];

  @override
  final String wireName = r'DtoFeedRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoFeedRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.endTime != null) {
      yield r'end_time';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.expand != null) {
      yield r'expand';
      yield serializers.serialize(
        object.expand,
        specifiedType: const FullType(String),
      );
    }
    if (object.limit != null) {
      yield r'limit';
      yield serializers.serialize(
        object.limit,
        specifiedType: const FullType(int),
      );
    }
    if (object.offset != null) {
      yield r'offset';
      yield serializers.serialize(
        object.offset,
        specifiedType: const FullType(int),
      );
    }
    if (object.order != null) {
      yield r'order';
      yield serializers.serialize(
        object.order,
        specifiedType: const FullType(DtoFeedRequestOrderEnum),
      );
    }
    yield r'sections';
    yield serializers.serialize(
      object.sections,
      specifiedType: const FullType(BuiltList, [FullType(DtoFeedSectionRequest)]),
    );
    if (object.sort != null) {
      yield r'sort';
      yield serializers.serialize(
        object.sort,
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoFeedRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoFeedRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endTime = valueDes;
          break;
        case r'expand':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expand = valueDes;
          break;
        case r'limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.limit = valueDes;
          break;
        case r'offset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.offset = valueDes;
          break;
        case r'order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DtoFeedRequestOrderEnum),
          ) as DtoFeedRequestOrderEnum;
          result.order = valueDes;
          break;
        case r'sections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoFeedSectionRequest)]),
          ) as BuiltList<DtoFeedSectionRequest>;
          result.sections.replace(valueDes);
          break;
        case r'sort':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sort = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoFeedRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoFeedRequestBuilder();
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

class DtoFeedRequestOrderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'asc')
  static const DtoFeedRequestOrderEnum asc = _$dtoFeedRequestOrderEnum_asc;
  @BuiltValueEnumConst(wireName: r'desc')
  static const DtoFeedRequestOrderEnum desc = _$dtoFeedRequestOrderEnum_desc;

  static Serializer<DtoFeedRequestOrderEnum> get serializer => _$dtoFeedRequestOrderEnumSerializer;

  const DtoFeedRequestOrderEnum._(String name): super(name);

  static BuiltSet<DtoFeedRequestOrderEnum> get values => _$dtoFeedRequestOrderEnumValues;
  static DtoFeedRequestOrderEnum valueOf(String name) => _$dtoFeedRequestOrderEnumValueOf(name);
}

