//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_signup_response.g.dart';

/// DtoSignupResponse
///
/// Properties:
/// * [accessToken] 
/// * [id] 
@BuiltValue()
abstract class DtoSignupResponse implements Built<DtoSignupResponse, DtoSignupResponseBuilder> {
  @BuiltValueField(wireName: r'access_token')
  String? get accessToken;

  @BuiltValueField(wireName: r'id')
  String? get id;

  DtoSignupResponse._();

  factory DtoSignupResponse([void updates(DtoSignupResponseBuilder b)]) = _$DtoSignupResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoSignupResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoSignupResponse> get serializer => _$DtoSignupResponseSerializer();
}

class _$DtoSignupResponseSerializer implements PrimitiveSerializer<DtoSignupResponse> {
  @override
  final Iterable<Type> types = const [DtoSignupResponse, _$DtoSignupResponse];

  @override
  final String wireName = r'DtoSignupResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoSignupResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accessToken != null) {
      yield r'access_token';
      yield serializers.serialize(
        object.accessToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoSignupResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoSignupResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoSignupResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoSignupResponseBuilder();
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

