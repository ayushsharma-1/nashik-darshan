// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_hotel_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdateHotelRequest extends DtoUpdateHotelRequest {
  @override
  final BuiltMap<String, String>? address;
  @override
  final String? checkInTime;
  @override
  final String? checkOutTime;
  @override
  final String? currency;
  @override
  final String? description;
  @override
  final String? email;
  @override
  final TypesLocation? location;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final num? priceMax;
  @override
  final num? priceMin;
  @override
  final String? primaryImageUrl;
  @override
  final int? roomCount;
  @override
  final int? starRating;
  @override
  final String? thumbnailUrl;
  @override
  final String? website;

  factory _$DtoUpdateHotelRequest(
          [void Function(DtoUpdateHotelRequestBuilder)? updates]) =>
      (DtoUpdateHotelRequestBuilder()..update(updates))._build();

  _$DtoUpdateHotelRequest._(
      {this.address,
      this.checkInTime,
      this.checkOutTime,
      this.currency,
      this.description,
      this.email,
      this.location,
      this.name,
      this.phone,
      this.priceMax,
      this.priceMin,
      this.primaryImageUrl,
      this.roomCount,
      this.starRating,
      this.thumbnailUrl,
      this.website})
      : super._();
  @override
  DtoUpdateHotelRequest rebuild(
          void Function(DtoUpdateHotelRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdateHotelRequestBuilder toBuilder() =>
      DtoUpdateHotelRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdateHotelRequest &&
        address == other.address &&
        checkInTime == other.checkInTime &&
        checkOutTime == other.checkOutTime &&
        currency == other.currency &&
        description == other.description &&
        email == other.email &&
        location == other.location &&
        name == other.name &&
        phone == other.phone &&
        priceMax == other.priceMax &&
        priceMin == other.priceMin &&
        primaryImageUrl == other.primaryImageUrl &&
        roomCount == other.roomCount &&
        starRating == other.starRating &&
        thumbnailUrl == other.thumbnailUrl &&
        website == other.website;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, checkOutTime.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, priceMax.hashCode);
    _$hash = $jc(_$hash, priceMin.hashCode);
    _$hash = $jc(_$hash, primaryImageUrl.hashCode);
    _$hash = $jc(_$hash, roomCount.hashCode);
    _$hash = $jc(_$hash, starRating.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdateHotelRequest')
          ..add('address', address)
          ..add('checkInTime', checkInTime)
          ..add('checkOutTime', checkOutTime)
          ..add('currency', currency)
          ..add('description', description)
          ..add('email', email)
          ..add('location', location)
          ..add('name', name)
          ..add('phone', phone)
          ..add('priceMax', priceMax)
          ..add('priceMin', priceMin)
          ..add('primaryImageUrl', primaryImageUrl)
          ..add('roomCount', roomCount)
          ..add('starRating', starRating)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('website', website))
        .toString();
  }
}

class DtoUpdateHotelRequestBuilder
    implements Builder<DtoUpdateHotelRequest, DtoUpdateHotelRequestBuilder> {
  _$DtoUpdateHotelRequest? _$v;

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

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  TypesLocationBuilder? _location;
  TypesLocationBuilder get location =>
      _$this._location ??= TypesLocationBuilder();
  set location(TypesLocationBuilder? location) => _$this._location = location;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

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

  int? _roomCount;
  int? get roomCount => _$this._roomCount;
  set roomCount(int? roomCount) => _$this._roomCount = roomCount;

  int? _starRating;
  int? get starRating => _$this._starRating;
  set starRating(int? starRating) => _$this._starRating = starRating;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  DtoUpdateHotelRequestBuilder() {
    DtoUpdateHotelRequest._defaults(this);
  }

  DtoUpdateHotelRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address?.toBuilder();
      _checkInTime = $v.checkInTime;
      _checkOutTime = $v.checkOutTime;
      _currency = $v.currency;
      _description = $v.description;
      _email = $v.email;
      _location = $v.location?.toBuilder();
      _name = $v.name;
      _phone = $v.phone;
      _priceMax = $v.priceMax;
      _priceMin = $v.priceMin;
      _primaryImageUrl = $v.primaryImageUrl;
      _roomCount = $v.roomCount;
      _starRating = $v.starRating;
      _thumbnailUrl = $v.thumbnailUrl;
      _website = $v.website;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdateHotelRequest other) {
    _$v = other as _$DtoUpdateHotelRequest;
  }

  @override
  void update(void Function(DtoUpdateHotelRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdateHotelRequest build() => _build();

  _$DtoUpdateHotelRequest _build() {
    _$DtoUpdateHotelRequest _$result;
    try {
      _$result = _$v ??
          _$DtoUpdateHotelRequest._(
            address: _address?.build(),
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            currency: currency,
            description: description,
            email: email,
            location: _location?.build(),
            name: name,
            phone: phone,
            priceMax: priceMax,
            priceMin: priceMin,
            primaryImageUrl: primaryImageUrl,
            roomCount: roomCount,
            starRating: starRating,
            thumbnailUrl: thumbnailUrl,
            website: website,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'address';
        _address?.build();

        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoUpdateHotelRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
