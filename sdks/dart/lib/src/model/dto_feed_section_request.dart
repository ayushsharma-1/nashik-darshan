//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_feed_section_type.dart';
import 'package:nashik_darshan_sdk/src/model/types_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_feed_section_request.g.dart';

/// DtoFeedSectionRequest
///
/// Properties:
/// * [endTime] 
/// * [expand] 
/// * [latitude] - Geospatial fields (for nearby section)
/// * [limit] 
/// * [longitude] 
/// * [offset] 
/// * [order] 
/// * [radiusKm] 
/// * [sort] 
/// * [startTime] 
/// * [status] 
/// * [type] 
@BuiltValue()
abstract class DtoFeedSectionRequest implements Built<DtoFeedSectionRequest, DtoFeedSectionRequestBuilder> {
  @BuiltValueField(wireName: r'end_time')
  String? get endTime;

  @BuiltValueField(wireName: r'expand')
  String? get expand;

  /// Geospatial fields (for nearby section)
  @BuiltValueField(wireName: r'latitude')
  num? get latitude;

  @BuiltValueField(wireName: r'limit')
  int? get limit;

  @BuiltValueField(wireName: r'longitude')
  num? get longitude;

  @BuiltValueField(wireName: r'offset')
  int? get offset;

  @BuiltValueField(wireName: r'order')
  DtoFeedSectionRequestOrderEnum? get order;
  // enum orderEnum {  asc,  desc,  };

  @BuiltValueField(wireName: r'radius_km')
  num? get radiusKm;

  @BuiltValueField(wireName: r'sort')
  String? get sort;

  @BuiltValueField(wireName: r'start_time')
  String? get startTime;

  @BuiltValueField(wireName: r'status')
  TypesStatus? get status;
  // enum statusEnum {  published,  deleted,  archived,  inactive,  pending,  };

  @BuiltValueField(wireName: r'type')
  TypesFeedSectionType get type;
  // enum typeEnum {  latest,  trending,  popular,  nearby,  };

  DtoFeedSectionRequest._();

  factory DtoFeedSectionRequest([void updates(DtoFeedSectionRequestBuilder b)]) = _$DtoFeedSectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoFeedSectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoFeedSectionRequest> get serializer => _$DtoFeedSectionRequestSerializer();
}

class _$DtoFeedSectionRequestSerializer implements PrimitiveSerializer<DtoFeedSectionRequest> {
  @override
  final Iterable<Type> types = const [DtoFeedSectionRequest, _$DtoFeedSectionRequest];

  @override
  final String wireName = r'DtoFeedSectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoFeedSectionRequest object, {
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
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType(num),
      );
    }
    if (object.limit != null) {
      yield r'limit';
      yield serializers.serialize(
        object.limit,
        specifiedType: const FullType(int),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType(num),
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
        specifiedType: const FullType(DtoFeedSectionRequestOrderEnum),
      );
    }
    if (object.radiusKm != null) {
      yield r'radius_km';
      yield serializers.serialize(
        object.radiusKm,
        specifiedType: const FullType(num),
      );
    }
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
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(TypesFeedSectionType),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoFeedSectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoFeedSectionRequestBuilder result,
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
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.latitude = valueDes;
          break;
        case r'limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.limit = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.longitude = valueDes;
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
            specifiedType: const FullType(DtoFeedSectionRequestOrderEnum),
          ) as DtoFeedSectionRequestOrderEnum;
          result.order = valueDes;
          break;
        case r'radius_km':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.radiusKm = valueDes;
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesFeedSectionType),
          ) as TypesFeedSectionType;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoFeedSectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoFeedSectionRequestBuilder();
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

class DtoFeedSectionRequestOrderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'asc')
  static const DtoFeedSectionRequestOrderEnum asc = _$dtoFeedSectionRequestOrderEnum_asc;
  @BuiltValueEnumConst(wireName: r'desc')
  static const DtoFeedSectionRequestOrderEnum desc = _$dtoFeedSectionRequestOrderEnum_desc;

  static Serializer<DtoFeedSectionRequestOrderEnum> get serializer => _$dtoFeedSectionRequestOrderEnumSerializer;

  const DtoFeedSectionRequestOrderEnum._(String name): super(name);

  static BuiltSet<DtoFeedSectionRequestOrderEnum> get values => _$dtoFeedSectionRequestOrderEnumValues;
  static DtoFeedSectionRequestOrderEnum valueOf(String name) => _$dtoFeedSectionRequestOrderEnumValueOf(name);
}

