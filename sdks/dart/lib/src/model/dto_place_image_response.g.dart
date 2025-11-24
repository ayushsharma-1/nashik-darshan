// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_place_image_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoPlaceImageResponse extends DtoPlaceImageResponse {
  @override
  final String? alt;
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? id;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final String? placeId;
  @override
  final int? pos;
  @override
  final TypesStatus? status;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;
  @override
  final String? url;

  factory _$DtoPlaceImageResponse(
          [void Function(DtoPlaceImageResponseBuilder)? updates]) =>
      (DtoPlaceImageResponseBuilder()..update(updates))._build();

  _$DtoPlaceImageResponse._(
      {this.alt,
      this.createdAt,
      this.createdBy,
      this.id,
      this.metadata,
      this.placeId,
      this.pos,
      this.status,
      this.updatedAt,
      this.updatedBy,
      this.url})
      : super._();
  @override
  DtoPlaceImageResponse rebuild(
          void Function(DtoPlaceImageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoPlaceImageResponseBuilder toBuilder() =>
      DtoPlaceImageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoPlaceImageResponse &&
        alt == other.alt &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        id == other.id &&
        metadata == other.metadata &&
        placeId == other.placeId &&
        pos == other.pos &&
        status == other.status &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, alt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, placeId.hashCode);
    _$hash = $jc(_$hash, pos.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoPlaceImageResponse')
          ..add('alt', alt)
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('id', id)
          ..add('metadata', metadata)
          ..add('placeId', placeId)
          ..add('pos', pos)
          ..add('status', status)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy)
          ..add('url', url))
        .toString();
  }
}

class DtoPlaceImageResponseBuilder
    implements Builder<DtoPlaceImageResponse, DtoPlaceImageResponseBuilder> {
  _$DtoPlaceImageResponse? _$v;

  String? _alt;
  String? get alt => _$this._alt;
  set alt(String? alt) => _$this._alt = alt;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  String? _placeId;
  String? get placeId => _$this._placeId;
  set placeId(String? placeId) => _$this._placeId = placeId;

  int? _pos;
  int? get pos => _$this._pos;
  set pos(int? pos) => _$this._pos = pos;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  DtoPlaceImageResponseBuilder() {
    DtoPlaceImageResponse._defaults(this);
  }

  DtoPlaceImageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _alt = $v.alt;
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _id = $v.id;
      _metadata = $v.metadata?.toBuilder();
      _placeId = $v.placeId;
      _pos = $v.pos;
      _status = $v.status;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoPlaceImageResponse other) {
    _$v = other as _$DtoPlaceImageResponse;
  }

  @override
  void update(void Function(DtoPlaceImageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoPlaceImageResponse build() => _build();

  _$DtoPlaceImageResponse _build() {
    _$DtoPlaceImageResponse _$result;
    try {
      _$result = _$v ??
          _$DtoPlaceImageResponse._(
            alt: alt,
            createdAt: createdAt,
            createdBy: createdBy,
            id: id,
            metadata: _metadata?.build(),
            placeId: placeId,
            pos: pos,
            status: status,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
            url: url,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoPlaceImageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
