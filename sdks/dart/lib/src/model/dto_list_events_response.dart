//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_event_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_list_events_response.g.dart';

/// DtoListEventsResponse
///
/// Properties:
/// * [items] 
/// * [pagination] 
@BuiltValue()
abstract class DtoListEventsResponse implements Built<DtoListEventsResponse, DtoListEventsResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DtoEventResponse>? get items;

  @BuiltValueField(wireName: r'pagination')
  TypesPaginationResponse? get pagination;

  DtoListEventsResponse._();

  factory DtoListEventsResponse([void updates(DtoListEventsResponseBuilder b)]) = _$DtoListEventsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoListEventsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoListEventsResponse> get serializer => _$DtoListEventsResponseSerializer();
}

class _$DtoListEventsResponseSerializer implements PrimitiveSerializer<DtoListEventsResponse> {
  @override
  final Iterable<Type> types = const [DtoListEventsResponse, _$DtoListEventsResponse];

  @override
  final String wireName = r'DtoListEventsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoListEventsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(DtoEventResponse)]),
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
    DtoListEventsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoListEventsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoEventResponse)]),
          ) as BuiltList<DtoEventResponse>;
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
  DtoListEventsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoListEventsResponseBuilder();
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

