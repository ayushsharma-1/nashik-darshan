// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_place_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdatePlaceRequest extends DtoUpdatePlaceRequest {
  @override
  final BuiltMap<String, String>? address;
  @override
  final BuiltList<String>? amenities;
  @override
  final BuiltList<String>? categories;
  @override
  final TypesLocation? location;
  @override
  final String? longDescription;
  @override
  final String? placeType;
  @override
  final String? primaryImageUrl;
  @override
  final String? shortDescription;
  @override
  final String? slug;
  @override
  final String? subtitle;
  @override
  final String? thumbnailUrl;
  @override
  final String? title;

  factory _$DtoUpdatePlaceRequest(
          [void Function(DtoUpdatePlaceRequestBuilder)? updates]) =>
      (DtoUpdatePlaceRequestBuilder()..update(updates))._build();

  _$DtoUpdatePlaceRequest._(
      {this.address,
      this.amenities,
      this.categories,
      this.location,
      this.longDescription,
      this.placeType,
      this.primaryImageUrl,
      this.shortDescription,
      this.slug,
      this.subtitle,
      this.thumbnailUrl,
      this.title})
      : super._();
  @override
  DtoUpdatePlaceRequest rebuild(
          void Function(DtoUpdatePlaceRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdatePlaceRequestBuilder toBuilder() =>
      DtoUpdatePlaceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdatePlaceRequest &&
        address == other.address &&
        amenities == other.amenities &&
        categories == other.categories &&
        location == other.location &&
        longDescription == other.longDescription &&
        placeType == other.placeType &&
        primaryImageUrl == other.primaryImageUrl &&
        shortDescription == other.shortDescription &&
        slug == other.slug &&
        subtitle == other.subtitle &&
        thumbnailUrl == other.thumbnailUrl &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, amenities.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, longDescription.hashCode);
    _$hash = $jc(_$hash, placeType.hashCode);
    _$hash = $jc(_$hash, primaryImageUrl.hashCode);
    _$hash = $jc(_$hash, shortDescription.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdatePlaceRequest')
          ..add('address', address)
          ..add('amenities', amenities)
          ..add('categories', categories)
          ..add('location', location)
          ..add('longDescription', longDescription)
          ..add('placeType', placeType)
          ..add('primaryImageUrl', primaryImageUrl)
          ..add('shortDescription', shortDescription)
          ..add('slug', slug)
          ..add('subtitle', subtitle)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('title', title))
        .toString();
  }
}

class DtoUpdatePlaceRequestBuilder
    implements Builder<DtoUpdatePlaceRequest, DtoUpdatePlaceRequestBuilder> {
  _$DtoUpdatePlaceRequest? _$v;

  MapBuilder<String, String>? _address;
  MapBuilder<String, String> get address =>
      _$this._address ??= MapBuilder<String, String>();
  set address(MapBuilder<String, String>? address) => _$this._address = address;

  ListBuilder<String>? _amenities;
  ListBuilder<String> get amenities =>
      _$this._amenities ??= ListBuilder<String>();
  set amenities(ListBuilder<String>? amenities) =>
      _$this._amenities = amenities;

  ListBuilder<String>? _categories;
  ListBuilder<String> get categories =>
      _$this._categories ??= ListBuilder<String>();
  set categories(ListBuilder<String>? categories) =>
      _$this._categories = categories;

  TypesLocationBuilder? _location;
  TypesLocationBuilder get location =>
      _$this._location ??= TypesLocationBuilder();
  set location(TypesLocationBuilder? location) => _$this._location = location;

  String? _longDescription;
  String? get longDescription => _$this._longDescription;
  set longDescription(String? longDescription) =>
      _$this._longDescription = longDescription;

  String? _placeType;
  String? get placeType => _$this._placeType;
  set placeType(String? placeType) => _$this._placeType = placeType;

  String? _primaryImageUrl;
  String? get primaryImageUrl => _$this._primaryImageUrl;
  set primaryImageUrl(String? primaryImageUrl) =>
      _$this._primaryImageUrl = primaryImageUrl;

  String? _shortDescription;
  String? get shortDescription => _$this._shortDescription;
  set shortDescription(String? shortDescription) =>
      _$this._shortDescription = shortDescription;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  DtoUpdatePlaceRequestBuilder() {
    DtoUpdatePlaceRequest._defaults(this);
  }

  DtoUpdatePlaceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address?.toBuilder();
      _amenities = $v.amenities?.toBuilder();
      _categories = $v.categories?.toBuilder();
      _location = $v.location?.toBuilder();
      _longDescription = $v.longDescription;
      _placeType = $v.placeType;
      _primaryImageUrl = $v.primaryImageUrl;
      _shortDescription = $v.shortDescription;
      _slug = $v.slug;
      _subtitle = $v.subtitle;
      _thumbnailUrl = $v.thumbnailUrl;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdatePlaceRequest other) {
    _$v = other as _$DtoUpdatePlaceRequest;
  }

  @override
  void update(void Function(DtoUpdatePlaceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdatePlaceRequest build() => _build();

  _$DtoUpdatePlaceRequest _build() {
    _$DtoUpdatePlaceRequest _$result;
    try {
      _$result = _$v ??
          _$DtoUpdatePlaceRequest._(
            address: _address?.build(),
            amenities: _amenities?.build(),
            categories: _categories?.build(),
            location: _location?.build(),
            longDescription: longDescription,
            placeType: placeType,
            primaryImageUrl: primaryImageUrl,
            shortDescription: shortDescription,
            slug: slug,
            subtitle: subtitle,
            thumbnailUrl: thumbnailUrl,
            title: title,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'address';
        _address?.build();
        _$failedField = 'amenities';
        _amenities?.build();
        _$failedField = 'categories';
        _categories?.build();
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoUpdatePlaceRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
