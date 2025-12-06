//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_hotel_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_list_hotels_response.g.dart';

/// DtoListHotelsResponse
///
/// Properties:
/// * [items] 
/// * [pagination] 
@BuiltValue()
abstract class DtoListHotelsResponse implements Built<DtoListHotelsResponse, DtoListHotelsResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DtoHotelResponse>? get items;

  @BuiltValueField(wireName: r'pagination')
  TypesPaginationResponse? get pagination;

  DtoListHotelsResponse._();

  factory DtoListHotelsResponse([void updates(DtoListHotelsResponseBuilder b)]) = _$DtoListHotelsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoListHotelsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoListHotelsResponse> get serializer => _$DtoListHotelsResponseSerializer();
}

class _$DtoListHotelsResponseSerializer implements PrimitiveSerializer<DtoListHotelsResponse> {
  @override
  final Iterable<Type> types = const [DtoListHotelsResponse, _$DtoListHotelsResponse];

  @override
  final String wireName = r'DtoListHotelsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoListHotelsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(DtoHotelResponse)]),
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
    DtoListHotelsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoListHotelsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoHotelResponse)]),
          ) as BuiltList<DtoHotelResponse>;
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
  DtoListHotelsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoListHotelsResponseBuilder();
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

