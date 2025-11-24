// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_place_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoPlaceResponse extends DtoPlaceResponse {
  @override
  final BuiltMap<String, String>? address;
  @override
  final BuiltList<String>? amenities;
  @override
  final BuiltList<String>? categories;
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? id;
  @override
  final BuiltList<DtoPlaceImageResponse>? images;
  @override
  final String? lastViewedAt;
  @override
  final TypesLocation? location;
  @override
  final String? longDescription;
  @override
  final String? placeType;
  @override
  final num? popularityScore;
  @override
  final String? primaryImageUrl;
  @override
  final num? ratingAvg;
  @override
  final int? ratingCount;
  @override
  final String? shortDescription;
  @override
  final String? slug;
  @override
  final TypesStatus? status;
  @override
  final String? subtitle;
  @override
  final String? thumbnailUrl;
  @override
  final String? title;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;
  @override
  final int? viewCount;

  factory _$DtoPlaceResponse(
          [void Function(DtoPlaceResponseBuilder)? updates]) =>
      (DtoPlaceResponseBuilder()..update(updates))._build();

  _$DtoPlaceResponse._(
      {this.address,
      this.amenities,
      this.categories,
      this.createdAt,
      this.createdBy,
      this.id,
      this.images,
      this.lastViewedAt,
      this.location,
      this.longDescription,
      this.placeType,
      this.popularityScore,
      this.primaryImageUrl,
      this.ratingAvg,
      this.ratingCount,
      this.shortDescription,
      this.slug,
      this.status,
      this.subtitle,
      this.thumbnailUrl,
      this.title,
      this.updatedAt,
      this.updatedBy,
      this.viewCount})
      : super._();
  @override
  DtoPlaceResponse rebuild(void Function(DtoPlaceResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoPlaceResponseBuilder toBuilder() =>
      DtoPlaceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoPlaceResponse &&
        address == other.address &&
        amenities == other.amenities &&
        categories == other.categories &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        id == other.id &&
        images == other.images &&
        lastViewedAt == other.lastViewedAt &&
        location == other.location &&
        longDescription == other.longDescription &&
        placeType == other.placeType &&
        popularityScore == other.popularityScore &&
        primaryImageUrl == other.primaryImageUrl &&
        ratingAvg == other.ratingAvg &&
        ratingCount == other.ratingCount &&
        shortDescription == other.shortDescription &&
        slug == other.slug &&
        status == other.status &&
        subtitle == other.subtitle &&
        thumbnailUrl == other.thumbnailUrl &&
        title == other.title &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        viewCount == other.viewCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, amenities.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, lastViewedAt.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, longDescription.hashCode);
    _$hash = $jc(_$hash, placeType.hashCode);
    _$hash = $jc(_$hash, popularityScore.hashCode);
    _$hash = $jc(_$hash, primaryImageUrl.hashCode);
    _$hash = $jc(_$hash, ratingAvg.hashCode);
    _$hash = $jc(_$hash, ratingCount.hashCode);
    _$hash = $jc(_$hash, shortDescription.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoPlaceResponse')
          ..add('address', address)
          ..add('amenities', amenities)
          ..add('categories', categories)
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('id', id)
          ..add('images', images)
          ..add('lastViewedAt', lastViewedAt)
          ..add('location', location)
          ..add('longDescription', longDescription)
          ..add('placeType', placeType)
          ..add('popularityScore', popularityScore)
          ..add('primaryImageUrl', primaryImageUrl)
          ..add('ratingAvg', ratingAvg)
          ..add('ratingCount', ratingCount)
          ..add('shortDescription', shortDescription)
          ..add('slug', slug)
          ..add('status', status)
          ..add('subtitle', subtitle)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('title', title)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy)
          ..add('viewCount', viewCount))
        .toString();
  }
}

class DtoPlaceResponseBuilder
    implements Builder<DtoPlaceResponse, DtoPlaceResponseBuilder> {
  _$DtoPlaceResponse? _$v;

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

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<DtoPlaceImageResponse>? _images;
  ListBuilder<DtoPlaceImageResponse> get images =>
      _$this._images ??= ListBuilder<DtoPlaceImageResponse>();
  set images(ListBuilder<DtoPlaceImageResponse>? images) =>
      _$this._images = images;

  String? _lastViewedAt;
  String? get lastViewedAt => _$this._lastViewedAt;
  set lastViewedAt(String? lastViewedAt) => _$this._lastViewedAt = lastViewedAt;

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

  num? _popularityScore;
  num? get popularityScore => _$this._popularityScore;
  set popularityScore(num? popularityScore) =>
      _$this._popularityScore = popularityScore;

  String? _primaryImageUrl;
  String? get primaryImageUrl => _$this._primaryImageUrl;
  set primaryImageUrl(String? primaryImageUrl) =>
      _$this._primaryImageUrl = primaryImageUrl;

  num? _ratingAvg;
  num? get ratingAvg => _$this._ratingAvg;
  set ratingAvg(num? ratingAvg) => _$this._ratingAvg = ratingAvg;

  int? _ratingCount;
  int? get ratingCount => _$this._ratingCount;
  set ratingCount(int? ratingCount) => _$this._ratingCount = ratingCount;

  String? _shortDescription;
  String? get shortDescription => _$this._shortDescription;
  set shortDescription(String? shortDescription) =>
      _$this._shortDescription = shortDescription;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  int? _viewCount;
  int? get viewCount => _$this._viewCount;
  set viewCount(int? viewCount) => _$this._viewCount = viewCount;

  DtoPlaceResponseBuilder() {
    DtoPlaceResponse._defaults(this);
  }

  DtoPlaceResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address?.toBuilder();
      _amenities = $v.amenities?.toBuilder();
      _categories = $v.categories?.toBuilder();
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _id = $v.id;
      _images = $v.images?.toBuilder();
      _lastViewedAt = $v.lastViewedAt;
      _location = $v.location?.toBuilder();
      _longDescription = $v.longDescription;
      _placeType = $v.placeType;
      _popularityScore = $v.popularityScore;
      _primaryImageUrl = $v.primaryImageUrl;
      _ratingAvg = $v.ratingAvg;
      _ratingCount = $v.ratingCount;
      _shortDescription = $v.shortDescription;
      _slug = $v.slug;
      _status = $v.status;
      _subtitle = $v.subtitle;
      _thumbnailUrl = $v.thumbnailUrl;
      _title = $v.title;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _viewCount = $v.viewCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoPlaceResponse other) {
    _$v = other as _$DtoPlaceResponse;
  }

  @override
  void update(void Function(DtoPlaceResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoPlaceResponse build() => _build();

  _$DtoPlaceResponse _build() {
    _$DtoPlaceResponse _$result;
    try {
      _$result = _$v ??
          _$DtoPlaceResponse._(
            address: _address?.build(),
            amenities: _amenities?.build(),
            categories: _categories?.build(),
            createdAt: createdAt,
            createdBy: createdBy,
            id: id,
            images: _images?.build(),
            lastViewedAt: lastViewedAt,
            location: _location?.build(),
            longDescription: longDescription,
            placeType: placeType,
            popularityScore: popularityScore,
            primaryImageUrl: primaryImageUrl,
            ratingAvg: ratingAvg,
            ratingCount: ratingCount,
            shortDescription: shortDescription,
            slug: slug,
            status: status,
            subtitle: subtitle,
            thumbnailUrl: thumbnailUrl,
            title: title,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
            viewCount: viewCount,
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

        _$failedField = 'images';
        _images?.build();

        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoPlaceResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
