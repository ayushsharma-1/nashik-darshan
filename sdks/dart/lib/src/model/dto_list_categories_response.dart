//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/dto_category_response.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_list_categories_response.g.dart';

/// DtoListCategoriesResponse
///
/// Properties:
/// * [items] 
/// * [pagination] 
@BuiltValue()
abstract class DtoListCategoriesResponse implements Built<DtoListCategoriesResponse, DtoListCategoriesResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DtoCategoryResponse>? get items;

  @BuiltValueField(wireName: r'pagination')
  TypesPaginationResponse? get pagination;

  DtoListCategoriesResponse._();

  factory DtoListCategoriesResponse([void updates(DtoListCategoriesResponseBuilder b)]) = _$DtoListCategoriesResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoListCategoriesResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoListCategoriesResponse> get serializer => _$DtoListCategoriesResponseSerializer();
}

class _$DtoListCategoriesResponseSerializer implements PrimitiveSerializer<DtoListCategoriesResponse> {
  @override
  final Iterable<Type> types = const [DtoListCategoriesResponse, _$DtoListCategoriesResponse];

  @override
  final String wireName = r'DtoListCategoriesResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoListCategoriesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(DtoCategoryResponse)]),
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
    DtoListCategoriesResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoListCategoriesResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoCategoryResponse)]),
          ) as BuiltList<DtoCategoryResponse>;
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
  DtoListCategoriesResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoListCategoriesResponseBuilder();
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

