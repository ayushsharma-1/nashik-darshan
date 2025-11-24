// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TypesLocation extends TypesLocation {
  @override
  final num? latitude;
  @override
  final num? longitude;

  factory _$TypesLocation([void Function(TypesLocationBuilder)? updates]) =>
      (TypesLocationBuilder()..update(updates))._build();

  _$TypesLocation._({this.latitude, this.longitude}) : super._();
  @override
  TypesLocation rebuild(void Function(TypesLocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TypesLocationBuilder toBuilder() => TypesLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypesLocation &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypesLocation')
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class TypesLocationBuilder
    implements Builder<TypesLocation, TypesLocationBuilder> {
  _$TypesLocation? _$v;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  TypesLocationBuilder() {
    TypesLocation._defaults(this);
  }

  TypesLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypesLocation other) {
    _$v = other as _$TypesLocation;
  }

  @override
  void update(void Function(TypesLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypesLocation build() => _build();

  _$TypesLocation _build() {
    final _$result = _$v ??
        _$TypesLocation._(
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
