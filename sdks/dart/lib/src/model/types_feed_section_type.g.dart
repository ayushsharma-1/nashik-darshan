// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_feed_section_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypesFeedSectionType _$SectionTypeLatest =
    const TypesFeedSectionType._('SectionTypeLatest');
const TypesFeedSectionType _$SectionTypeTrending =
    const TypesFeedSectionType._('SectionTypeTrending');
const TypesFeedSectionType _$SectionTypePopular =
    const TypesFeedSectionType._('SectionTypePopular');
const TypesFeedSectionType _$SectionTypeNearby =
    const TypesFeedSectionType._('SectionTypeNearby');

TypesFeedSectionType _$valueOf(String name) {
  switch (name) {
    case 'SectionTypeLatest':
      return _$SectionTypeLatest;
    case 'SectionTypeTrending':
      return _$SectionTypeTrending;
    case 'SectionTypePopular':
      return _$SectionTypePopular;
    case 'SectionTypeNearby':
      return _$SectionTypeNearby;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TypesFeedSectionType> _$values =
    BuiltSet<TypesFeedSectionType>(const <TypesFeedSectionType>[
  _$SectionTypeLatest,
  _$SectionTypeTrending,
  _$SectionTypePopular,
  _$SectionTypeNearby,
]);

class _$TypesFeedSectionTypeMeta {
  const _$TypesFeedSectionTypeMeta();
  TypesFeedSectionType get SectionTypeLatest => _$SectionTypeLatest;
  TypesFeedSectionType get SectionTypeTrending => _$SectionTypeTrending;
  TypesFeedSectionType get SectionTypePopular => _$SectionTypePopular;
  TypesFeedSectionType get SectionTypeNearby => _$SectionTypeNearby;
  TypesFeedSectionType valueOf(String name) => _$valueOf(name);
  BuiltSet<TypesFeedSectionType> get values => _$values;
}

abstract class _$TypesFeedSectionTypeMixin {
  // ignore: non_constant_identifier_names
  _$TypesFeedSectionTypeMeta get TypesFeedSectionType =>
      const _$TypesFeedSectionTypeMeta();
}

Serializer<TypesFeedSectionType> _$typesFeedSectionTypeSerializer =
    _$TypesFeedSectionTypeSerializer();

class _$TypesFeedSectionTypeSerializer
    implements PrimitiveSerializer<TypesFeedSectionType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SectionTypeLatest': 'latest',
    'SectionTypeTrending': 'trending',
    'SectionTypePopular': 'popular',
    'SectionTypeNearby': 'nearby',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'latest': 'SectionTypeLatest',
    'trending': 'SectionTypeTrending',
    'popular': 'SectionTypePopular',
    'nearby': 'SectionTypeNearby',
  };

  @override
  final Iterable<Type> types = const <Type>[TypesFeedSectionType];
  @override
  final String wireName = 'TypesFeedSectionType';

  @override
  Object serialize(Serializers serializers, TypesFeedSectionType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TypesFeedSectionType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TypesFeedSectionType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
