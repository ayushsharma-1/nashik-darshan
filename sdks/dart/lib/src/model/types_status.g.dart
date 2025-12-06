// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TypesStatus _$StatusPublished = const TypesStatus._('StatusPublished');
const TypesStatus _$StatusDeleted = const TypesStatus._('StatusDeleted');
const TypesStatus _$StatusArchived = const TypesStatus._('StatusArchived');
const TypesStatus _$StatusInactive = const TypesStatus._('StatusInactive');
const TypesStatus _$StatusPending = const TypesStatus._('StatusPending');
const TypesStatus _$StatusDraft = const TypesStatus._('StatusDraft');

TypesStatus _$valueOf(String name) {
  switch (name) {
    case 'StatusPublished':
      return _$StatusPublished;
    case 'StatusDeleted':
      return _$StatusDeleted;
    case 'StatusArchived':
      return _$StatusArchived;
    case 'StatusInactive':
      return _$StatusInactive;
    case 'StatusPending':
      return _$StatusPending;
    case 'StatusDraft':
      return _$StatusDraft;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TypesStatus> _$values =
    BuiltSet<TypesStatus>(const <TypesStatus>[
  _$StatusPublished,
  _$StatusDeleted,
  _$StatusArchived,
  _$StatusInactive,
  _$StatusPending,
  _$StatusDraft,
]);

class _$TypesStatusMeta {
  const _$TypesStatusMeta();
  TypesStatus get StatusPublished => _$StatusPublished;
  TypesStatus get StatusDeleted => _$StatusDeleted;
  TypesStatus get StatusArchived => _$StatusArchived;
  TypesStatus get StatusInactive => _$StatusInactive;
  TypesStatus get StatusPending => _$StatusPending;
  TypesStatus get StatusDraft => _$StatusDraft;
  TypesStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TypesStatus> get values => _$values;
}

abstract class _$TypesStatusMixin {
  // ignore: non_constant_identifier_names
  _$TypesStatusMeta get TypesStatus => const _$TypesStatusMeta();
}

Serializer<TypesStatus> _$typesStatusSerializer = _$TypesStatusSerializer();

class _$TypesStatusSerializer implements PrimitiveSerializer<TypesStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'StatusPublished': 'published',
    'StatusDeleted': 'deleted',
    'StatusArchived': 'archived',
    'StatusInactive': 'inactive',
    'StatusPending': 'pending',
    'StatusDraft': 'draft',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'published': 'StatusPublished',
    'deleted': 'StatusDeleted',
    'archived': 'StatusArchived',
    'inactive': 'StatusInactive',
    'pending': 'StatusPending',
    'draft': 'StatusDraft',
  };

  @override
  final Iterable<Type> types = const <Type>[TypesStatus];
  @override
  final String wireName = 'TypesStatus';

  @override
  Object serialize(Serializers serializers, TypesStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TypesStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TypesStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
