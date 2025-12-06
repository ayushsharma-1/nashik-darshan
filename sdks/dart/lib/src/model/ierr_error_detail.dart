//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ierr_error_detail.g.dart';

/// IerrErrorDetail
///
/// Properties:
/// * [details] 
/// * [internalError] 
/// * [message] 
@BuiltValue()
abstract class IerrErrorDetail implements Built<IerrErrorDetail, IerrErrorDetailBuilder> {
  @BuiltValueField(wireName: r'details')
  BuiltMap<String, JsonObject>? get details;

  @BuiltValueField(wireName: r'internal_error')
  String? get internalError;

  @BuiltValueField(wireName: r'message')
  String? get message;

  IerrErrorDetail._();

  factory IerrErrorDetail([void updates(IerrErrorDetailBuilder b)]) = _$IerrErrorDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IerrErrorDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IerrErrorDetail> get serializer => _$IerrErrorDetailSerializer();
}

class _$IerrErrorDetailSerializer implements PrimitiveSerializer<IerrErrorDetail> {
  @override
  final Iterable<Type> types = const [IerrErrorDetail, _$IerrErrorDetail];

  @override
  final String wireName = r'IerrErrorDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IerrErrorDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.details != null) {
      yield r'details';
      yield serializers.serialize(
        object.details,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
    if (object.internalError != null) {
      yield r'internal_error';
      yield serializers.serialize(
        object.internalError,
        specifiedType: const FullType(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IerrErrorDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IerrErrorDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.details.replace(valueDes);
          break;
        case r'internal_error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.internalError = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IerrErrorDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IerrErrorDetailBuilder();
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

