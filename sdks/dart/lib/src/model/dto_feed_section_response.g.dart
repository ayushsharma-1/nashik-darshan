// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_feed_section_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoFeedSectionResponse extends DtoFeedSectionResponse {
  @override
  final BuiltList<DtoPlaceResponse>? items;
  @override
  final TypesPaginationResponse? pagination;
  @override
  final TypesFeedSectionType? type;

  factory _$DtoFeedSectionResponse(
          [void Function(DtoFeedSectionResponseBuilder)? updates]) =>
      (DtoFeedSectionResponseBuilder()..update(updates))._build();

  _$DtoFeedSectionResponse._({this.items, this.pagination, this.type})
      : super._();
  @override
  DtoFeedSectionResponse rebuild(
          void Function(DtoFeedSectionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoFeedSectionResponseBuilder toBuilder() =>
      DtoFeedSectionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoFeedSectionResponse &&
        items == other.items &&
        pagination == other.pagination &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoFeedSectionResponse')
          ..add('items', items)
          ..add('pagination', pagination)
          ..add('type', type))
        .toString();
  }
}

class DtoFeedSectionResponseBuilder
    implements Builder<DtoFeedSectionResponse, DtoFeedSectionResponseBuilder> {
  _$DtoFeedSectionResponse? _$v;

  ListBuilder<DtoPlaceResponse>? _items;
  ListBuilder<DtoPlaceResponse> get items =>
      _$this._items ??= ListBuilder<DtoPlaceResponse>();
  set items(ListBuilder<DtoPlaceResponse>? items) => _$this._items = items;

  TypesPaginationResponseBuilder? _pagination;
  TypesPaginationResponseBuilder get pagination =>
      _$this._pagination ??= TypesPaginationResponseBuilder();
  set pagination(TypesPaginationResponseBuilder? pagination) =>
      _$this._pagination = pagination;

  TypesFeedSectionType? _type;
  TypesFeedSectionType? get type => _$this._type;
  set type(TypesFeedSectionType? type) => _$this._type = type;

  DtoFeedSectionResponseBuilder() {
    DtoFeedSectionResponse._defaults(this);
  }

  DtoFeedSectionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoFeedSectionResponse other) {
    _$v = other as _$DtoFeedSectionResponse;
  }

  @override
  void update(void Function(DtoFeedSectionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoFeedSectionResponse build() => _build();

  _$DtoFeedSectionResponse _build() {
    _$DtoFeedSectionResponse _$result;
    try {
      _$result = _$v ??
          _$DtoFeedSectionResponse._(
            items: _items?.build(),
            pagination: _pagination?.build(),
            type: type,
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
            r'DtoFeedSectionResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
