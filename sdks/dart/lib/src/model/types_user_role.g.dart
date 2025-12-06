// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_user_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypesUserRole _$UserRoleUser = const TypesUserRole._('UserRoleUser');
const TypesUserRole _$UserRoleAdmin = const TypesUserRole._('UserRoleAdmin');

TypesUserRole _$valueOf(String name) {
  switch (name) {
    case 'UserRoleUser':
      return _$UserRoleUser;
    case 'UserRoleAdmin':
      return _$UserRoleAdmin;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TypesUserRole> _$values =
    BuiltSet<TypesUserRole>(const <TypesUserRole>[
  _$UserRoleUser,
  _$UserRoleAdmin,
]);

class _$TypesUserRoleMeta {
  const _$TypesUserRoleMeta();
  TypesUserRole get UserRoleUser => _$UserRoleUser;
  TypesUserRole get UserRoleAdmin => _$UserRoleAdmin;
  TypesUserRole valueOf(String name) => _$valueOf(name);
  BuiltSet<TypesUserRole> get values => _$values;
}

abstract class _$TypesUserRoleMixin {
  // ignore: non_constant_identifier_names
  _$TypesUserRoleMeta get TypesUserRole => const _$TypesUserRoleMeta();
}

Serializer<TypesUserRole> _$typesUserRoleSerializer =
    _$TypesUserRoleSerializer();

class _$TypesUserRoleSerializer implements PrimitiveSerializer<TypesUserRole> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'UserRoleUser': 'USER',
    'UserRoleAdmin': 'ADMIN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'UserRoleUser',
    'ADMIN': 'UserRoleAdmin',
  };

  @override
  final Iterable<Type> types = const <Type>[TypesUserRole];
  @override
  final String wireName = 'TypesUserRole';

  @override
  Object serialize(Serializers serializers, TypesUserRole object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TypesUserRole deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TypesUserRole.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
