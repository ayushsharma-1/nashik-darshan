// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_event_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypesEventType _$EventTypeAarti =
    const TypesEventType._('EventTypeAarti');
const TypesEventType _$EventTypeFestival =
    const TypesEventType._('EventTypeFestival');
const TypesEventType _$EventTypeCultural =
    const TypesEventType._('EventTypeCultural');
const TypesEventType _$EventTypeWorkshop =
    const TypesEventType._('EventTypeWorkshop');
const TypesEventType _$EventTypeSpecialDarshan =
    const TypesEventType._('EventTypeSpecialDarshan');

TypesEventType _$valueOf(String name) {
  switch (name) {
    case 'EventTypeAarti':
      return _$EventTypeAarti;
    case 'EventTypeFestival':
      return _$EventTypeFestival;
    case 'EventTypeCultural':
      return _$EventTypeCultural;
    case 'EventTypeWorkshop':
      return _$EventTypeWorkshop;
    case 'EventTypeSpecialDarshan':
      return _$EventTypeSpecialDarshan;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TypesEventType> _$values =
    BuiltSet<TypesEventType>(const <TypesEventType>[
  _$EventTypeAarti,
  _$EventTypeFestival,
  _$EventTypeCultural,
  _$EventTypeWorkshop,
  _$EventTypeSpecialDarshan,
]);

class _$TypesEventTypeMeta {
  const _$TypesEventTypeMeta();
  TypesEventType get EventTypeAarti => _$EventTypeAarti;
  TypesEventType get EventTypeFestival => _$EventTypeFestival;
  TypesEventType get EventTypeCultural => _$EventTypeCultural;
  TypesEventType get EventTypeWorkshop => _$EventTypeWorkshop;
  TypesEventType get EventTypeSpecialDarshan => _$EventTypeSpecialDarshan;
  TypesEventType valueOf(String name) => _$valueOf(name);
  BuiltSet<TypesEventType> get values => _$values;
}

abstract class _$TypesEventTypeMixin {
  // ignore: non_constant_identifier_names
  _$TypesEventTypeMeta get TypesEventType => const _$TypesEventTypeMeta();
}

Serializer<TypesEventType> _$typesEventTypeSerializer =
    _$TypesEventTypeSerializer();

class _$TypesEventTypeSerializer
    implements PrimitiveSerializer<TypesEventType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'EventTypeAarti': 'AARTI',
    'EventTypeFestival': 'FESTIVAL',
    'EventTypeCultural': 'CULTURAL',
    'EventTypeWorkshop': 'WORKSHOP',
    'EventTypeSpecialDarshan': 'SPECIAL_DARSHAN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AARTI': 'EventTypeAarti',
    'FESTIVAL': 'EventTypeFestival',
    'CULTURAL': 'EventTypeCultural',
    'WORKSHOP': 'EventTypeWorkshop',
    'SPECIAL_DARSHAN': 'EventTypeSpecialDarshan',
  };

  @override
  final Iterable<Type> types = const <Type>[TypesEventType];
  @override
  final String wireName = 'TypesEventType';

  @override
  Object serialize(Serializers serializers, TypesEventType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TypesEventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TypesEventType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
