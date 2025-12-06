//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'types_review_entity_type.g.dart';

class TypesReviewEntityType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'place')
  static const TypesReviewEntityType EntityTypePlace = _$EntityTypePlace;
  @BuiltValueEnumConst(wireName: r'hotel')
  static const TypesReviewEntityType EntityTypeHotel = _$EntityTypeHotel;
  @BuiltValueEnumConst(wireName: r'restaurant')
  static const TypesReviewEntityType EntityTypeRestaurant = _$EntityTypeRestaurant;
  @BuiltValueEnumConst(wireName: r'event')
  static const TypesReviewEntityType EntityTypeEvent = _$EntityTypeEvent;
  @BuiltValueEnumConst(wireName: r'experience')
  static const TypesReviewEntityType EntityTypeExperience = _$EntityTypeExperience;
  @BuiltValueEnumConst(wireName: r'attraction')
  static const TypesReviewEntityType EntityTypeAttraction = _$EntityTypeAttraction;

  static Serializer<TypesReviewEntityType> get serializer => _$typesReviewEntityTypeSerializer;

  const TypesReviewEntityType._(String name): super(name);

  static BuiltSet<TypesReviewEntityType> get values => _$values;
  static TypesReviewEntityType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TypesReviewEntityTypeMixin = Object with _$TypesReviewEntityTypeMixin;

