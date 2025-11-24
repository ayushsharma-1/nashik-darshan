// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_pagination_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TypesPaginationResponse extends TypesPaginationResponse {
  @override
  final int? limit;
  @override
  final int? offset;
  @override
  final int? total;

  factory _$TypesPaginationResponse(
          [void Function(TypesPaginationResponseBuilder)? updates]) =>
      (TypesPaginationResponseBuilder()..update(updates))._build();

  _$TypesPaginationResponse._({this.limit, this.offset, this.total})
      : super._();
  @override
  TypesPaginationResponse rebuild(
          void Function(TypesPaginationResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TypesPaginationResponseBuilder toBuilder() =>
      TypesPaginationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypesPaginationResponse &&
        limit == other.limit &&
        offset == other.offset &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypesPaginationResponse')
          ..add('limit', limit)
          ..add('offset', offset)
          ..add('total', total))
        .toString();
  }
}

class TypesPaginationResponseBuilder
    implements
        Builder<TypesPaginationResponse, TypesPaginationResponseBuilder> {
  _$TypesPaginationResponse? _$v;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  TypesPaginationResponseBuilder() {
    TypesPaginationResponse._defaults(this);
  }

  TypesPaginationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _limit = $v.limit;
      _offset = $v.offset;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypesPaginationResponse other) {
    _$v = other as _$TypesPaginationResponse;
  }

  @override
  void update(void Function(TypesPaginationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypesPaginationResponse build() => _build();

  _$TypesPaginationResponse _build() {
    final _$result = _$v ??
        _$TypesPaginationResponse._(
          limit: limit,
          offset: offset,
          total: total,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
