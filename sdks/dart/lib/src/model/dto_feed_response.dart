//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/dto_feed_section_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_feed_response.g.dart';

/// DtoFeedResponse
///
/// Properties:
/// * [sections] 
@BuiltValue()
abstract class DtoFeedResponse implements Built<DtoFeedResponse, DtoFeedResponseBuilder> {
  @BuiltValueField(wireName: r'sections')
  BuiltList<DtoFeedSectionResponse>? get sections;

  DtoFeedResponse._();

  factory DtoFeedResponse([void updates(DtoFeedResponseBuilder b)]) = _$DtoFeedResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoFeedResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoFeedResponse> get serializer => _$DtoFeedResponseSerializer();
}

class _$DtoFeedResponseSerializer implements PrimitiveSerializer<DtoFeedResponse> {
  @override
  final Iterable<Type> types = const [DtoFeedResponse, _$DtoFeedResponse];

  @override
  final String wireName = r'DtoFeedResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoFeedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sections != null) {
      yield r'sections';
      yield serializers.serialize(
        object.sections,
        specifiedType: const FullType(BuiltList, [FullType(DtoFeedSectionResponse)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoFeedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoFeedResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoFeedSectionResponse)]),
          ) as BuiltList<DtoFeedSectionResponse>;
          result.sections.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoFeedResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoFeedResponseBuilder();
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

