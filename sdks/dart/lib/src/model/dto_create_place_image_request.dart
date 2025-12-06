//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_create_place_image_request.g.dart';

/// DtoCreatePlaceImageRequest
///
/// Properties:
/// * [alt] 
/// * [metadata] 
/// * [pos] 
/// * [url] 
@BuiltValue()
abstract class DtoCreatePlaceImageRequest implements Built<DtoCreatePlaceImageRequest, DtoCreatePlaceImageRequestBuilder> {
  @BuiltValueField(wireName: r'alt')
  String? get alt;

  @BuiltValueField(wireName: r'metadata')
  BuiltMap<String, String>? get metadata;

  @BuiltValueField(wireName: r'pos')
  int? get pos;

  @BuiltValueField(wireName: r'url')
  String get url;

  DtoCreatePlaceImageRequest._();

  factory DtoCreatePlaceImageRequest([void updates(DtoCreatePlaceImageRequestBuilder b)]) = _$DtoCreatePlaceImageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoCreatePlaceImageRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoCreatePlaceImageRequest> get serializer => _$DtoCreatePlaceImageRequestSerializer();
}

class _$DtoCreatePlaceImageRequestSerializer implements PrimitiveSerializer<DtoCreatePlaceImageRequest> {
  @override
  final Iterable<Type> types = const [DtoCreatePlaceImageRequest, _$DtoCreatePlaceImageRequest];

  @override
  final String wireName = r'DtoCreatePlaceImageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoCreatePlaceImageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.alt != null) {
      yield r'alt';
      yield serializers.serialize(
        object.alt,
        specifiedType: const FullType(String),
      );
    }
    if (object.metadata != null) {
      yield r'metadata';
      yield serializers.serialize(
        object.metadata,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.pos != null) {
      yield r'pos';
      yield serializers.serialize(
        object.pos,
        specifiedType: const FullType(int),
      );
    }
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoCreatePlaceImageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoCreatePlaceImageRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'alt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.alt = valueDes;
          break;
        case r'metadata':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>;
          result.metadata.replace(valueDes);
          break;
        case r'pos':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pos = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoCreatePlaceImageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoCreatePlaceImageRequestBuilder();
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

