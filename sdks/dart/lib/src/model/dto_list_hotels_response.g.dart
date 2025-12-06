// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_list_hotels_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoListHotelsResponse extends DtoListHotelsResponse {
  @override
  final BuiltList<DtoHotelResponse>? items;
  @override
  final TypesPaginationResponse? pagination;

  factory _$DtoListHotelsResponse(
          [void Function(DtoListHotelsResponseBuilder)? updates]) =>
      (DtoListHotelsResponseBuilder()..update(updates))._build();

  _$DtoListHotelsResponse._({this.items, this.pagination}) : super._();
  @override
  DtoListHotelsResponse rebuild(
          void Function(DtoListHotelsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoListHotelsResponseBuilder toBuilder() =>
      DtoListHotelsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoListHotelsResponse &&
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
    return (newBuiltValueToStringHelper(r'DtoListHotelsResponse')
          ..add('items', items)
          ..add('pagination', pagination))
        .toString();
  }
}

class DtoListHotelsResponseBuilder
    implements Builder<DtoListHotelsResponse, DtoListHotelsResponseBuilder> {
  _$DtoListHotelsResponse? _$v;

  ListBuilder<DtoHotelResponse>? _items;
  ListBuilder<DtoHotelResponse> get items =>
      _$this._items ??= ListBuilder<DtoHotelResponse>();
  set items(ListBuilder<DtoHotelResponse>? items) => _$this._items = items;

  TypesPaginationResponseBuilder? _pagination;
  TypesPaginationResponseBuilder get pagination =>
      _$this._pagination ??= TypesPaginationResponseBuilder();
  set pagination(TypesPaginationResponseBuilder? pagination) =>
      _$this._pagination = pagination;

  DtoListHotelsResponseBuilder() {
    DtoListHotelsResponse._defaults(this);
  }

  DtoListHotelsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoListHotelsResponse other) {
    _$v = other as _$DtoListHotelsResponse;
  }

  @override
  void update(void Function(DtoListHotelsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoListHotelsResponse build() => _build();

  _$DtoListHotelsResponse _build() {
    _$DtoListHotelsResponse _$result;
    try {
      _$result = _$v ??
          _$DtoListHotelsResponse._(
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
            r'DtoListHotelsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
