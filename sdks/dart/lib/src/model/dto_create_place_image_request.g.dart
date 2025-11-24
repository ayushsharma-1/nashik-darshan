// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_create_place_image_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoCreatePlaceImageRequest extends DtoCreatePlaceImageRequest {
  @override
  final String? alt;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final int? pos;
  @override
  final String url;

  factory _$DtoCreatePlaceImageRequest(
          [void Function(DtoCreatePlaceImageRequestBuilder)? updates]) =>
      (DtoCreatePlaceImageRequestBuilder()..update(updates))._build();

  _$DtoCreatePlaceImageRequest._(
      {this.alt, this.metadata, this.pos, required this.url})
      : super._();
  @override
  DtoCreatePlaceImageRequest rebuild(
          void Function(DtoCreatePlaceImageRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoCreatePlaceImageRequestBuilder toBuilder() =>
      DtoCreatePlaceImageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoCreatePlaceImageRequest &&
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
    return (newBuiltValueToStringHelper(r'DtoCreatePlaceImageRequest')
          ..add('alt', alt)
          ..add('metadata', metadata)
          ..add('pos', pos)
          ..add('url', url))
        .toString();
  }
}

class DtoCreatePlaceImageRequestBuilder
    implements
        Builder<DtoCreatePlaceImageRequest, DtoCreatePlaceImageRequestBuilder> {
  _$DtoCreatePlaceImageRequest? _$v;

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

  DtoCreatePlaceImageRequestBuilder() {
    DtoCreatePlaceImageRequest._defaults(this);
  }

  DtoCreatePlaceImageRequestBuilder get _$this {
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
  void replace(DtoCreatePlaceImageRequest other) {
    _$v = other as _$DtoCreatePlaceImageRequest;
  }

  @override
  void update(void Function(DtoCreatePlaceImageRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoCreatePlaceImageRequest build() => _build();

  _$DtoCreatePlaceImageRequest _build() {
    _$DtoCreatePlaceImageRequest _$result;
    try {
      _$result = _$v ??
          _$DtoCreatePlaceImageRequest._(
            alt: alt,
            metadata: _metadata?.build(),
            pos: pos,
            url: BuiltValueNullFieldError.checkNotNull(
                url, r'DtoCreatePlaceImageRequest', 'url'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoCreatePlaceImageRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
