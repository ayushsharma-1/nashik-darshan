// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_list_categories_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoListCategoriesResponse extends DtoListCategoriesResponse {
  @override
  final BuiltList<DtoCategoryResponse>? items;
  @override
  final TypesPaginationResponse? pagination;

  factory _$DtoListCategoriesResponse(
          [void Function(DtoListCategoriesResponseBuilder)? updates]) =>
      (DtoListCategoriesResponseBuilder()..update(updates))._build();

  _$DtoListCategoriesResponse._({this.items, this.pagination}) : super._();
  @override
  DtoListCategoriesResponse rebuild(
          void Function(DtoListCategoriesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoListCategoriesResponseBuilder toBuilder() =>
      DtoListCategoriesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoListCategoriesResponse &&
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
    return (newBuiltValueToStringHelper(r'DtoListCategoriesResponse')
          ..add('items', items)
          ..add('pagination', pagination))
        .toString();
  }
}

class DtoListCategoriesResponseBuilder
    implements
        Builder<DtoListCategoriesResponse, DtoListCategoriesResponseBuilder> {
  _$DtoListCategoriesResponse? _$v;

  ListBuilder<DtoCategoryResponse>? _items;
  ListBuilder<DtoCategoryResponse> get items =>
      _$this._items ??= ListBuilder<DtoCategoryResponse>();
  set items(ListBuilder<DtoCategoryResponse>? items) => _$this._items = items;

  TypesPaginationResponseBuilder? _pagination;
  TypesPaginationResponseBuilder get pagination =>
      _$this._pagination ??= TypesPaginationResponseBuilder();
  set pagination(TypesPaginationResponseBuilder? pagination) =>
      _$this._pagination = pagination;

  DtoListCategoriesResponseBuilder() {
    DtoListCategoriesResponse._defaults(this);
  }

  DtoListCategoriesResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoListCategoriesResponse other) {
    _$v = other as _$DtoListCategoriesResponse;
  }

  @override
  void update(void Function(DtoListCategoriesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoListCategoriesResponse build() => _build();

  _$DtoListCategoriesResponse _build() {
    _$DtoListCategoriesResponse _$result;
    try {
      _$result = _$v ??
          _$DtoListCategoriesResponse._(
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
            r'DtoListCategoriesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
