//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_user_role.g.dart';

class TypesUserRole extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const TypesUserRole UserRoleUser = _$UserRoleUser;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const TypesUserRole UserRoleAdmin = _$UserRoleAdmin;

  static Serializer<TypesUserRole> get serializer => _$typesUserRoleSerializer;

  const TypesUserRole._(String name): super(name);

  static BuiltSet<TypesUserRole> get values => _$values;
  static TypesUserRole valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesUserRoleMixin = Object with _$TypesUserRoleMixin;

