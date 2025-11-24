//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nashik_darshan_sdk/src/model/ierr_error_detail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ierr_error_response.g.dart';

/// IerrErrorResponse
///
/// Properties:
/// * [error] 
/// * [success] 
@BuiltValue()
abstract class IerrErrorResponse implements Built<IerrErrorResponse, IerrErrorResponseBuilder> {
  @BuiltValueField(wireName: r'error')
  IerrErrorDetail? get error;

  @BuiltValueField(wireName: r'success')
  bool? get success;

  IerrErrorResponse._();

  factory IerrErrorResponse([void updates(IerrErrorResponseBuilder b)]) = _$IerrErrorResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IerrErrorResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IerrErrorResponse> get serializer => _$IerrErrorResponseSerializer();
}

class _$IerrErrorResponseSerializer implements PrimitiveSerializer<IerrErrorResponse> {
  @override
  final Iterable<Type> types = const [IerrErrorResponse, _$IerrErrorResponse];

  @override
  final String wireName = r'IerrErrorResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IerrErrorResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType(IerrErrorDetail),
      );
    }
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IerrErrorResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IerrErrorResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IerrErrorDetail),
          ) as IerrErrorDetail;
          result.error.replace(valueDes);
          break;
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IerrErrorResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IerrErrorResponseBuilder();
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

