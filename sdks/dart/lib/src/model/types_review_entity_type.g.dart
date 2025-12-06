// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_review_entity_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypesReviewEntityType _$EntityTypePlace =
    const TypesReviewEntityType._('EntityTypePlace');
const TypesReviewEntityType _$EntityTypeHotel =
    const TypesReviewEntityType._('EntityTypeHotel');
const TypesReviewEntityType _$EntityTypeRestaurant =
    const TypesReviewEntityType._('EntityTypeRestaurant');
const TypesReviewEntityType _$EntityTypeEvent =
    const TypesReviewEntityType._('EntityTypeEvent');
const TypesReviewEntityType _$EntityTypeExperience =
    const TypesReviewEntityType._('EntityTypeExperience');
const TypesReviewEntityType _$EntityTypeAttraction =
    const TypesReviewEntityType._('EntityTypeAttraction');

TypesReviewEntityType _$valueOf(String name) {
  switch (name) {
    case 'EntityTypePlace':
      return _$EntityTypePlace;
    case 'EntityTypeHotel':
      return _$EntityTypeHotel;
    case 'EntityTypeRestaurant':
      return _$EntityTypeRestaurant;
    case 'EntityTypeEvent':
      return _$EntityTypeEvent;
    case 'EntityTypeExperience':
      return _$EntityTypeExperience;
    case 'EntityTypeAttraction':
      return _$EntityTypeAttraction;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TypesReviewEntityType> _$values =
    BuiltSet<TypesReviewEntityType>(const <TypesReviewEntityType>[
  _$EntityTypePlace,
  _$EntityTypeHotel,
  _$EntityTypeRestaurant,
  _$EntityTypeEvent,
  _$EntityTypeExperience,
  _$EntityTypeAttraction,
]);

class _$TypesReviewEntityTypeMeta {
  const _$TypesReviewEntityTypeMeta();
  TypesReviewEntityType get EntityTypePlace => _$EntityTypePlace;
  TypesReviewEntityType get EntityTypeHotel => _$EntityTypeHotel;
  TypesReviewEntityType get EntityTypeRestaurant => _$EntityTypeRestaurant;
  TypesReviewEntityType get EntityTypeEvent => _$EntityTypeEvent;
  TypesReviewEntityType get EntityTypeExperience => _$EntityTypeExperience;
  TypesReviewEntityType get EntityTypeAttraction => _$EntityTypeAttraction;
  TypesReviewEntityType valueOf(String name) => _$valueOf(name);
  BuiltSet<TypesReviewEntityType> get values => _$values;
}

abstract class _$TypesReviewEntityTypeMixin {
  // ignore: non_constant_identifier_names
  _$TypesReviewEntityTypeMeta get TypesReviewEntityType =>
      const _$TypesReviewEntityTypeMeta();
}

Serializer<TypesReviewEntityType> _$typesReviewEntityTypeSerializer =
    _$TypesReviewEntityTypeSerializer();

class _$TypesReviewEntityTypeSerializer
    implements PrimitiveSerializer<TypesReviewEntityType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'EntityTypePlace': 'place',
    'EntityTypeHotel': 'hotel',
    'EntityTypeRestaurant': 'restaurant',
    'EntityTypeEvent': 'event',
    'EntityTypeExperience': 'experience',
    'EntityTypeAttraction': 'attraction',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'place': 'EntityTypePlace',
    'hotel': 'EntityTypeHotel',
    'restaurant': 'EntityTypeRestaurant',
    'event': 'EntityTypeEvent',
    'experience': 'EntityTypeExperience',
    'attraction': 'EntityTypeAttraction',
  };

  @override
  final Iterable<Type> types = const <Type>[TypesReviewEntityType];
  @override
  final String wireName = 'TypesReviewEntityType';

  @override
  Object serialize(Serializers serializers, TypesReviewEntityType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TypesReviewEntityType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TypesReviewEntityType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
