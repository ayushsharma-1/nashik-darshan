//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_status.g.dart';

class TypesStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'published')
  static const TypesStatus StatusPublished = _$StatusPublished;
  @BuiltValueEnumConst(wireName: r'deleted')
  static const TypesStatus StatusDeleted = _$StatusDeleted;
  @BuiltValueEnumConst(wireName: r'archived')
  static const TypesStatus StatusArchived = _$StatusArchived;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const TypesStatus StatusInactive = _$StatusInactive;
  @BuiltValueEnumConst(wireName: r'pending')
  static const TypesStatus StatusPending = _$StatusPending;

  static Serializer<TypesStatus> get serializer => _$typesStatusSerializer;

  const TypesStatus._(String name): super(name);

  static BuiltSet<TypesStatus> get values => _$values;
  static TypesStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesStatusMixin = Object with _$TypesStatusMixin;

