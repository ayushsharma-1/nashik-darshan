//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nashik_darshan_sdk/src/model/dto_place_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_list_places_response.g.dart';

/// DtoListPlacesResponse
///
/// Properties:
/// * [items] 
/// * [pagination] 
@BuiltValue()
abstract class DtoListPlacesResponse implements Built<DtoListPlacesResponse, DtoListPlacesResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DtoPlaceResponse>? get items;

  @BuiltValueField(wireName: r'pagination')
  TypesPaginationResponse? get pagination;

  DtoListPlacesResponse._();

  factory DtoListPlacesResponse([void updates(DtoListPlacesResponseBuilder b)]) = _$DtoListPlacesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoListPlacesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoListPlacesResponse> get serializer => _$DtoListPlacesResponseSerializer();
}

class _$DtoListPlacesResponseSerializer implements PrimitiveSerializer<DtoListPlacesResponse> {
  @override
  final Iterable<Type> types = const [DtoListPlacesResponse, _$DtoListPlacesResponse];

  @override
  final String wireName = r'DtoListPlacesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoListPlacesResponse object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoListPlacesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoListPlacesResponseBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoListPlacesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoListPlacesResponseBuilder();
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

