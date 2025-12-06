// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_create_category_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoCreateCategoryRequest extends DtoCreateCategoryRequest {
  @override
  final String? description;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final String name;
  @override
  final String slug;

  factory _$DtoCreateCategoryRequest(
          [void Function(DtoCreateCategoryRequestBuilder)? updates]) =>
      (DtoCreateCategoryRequestBuilder()..update(updates))._build();

  _$DtoCreateCategoryRequest._(
      {this.description, this.metadata, required this.name, required this.slug})
      : super._();
  @override
  DtoCreateCategoryRequest rebuild(
          void Function(DtoCreateCategoryRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoCreateCategoryRequestBuilder toBuilder() =>
      DtoCreateCategoryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoCreateCategoryRequest &&
        description == other.description &&
        metadata == other.metadata &&
        name == other.name &&
        slug == other.slug;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoCreateCategoryRequest')
          ..add('description', description)
          ..add('metadata', metadata)
          ..add('name', name)
          ..add('slug', slug))
        .toString();
  }
}

class DtoCreateCategoryRequestBuilder
    implements
        Builder<DtoCreateCategoryRequest, DtoCreateCategoryRequestBuilder> {
  _$DtoCreateCategoryRequest? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

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

  DtoCreateCategoryRequestBuilder() {
    DtoCreateCategoryRequest._defaults(this);
  }

  DtoCreateCategoryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _metadata = $v.metadata?.toBuilder();
      _name = $v.name;
      _slug = $v.slug;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoCreateCategoryRequest other) {
    _$v = other as _$DtoCreateCategoryRequest;
  }

  @override
  void update(void Function(DtoCreateCategoryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoCreateCategoryRequest build() => _build();

  _$DtoCreateCategoryRequest _build() {
    _$DtoCreateCategoryRequest _$result;
    try {
      _$result = _$v ??
          _$DtoCreateCategoryRequest._(
            description: description,
            metadata: _metadata?.build(),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'DtoCreateCategoryRequest', 'name'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'DtoCreateCategoryRequest', 'slug'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoCreateCategoryRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
