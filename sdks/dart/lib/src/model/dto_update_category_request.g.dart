// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_category_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdateCategoryRequest extends DtoUpdateCategoryRequest {
  @override
  final String? description;
  @override
  final String? name;
  @override
  final String? slug;

  factory _$DtoUpdateCategoryRequest(
          [void Function(DtoUpdateCategoryRequestBuilder)? updates]) =>
      (DtoUpdateCategoryRequestBuilder()..update(updates))._build();

  _$DtoUpdateCategoryRequest._({this.description, this.name, this.slug})
      : super._();
  @override
  DtoUpdateCategoryRequest rebuild(
          void Function(DtoUpdateCategoryRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdateCategoryRequestBuilder toBuilder() =>
      DtoUpdateCategoryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdateCategoryRequest &&
        description == other.description &&
        name == other.name &&
        slug == other.slug;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdateCategoryRequest')
          ..add('description', description)
          ..add('name', name)
          ..add('slug', slug))
        .toString();
  }
}

class DtoUpdateCategoryRequestBuilder
    implements
        Builder<DtoUpdateCategoryRequest, DtoUpdateCategoryRequestBuilder> {
  _$DtoUpdateCategoryRequest? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  DtoUpdateCategoryRequestBuilder() {
    DtoUpdateCategoryRequest._defaults(this);
  }

  DtoUpdateCategoryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _name = $v.name;
      _slug = $v.slug;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdateCategoryRequest other) {
    _$v = other as _$DtoUpdateCategoryRequest;
  }

  @override
  void update(void Function(DtoUpdateCategoryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdateCategoryRequest build() => _build();

  _$DtoUpdateCategoryRequest _build() {
    final _$result = _$v ??
        _$DtoUpdateCategoryRequest._(
          description: description,
          name: name,
          slug: slug,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
