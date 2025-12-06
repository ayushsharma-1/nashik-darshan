//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nashik_darshan_sdk/src/model/dto_review_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_list_response_dto_review_response.g.dart';

/// TypesListResponseDtoReviewResponse
///
/// Properties:
/// * [items] 
/// * [pagination] 
@BuiltValue()
abstract class TypesListResponseDtoReviewResponse implements Built<TypesListResponseDtoReviewResponse, TypesListResponseDtoReviewResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DtoReviewResponse>? get items;

  @BuiltValueField(wireName: r'pagination')
  TypesPaginationResponse? get pagination;

  TypesListResponseDtoReviewResponse._();

  factory TypesListResponseDtoReviewResponse([void updates(TypesListResponseDtoReviewResponseBuilder b)]) = _$TypesListResponseDtoReviewResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TypesListResponseDtoReviewResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TypesListResponseDtoReviewResponse> get serializer => _$TypesListResponseDtoReviewResponseSerializer();
}

class _$TypesListResponseDtoReviewResponseSerializer implements PrimitiveSerializer<TypesListResponseDtoReviewResponse> {
  @override
  final Iterable<Type> types = const [TypesListResponseDtoReviewResponse, _$TypesListResponseDtoReviewResponse];

  @override
  final String wireName = r'TypesListResponseDtoReviewResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TypesListResponseDtoReviewResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(DtoReviewResponse)]),
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
    TypesListResponseDtoReviewResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TypesListResponseDtoReviewResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoReviewResponse)]),
          ) as BuiltList<DtoReviewResponse>;
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
  TypesListResponseDtoReviewResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TypesListResponseDtoReviewResponseBuilder();
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

