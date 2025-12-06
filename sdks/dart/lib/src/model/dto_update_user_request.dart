//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_update_user_request.g.dart';

/// DtoUpdateUserRequest
///
/// Properties:
/// * [name] 
/// * [phone] 
@BuiltValue()
abstract class DtoUpdateUserRequest implements Built<DtoUpdateUserRequest, DtoUpdateUserRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  DtoUpdateUserRequest._();

  factory DtoUpdateUserRequest([void updates(DtoUpdateUserRequestBuilder b)]) = _$DtoUpdateUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoUpdateUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoUpdateUserRequest> get serializer => _$DtoUpdateUserRequestSerializer();
}

class _$DtoUpdateUserRequestSerializer implements PrimitiveSerializer<DtoUpdateUserRequest> {
  @override
  final Iterable<Type> types = const [DtoUpdateUserRequest, _$DtoUpdateUserRequest];

  @override
  final String wireName = r'DtoUpdateUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoUpdateUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoUpdateUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoUpdateUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoUpdateUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoUpdateUserRequestBuilder();
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

