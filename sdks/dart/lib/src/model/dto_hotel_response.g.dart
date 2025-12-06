// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_hotel_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoHotelResponse extends DtoHotelResponse {
  @override
  final BuiltMap<String, String>? address;
  @override
  final String? checkInTime;
  @override
  final String? checkOutTime;
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? currency;
  @override
  final String? description;
  @override
  final String? email;
  @override
  final String? id;
  @override
  final String? lastViewedAt;
  @override
  final TypesLocation? location;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final num? popularityScore;
  @override
  final num? priceMax;
  @override
  final num? priceMin;
  @override
  final String? primaryImageUrl;
  @override
  final num? ratingAvg;
  @override
  final int? ratingCount;
  @override
  final int? roomCount;
  @override
  final String? slug;
  @override
  final int? starRating;
  @override
  final TypesStatus? status;
  @override
  final String? thumbnailUrl;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;
  @override
  final int? viewCount;
  @override
  final String? website;

  factory _$DtoHotelResponse(
          [void Function(DtoHotelResponseBuilder)? updates]) =>
      (DtoHotelResponseBuilder()..update(updates))._build();

  _$DtoHotelResponse._(
      {this.address,
      this.checkInTime,
      this.checkOutTime,
      this.createdAt,
      this.createdBy,
      this.currency,
      this.description,
      this.email,
      this.id,
      this.lastViewedAt,
      this.location,
      this.metadata,
      this.name,
      this.phone,
      this.popularityScore,
      this.priceMax,
      this.priceMin,
      this.primaryImageUrl,
      this.ratingAvg,
      this.ratingCount,
      this.roomCount,
      this.slug,
      this.starRating,
      this.status,
      this.thumbnailUrl,
      this.updatedAt,
      this.updatedBy,
      this.viewCount,
      this.website})
      : super._();
  @override
  DtoHotelResponse rebuild(void Function(DtoHotelResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoHotelResponseBuilder toBuilder() =>
      DtoHotelResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoHotelResponse &&
        address == other.address &&
        checkInTime == other.checkInTime &&
        checkOutTime == other.checkOutTime &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        currency == other.currency &&
        description == other.description &&
        email == other.email &&
        id == other.id &&
        lastViewedAt == other.lastViewedAt &&
        location == other.location &&
        metadata == other.metadata &&
        name == other.name &&
        phone == other.phone &&
        popularityScore == other.popularityScore &&
        priceMax == other.priceMax &&
        priceMin == other.priceMin &&
        primaryImageUrl == other.primaryImageUrl &&
        ratingAvg == other.ratingAvg &&
        ratingCount == other.ratingCount &&
        roomCount == other.roomCount &&
        slug == other.slug &&
        starRating == other.starRating &&
        status == other.status &&
        thumbnailUrl == other.thumbnailUrl &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        viewCount == other.viewCount &&
        website == other.website;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, checkOutTime.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, lastViewedAt.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, popularityScore.hashCode);
    _$hash = $jc(_$hash, priceMax.hashCode);
    _$hash = $jc(_$hash, priceMin.hashCode);
    _$hash = $jc(_$hash, primaryImageUrl.hashCode);
    _$hash = $jc(_$hash, ratingAvg.hashCode);
    _$hash = $jc(_$hash, ratingCount.hashCode);
    _$hash = $jc(_$hash, roomCount.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, starRating.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoHotelResponse')
          ..add('address', address)
          ..add('checkInTime', checkInTime)
          ..add('checkOutTime', checkOutTime)
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('currency', currency)
          ..add('description', description)
          ..add('email', email)
          ..add('id', id)
          ..add('lastViewedAt', lastViewedAt)
          ..add('location', location)
          ..add('metadata', metadata)
          ..add('name', name)
          ..add('phone', phone)
          ..add('popularityScore', popularityScore)
          ..add('priceMax', priceMax)
          ..add('priceMin', priceMin)
          ..add('primaryImageUrl', primaryImageUrl)
          ..add('ratingAvg', ratingAvg)
          ..add('ratingCount', ratingCount)
          ..add('roomCount', roomCount)
          ..add('slug', slug)
          ..add('starRating', starRating)
          ..add('status', status)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy)
          ..add('viewCount', viewCount)
          ..add('website', website))
        .toString();
  }
}

class DtoHotelResponseBuilder
    implements Builder<DtoHotelResponse, DtoHotelResponseBuilder> {
  _$DtoHotelResponse? _$v;

  MapBuilder<String, String>? _address;
  MapBuilder<String, String> get address =>
      _$this._address ??= MapBuilder<String, String>();
  set address(MapBuilder<String, String>? address) => _$this._address = address;

  String? _checkInTime;
  String? get checkInTime => _$this._checkInTime;
  set checkInTime(String? checkInTime) => _$this._checkInTime = checkInTime;

  String? _checkOutTime;
  String? get checkOutTime => _$this._checkOutTime;
  set checkOutTime(String? checkOutTime) => _$this._checkOutTime = checkOutTime;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _lastViewedAt;
  String? get lastViewedAt => _$this._lastViewedAt;
  set lastViewedAt(String? lastViewedAt) => _$this._lastViewedAt = lastViewedAt;

  TypesLocationBuilder? _location;
  TypesLocationBuilder get location =>
      _$this._location ??= TypesLocationBuilder();
  set location(TypesLocationBuilder? location) => _$this._location = location;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  num? _popularityScore;
  num? get popularityScore => _$this._popularityScore;
  set popularityScore(num? popularityScore) =>
      _$this._popularityScore = popularityScore;

  num? _priceMax;
  num? get priceMax => _$this._priceMax;
  set priceMax(num? priceMax) => _$this._priceMax = priceMax;

  num? _priceMin;
  num? get priceMin => _$this._priceMin;
  set priceMin(num? priceMin) => _$this._priceMin = priceMin;

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

  int? _roomCount;
  int? get roomCount => _$this._roomCount;
  set roomCount(int? roomCount) => _$this._roomCount = roomCount;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  int? _starRating;
  int? get starRating => _$this._starRating;
  set starRating(int? starRating) => _$this._starRating = starRating;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  int? _viewCount;
  int? get viewCount => _$this._viewCount;
  set viewCount(int? viewCount) => _$this._viewCount = viewCount;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  DtoHotelResponseBuilder() {
    DtoHotelResponse._defaults(this);
  }

  DtoHotelResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address?.toBuilder();
      _checkInTime = $v.checkInTime;
      _checkOutTime = $v.checkOutTime;
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _currency = $v.currency;
      _description = $v.description;
      _email = $v.email;
      _id = $v.id;
      _lastViewedAt = $v.lastViewedAt;
      _location = $v.location?.toBuilder();
      _metadata = $v.metadata?.toBuilder();
      _name = $v.name;
      _phone = $v.phone;
      _popularityScore = $v.popularityScore;
      _priceMax = $v.priceMax;
      _priceMin = $v.priceMin;
      _primaryImageUrl = $v.primaryImageUrl;
      _ratingAvg = $v.ratingAvg;
      _ratingCount = $v.ratingCount;
      _roomCount = $v.roomCount;
      _slug = $v.slug;
      _starRating = $v.starRating;
      _status = $v.status;
      _thumbnailUrl = $v.thumbnailUrl;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _viewCount = $v.viewCount;
      _website = $v.website;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoHotelResponse other) {
    _$v = other as _$DtoHotelResponse;
  }

  @override
  void update(void Function(DtoHotelResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoHotelResponse build() => _build();

  _$DtoHotelResponse _build() {
    _$DtoHotelResponse _$result;
    try {
      _$result = _$v ??
          _$DtoHotelResponse._(
            address: _address?.build(),
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            createdAt: createdAt,
            createdBy: createdBy,
            currency: currency,
            description: description,
            email: email,
            id: id,
            lastViewedAt: lastViewedAt,
            location: _location?.build(),
            metadata: _metadata?.build(),
            name: name,
            phone: phone,
            popularityScore: popularityScore,
            priceMax: priceMax,
            priceMin: priceMin,
            primaryImageUrl: primaryImageUrl,
            ratingAvg: ratingAvg,
            ratingCount: ratingCount,
            roomCount: roomCount,
            slug: slug,
            starRating: starRating,
            status: status,
            thumbnailUrl: thumbnailUrl,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
            viewCount: viewCount,
            website: website,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'address';
        _address?.build();

        _$failedField = 'location';
        _location?.build();
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoHotelResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
