//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_feed_section_type.g.dart';

class TypesFeedSectionType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'latest')
  static const TypesFeedSectionType SectionTypeLatest = _$SectionTypeLatest;
  @BuiltValueEnumConst(wireName: r'trending')
  static const TypesFeedSectionType SectionTypeTrending = _$SectionTypeTrending;
  @BuiltValueEnumConst(wireName: r'popular')
  static const TypesFeedSectionType SectionTypePopular = _$SectionTypePopular;
  @BuiltValueEnumConst(wireName: r'nearby')
  static const TypesFeedSectionType SectionTypeNearby = _$SectionTypeNearby;

  static Serializer<TypesFeedSectionType> get serializer => _$typesFeedSectionTypeSerializer;

  const TypesFeedSectionType._(String name): super(name);

  static BuiltSet<TypesFeedSectionType> get values => _$values;
  static TypesFeedSectionType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesFeedSectionTypeMixin = Object with _$TypesFeedSectionTypeMixin;

