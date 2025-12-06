// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_recurrence_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypesRecurrenceType _$RecurrenceNone =
    const TypesRecurrenceType._('RecurrenceNone');
const TypesRecurrenceType _$RecurrenceDaily =
    const TypesRecurrenceType._('RecurrenceDaily');
const TypesRecurrenceType _$RecurrenceWeekly =
    const TypesRecurrenceType._('RecurrenceWeekly');
const TypesRecurrenceType _$RecurrenceMonthly =
    const TypesRecurrenceType._('RecurrenceMonthly');
const TypesRecurrenceType _$RecurrenceYearly =
    const TypesRecurrenceType._('RecurrenceYearly');

TypesRecurrenceType _$valueOf(String name) {
  switch (name) {
    case 'RecurrenceNone':
      return _$RecurrenceNone;
    case 'RecurrenceDaily':
      return _$RecurrenceDaily;
    case 'RecurrenceWeekly':
      return _$RecurrenceWeekly;
    case 'RecurrenceMonthly':
      return _$RecurrenceMonthly;
    case 'RecurrenceYearly':
      return _$RecurrenceYearly;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TypesRecurrenceType> _$values =
    BuiltSet<TypesRecurrenceType>(const <TypesRecurrenceType>[
  _$RecurrenceNone,
  _$RecurrenceDaily,
  _$RecurrenceWeekly,
  _$RecurrenceMonthly,
  _$RecurrenceYearly,
]);

class _$TypesRecurrenceTypeMeta {
  const _$TypesRecurrenceTypeMeta();
  TypesRecurrenceType get RecurrenceNone => _$RecurrenceNone;
  TypesRecurrenceType get RecurrenceDaily => _$RecurrenceDaily;
  TypesRecurrenceType get RecurrenceWeekly => _$RecurrenceWeekly;
  TypesRecurrenceType get RecurrenceMonthly => _$RecurrenceMonthly;
  TypesRecurrenceType get RecurrenceYearly => _$RecurrenceYearly;
  TypesRecurrenceType valueOf(String name) => _$valueOf(name);
  BuiltSet<TypesRecurrenceType> get values => _$values;
}

abstract class _$TypesRecurrenceTypeMixin {
  // ignore: non_constant_identifier_names
  _$TypesRecurrenceTypeMeta get TypesRecurrenceType =>
      const _$TypesRecurrenceTypeMeta();
}

Serializer<TypesRecurrenceType> _$typesRecurrenceTypeSerializer =
    _$TypesRecurrenceTypeSerializer();

class _$TypesRecurrenceTypeSerializer
    implements PrimitiveSerializer<TypesRecurrenceType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RecurrenceNone': 'NONE',
    'RecurrenceDaily': 'DAILY',
    'RecurrenceWeekly': 'WEEKLY',
    'RecurrenceMonthly': 'MONTHLY',
    'RecurrenceYearly': 'YEARLY',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'NONE': 'RecurrenceNone',
    'DAILY': 'RecurrenceDaily',
    'WEEKLY': 'RecurrenceWeekly',
    'MONTHLY': 'RecurrenceMonthly',
    'YEARLY': 'RecurrenceYearly',
  };

  @override
  final Iterable<Type> types = const <Type>[TypesRecurrenceType];
  @override
  final String wireName = 'TypesRecurrenceType';

  @override
  Object serialize(Serializers serializers, TypesRecurrenceType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TypesRecurrenceType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TypesRecurrenceType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
