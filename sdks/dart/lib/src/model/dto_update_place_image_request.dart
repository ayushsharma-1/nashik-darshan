//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_update_place_image_request.g.dart';

/// DtoUpdatePlaceImageRequest
///
/// Properties:
/// * [alt] 
/// * [metadata] 
/// * [pos] 
/// * [url] 
@BuiltValue()
abstract class DtoUpdatePlaceImageRequest implements Built<DtoUpdatePlaceImageRequest, DtoUpdatePlaceImageRequestBuilder> {
  @BuiltValueField(wireName: r'alt')
  String? get alt;

  @BuiltValueField(wireName: r'metadata')
  BuiltMap<String, String>? get metadata;

  @BuiltValueField(wireName: r'pos')
  int? get pos;

  @BuiltValueField(wireName: r'url')
  String? get url;

  DtoUpdatePlaceImageRequest._();

  factory DtoUpdatePlaceImageRequest([void updates(DtoUpdatePlaceImageRequestBuilder b)]) = _$DtoUpdatePlaceImageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoUpdatePlaceImageRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoUpdatePlaceImageRequest> get serializer => _$DtoUpdatePlaceImageRequestSerializer();
}

class _$DtoUpdatePlaceImageRequestSerializer implements PrimitiveSerializer<DtoUpdatePlaceImageRequest> {
  @override
  final Iterable<Type> types = const [DtoUpdatePlaceImageRequest, _$DtoUpdatePlaceImageRequest];

  @override
  final String wireName = r'DtoUpdatePlaceImageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoUpdatePlaceImageRequest object, {
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
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoUpdatePlaceImageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoUpdatePlaceImageRequestBuilder result,
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
  DtoUpdatePlaceImageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoUpdatePlaceImageRequestBuilder();
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

