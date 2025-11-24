// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_list_response_dto_review_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TypesListResponseDtoReviewResponse
    extends TypesListResponseDtoReviewResponse {
  @override
  final BuiltList<DtoReviewResponse>? items;
  @override
  final TypesPaginationResponse? pagination;

  factory _$TypesListResponseDtoReviewResponse(
          [void Function(TypesListResponseDtoReviewResponseBuilder)?
              updates]) =>
      (TypesListResponseDtoReviewResponseBuilder()..update(updates))._build();

  _$TypesListResponseDtoReviewResponse._({this.items, this.pagination})
      : super._();
  @override
  TypesListResponseDtoReviewResponse rebuild(
          void Function(TypesListResponseDtoReviewResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TypesListResponseDtoReviewResponseBuilder toBuilder() =>
      TypesListResponseDtoReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypesListResponseDtoReviewResponse &&
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
    return (newBuiltValueToStringHelper(r'TypesListResponseDtoReviewResponse')
          ..add('items', items)
          ..add('pagination', pagination))
        .toString();
  }
}

class TypesListResponseDtoReviewResponseBuilder
    implements
        Builder<TypesListResponseDtoReviewResponse,
            TypesListResponseDtoReviewResponseBuilder> {
  _$TypesListResponseDtoReviewResponse? _$v;

  ListBuilder<DtoReviewResponse>? _items;
  ListBuilder<DtoReviewResponse> get items =>
      _$this._items ??= ListBuilder<DtoReviewResponse>();
  set items(ListBuilder<DtoReviewResponse>? items) => _$this._items = items;

  TypesPaginationResponseBuilder? _pagination;
  TypesPaginationResponseBuilder get pagination =>
      _$this._pagination ??= TypesPaginationResponseBuilder();
  set pagination(TypesPaginationResponseBuilder? pagination) =>
      _$this._pagination = pagination;

  TypesListResponseDtoReviewResponseBuilder() {
    TypesListResponseDtoReviewResponse._defaults(this);
  }

  TypesListResponseDtoReviewResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypesListResponseDtoReviewResponse other) {
    _$v = other as _$TypesListResponseDtoReviewResponse;
  }

  @override
  void update(
      void Function(TypesListResponseDtoReviewResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypesListResponseDtoReviewResponse build() => _build();

  _$TypesListResponseDtoReviewResponse _build() {
    _$TypesListResponseDtoReviewResponse _$result;
    try {
      _$result = _$v ??
          _$TypesListResponseDtoReviewResponse._(
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
            r'TypesListResponseDtoReviewResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
