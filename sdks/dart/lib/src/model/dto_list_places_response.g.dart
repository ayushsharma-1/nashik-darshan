// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_list_places_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoListPlacesResponse extends DtoListPlacesResponse {
  @override
  final BuiltList<DtoPlaceResponse>? items;
  @override
  final TypesPaginationResponse? pagination;

  factory _$DtoListPlacesResponse(
          [void Function(DtoListPlacesResponseBuilder)? updates]) =>
      (DtoListPlacesResponseBuilder()..update(updates))._build();

  _$DtoListPlacesResponse._({this.items, this.pagination}) : super._();
  @override
  DtoListPlacesResponse rebuild(
          void Function(DtoListPlacesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoListPlacesResponseBuilder toBuilder() =>
      DtoListPlacesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoListPlacesResponse &&
        items == other.items &&
        pagination == other.pagination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoListPlacesResponse')
          ..add('items', items)
          ..add('pagination', pagination))
        .toString();
  }
}

class DtoListPlacesResponseBuilder
    implements Builder<DtoListPlacesResponse, DtoListPlacesResponseBuilder> {
  _$DtoListPlacesResponse? _$v;

  ListBuilder<DtoPlaceResponse>? _items;
  ListBuilder<DtoPlaceResponse> get items =>
      _$this._items ??= ListBuilder<DtoPlaceResponse>();
  set items(ListBuilder<DtoPlaceResponse>? items) => _$this._items = items;

  TypesPaginationResponseBuilder? _pagination;
  TypesPaginationResponseBuilder get pagination =>
      _$this._pagination ??= TypesPaginationResponseBuilder();
  set pagination(TypesPaginationResponseBuilder? pagination) =>
      _$this._pagination = pagination;

  DtoListPlacesResponseBuilder() {
    DtoListPlacesResponse._defaults(this);
  }

  DtoListPlacesResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoListPlacesResponse other) {
    _$v = other as _$DtoListPlacesResponse;
  }

  @override
  void update(void Function(DtoListPlacesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoListPlacesResponse build() => _build();

  _$DtoListPlacesResponse _build() {
    _$DtoListPlacesResponse _$result;
    try {
      _$result = _$v ??
          _$DtoListPlacesResponse._(
            items: _items?.build(),
            pagination: _pagination?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoListPlacesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
