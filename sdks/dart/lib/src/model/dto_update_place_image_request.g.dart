// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_place_image_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdatePlaceImageRequest extends DtoUpdatePlaceImageRequest {
  @override
  final String? alt;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final int? pos;
  @override
  final String? url;

  factory _$DtoUpdatePlaceImageRequest(
          [void Function(DtoUpdatePlaceImageRequestBuilder)? updates]) =>
      (DtoUpdatePlaceImageRequestBuilder()..update(updates))._build();

  _$DtoUpdatePlaceImageRequest._({this.alt, this.metadata, this.pos, this.url})
      : super._();
  @override
  DtoUpdatePlaceImageRequest rebuild(
          void Function(DtoUpdatePlaceImageRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdatePlaceImageRequestBuilder toBuilder() =>
      DtoUpdatePlaceImageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdatePlaceImageRequest &&
        alt == other.alt &&
        metadata == other.metadata &&
        pos == other.pos &&
        url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, alt.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, pos.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdatePlaceImageRequest')
          ..add('alt', alt)
          ..add('metadata', metadata)
          ..add('pos', pos)
          ..add('url', url))
        .toString();
  }
}

class DtoUpdatePlaceImageRequestBuilder
    implements
        Builder<DtoUpdatePlaceImageRequest, DtoUpdatePlaceImageRequestBuilder> {
  _$DtoUpdatePlaceImageRequest? _$v;

  String? _alt;
  String? get alt => _$this._alt;
  set alt(String? alt) => _$this._alt = alt;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  int? _pos;
  int? get pos => _$this._pos;
  set pos(int? pos) => _$this._pos = pos;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  DtoUpdatePlaceImageRequestBuilder() {
    DtoUpdatePlaceImageRequest._defaults(this);
  }

  DtoUpdatePlaceImageRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _alt = $v.alt;
      _metadata = $v.metadata?.toBuilder();
      _pos = $v.pos;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdatePlaceImageRequest other) {
    _$v = other as _$DtoUpdatePlaceImageRequest;
  }

  @override
  void update(void Function(DtoUpdatePlaceImageRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdatePlaceImageRequest build() => _build();

  _$DtoUpdatePlaceImageRequest _build() {
    _$DtoUpdatePlaceImageRequest _$result;
    try {
      _$result = _$v ??
          _$DtoUpdatePlaceImageRequest._(
            alt: alt,
            metadata: _metadata?.build(),
            pos: pos,
            url: url,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoUpdatePlaceImageRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
