// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_list_events_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoListEventsResponse extends DtoListEventsResponse {
  @override
  final BuiltList<DtoEventResponse>? items;
  @override
  final TypesPaginationResponse? pagination;

  factory _$DtoListEventsResponse(
          [void Function(DtoListEventsResponseBuilder)? updates]) =>
      (DtoListEventsResponseBuilder()..update(updates))._build();

  _$DtoListEventsResponse._({this.items, this.pagination}) : super._();
  @override
  DtoListEventsResponse rebuild(
          void Function(DtoListEventsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoListEventsResponseBuilder toBuilder() =>
      DtoListEventsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoListEventsResponse &&
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
    return (newBuiltValueToStringHelper(r'DtoListEventsResponse')
          ..add('items', items)
          ..add('pagination', pagination))
        .toString();
  }
}

class DtoListEventsResponseBuilder
    implements Builder<DtoListEventsResponse, DtoListEventsResponseBuilder> {
  _$DtoListEventsResponse? _$v;

  ListBuilder<DtoEventResponse>? _items;
  ListBuilder<DtoEventResponse> get items =>
      _$this._items ??= ListBuilder<DtoEventResponse>();
  set items(ListBuilder<DtoEventResponse>? items) => _$this._items = items;

  TypesPaginationResponseBuilder? _pagination;
  TypesPaginationResponseBuilder get pagination =>
      _$this._pagination ??= TypesPaginationResponseBuilder();
  set pagination(TypesPaginationResponseBuilder? pagination) =>
      _$this._pagination = pagination;

  DtoListEventsResponseBuilder() {
    DtoListEventsResponse._defaults(this);
  }

  DtoListEventsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoListEventsResponse other) {
    _$v = other as _$DtoListEventsResponse;
  }

  @override
  void update(void Function(DtoListEventsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoListEventsResponse build() => _build();

  _$DtoListEventsResponse _build() {
    _$DtoListEventsResponse _$result;
    try {
      _$result = _$v ??
          _$DtoListEventsResponse._(
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
            r'DtoListEventsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
