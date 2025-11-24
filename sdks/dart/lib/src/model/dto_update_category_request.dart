//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_update_category_request.g.dart';

/// DtoUpdateCategoryRequest
///
/// Properties:
/// * [description] 
/// * [name] 
/// * [slug] 
@BuiltValue()
abstract class DtoUpdateCategoryRequest implements Built<DtoUpdateCategoryRequest, DtoUpdateCategoryRequestBuilder> {
  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'slug')
  String? get slug;

  DtoUpdateCategoryRequest._();

  factory DtoUpdateCategoryRequest([void updates(DtoUpdateCategoryRequestBuilder b)]) = _$DtoUpdateCategoryRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoUpdateCategoryRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoUpdateCategoryRequest> get serializer => _$DtoUpdateCategoryRequestSerializer();
}

class _$DtoUpdateCategoryRequestSerializer implements PrimitiveSerializer<DtoUpdateCategoryRequest> {
  @override
  final Iterable<Type> types = const [DtoUpdateCategoryRequest, _$DtoUpdateCategoryRequest];

  @override
  final String wireName = r'DtoUpdateCategoryRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoUpdateCategoryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.slug != null) {
      yield r'slug';
      yield serializers.serialize(
        object.slug,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoUpdateCategoryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoUpdateCategoryRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'slug':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.slug = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoUpdateCategoryRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoUpdateCategoryRequestBuilder();
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

