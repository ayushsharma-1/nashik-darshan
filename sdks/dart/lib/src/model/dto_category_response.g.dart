// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_category_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoCategoryResponse extends DtoCategoryResponse {
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? description;
  @override
  final String? id;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final String? name;
  @override
  final String? slug;
  @override
  final TypesStatus? status;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;

  factory _$DtoCategoryResponse(
          [void Function(DtoCategoryResponseBuilder)? updates]) =>
      (DtoCategoryResponseBuilder()..update(updates))._build();

  _$DtoCategoryResponse._(
      {this.createdAt,
      this.createdBy,
      this.description,
      this.id,
      this.metadata,
      this.name,
      this.slug,
      this.status,
      this.updatedAt,
      this.updatedBy})
      : super._();
  @override
  DtoCategoryResponse rebuild(
          void Function(DtoCategoryResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoCategoryResponseBuilder toBuilder() =>
      DtoCategoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoCategoryResponse &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        description == other.description &&
        id == other.id &&
        metadata == other.metadata &&
        name == other.name &&
        slug == other.slug &&
        status == other.status &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoCategoryResponse')
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('description', description)
          ..add('id', id)
          ..add('metadata', metadata)
          ..add('name', name)
          ..add('slug', slug)
          ..add('status', status)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy))
        .toString();
  }
}

class DtoCategoryResponseBuilder
    implements Builder<DtoCategoryResponse, DtoCategoryResponseBuilder> {
  _$DtoCategoryResponse? _$v;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  DtoCategoryResponseBuilder() {
    DtoCategoryResponse._defaults(this);
  }

  DtoCategoryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _description = $v.description;
      _id = $v.id;
      _metadata = $v.metadata?.toBuilder();
      _name = $v.name;
      _slug = $v.slug;
      _status = $v.status;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoCategoryResponse other) {
    _$v = other as _$DtoCategoryResponse;
  }

  @override
  void update(void Function(DtoCategoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoCategoryResponse build() => _build();

  _$DtoCategoryResponse _build() {
    _$DtoCategoryResponse _$result;
    try {
      _$result = _$v ??
          _$DtoCategoryResponse._(
            createdAt: createdAt,
            createdBy: createdBy,
            description: description,
            id: id,
            metadata: _metadata?.build(),
            name: name,
            slug: slug,
            status: status,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoCategoryResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
