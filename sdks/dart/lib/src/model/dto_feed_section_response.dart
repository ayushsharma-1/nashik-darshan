//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nashik_darshan_sdk/src/model/dto_place_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_feed_section_type.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_feed_section_response.g.dart';

/// DtoFeedSectionResponse
///
/// Properties:
/// * [items] 
/// * [pagination] 
/// * [type] 
@BuiltValue()
abstract class DtoFeedSectionResponse implements Built<DtoFeedSectionResponse, DtoFeedSectionResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DtoPlaceResponse>? get items;

  @BuiltValueField(wireName: r'pagination')
  TypesPaginationResponse? get pagination;

  @BuiltValueField(wireName: r'type')
  TypesFeedSectionType? get type;
  // enum typeEnum {  latest,  trending,  popular,  nearby,  };

  DtoFeedSectionResponse._();

  factory DtoFeedSectionResponse([void updates(DtoFeedSectionResponseBuilder b)]) = _$DtoFeedSectionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoFeedSectionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoFeedSectionResponse> get serializer => _$DtoFeedSectionResponseSerializer();
}

class _$DtoFeedSectionResponseSerializer implements PrimitiveSerializer<DtoFeedSectionResponse> {
  @override
  final Iterable<Type> types = const [DtoFeedSectionResponse, _$DtoFeedSectionResponse];

  @override
  final String wireName = r'DtoFeedSectionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoFeedSectionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(DtoPlaceResponse)]),
      );
    }
    if (object.pagination != null) {
      yield r'pagination';
      yield serializers.serialize(
        object.pagination,
        specifiedType: const FullType(TypesPaginationResponse),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(TypesFeedSectionType),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoFeedSectionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoFeedSectionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoPlaceResponse)]),
          ) as BuiltList<DtoPlaceResponse>;
          result.items.replace(valueDes);
          break;
        case r'pagination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesPaginationResponse),
          ) as TypesPaginationResponse;
          result.pagination.replace(valueDes);
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
  DtoFeedSectionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoFeedSectionResponseBuilder();
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

