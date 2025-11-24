// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_signup_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoSignupResponse extends DtoSignupResponse {
  @override
  final String? accessToken;
  @override
  final String? id;

  factory _$DtoSignupResponse(
          [void Function(DtoSignupResponseBuilder)? updates]) =>
      (DtoSignupResponseBuilder()..update(updates))._build();

  _$DtoSignupResponse._({this.accessToken, this.id}) : super._();
  @override
  DtoSignupResponse rebuild(void Function(DtoSignupResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoSignupResponseBuilder toBuilder() =>
      DtoSignupResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoSignupResponse &&
        accessToken == other.accessToken &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoSignupResponse')
          ..add('accessToken', accessToken)
          ..add('id', id))
        .toString();
  }
}

class DtoSignupResponseBuilder
    implements Builder<DtoSignupResponse, DtoSignupResponseBuilder> {
  _$DtoSignupResponse? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DtoSignupResponseBuilder() {
    DtoSignupResponse._defaults(this);
  }

  DtoSignupResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoSignupResponse other) {
    _$v = other as _$DtoSignupResponse;
  }

  @override
  void update(void Function(DtoSignupResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoSignupResponse build() => _build();

  _$DtoSignupResponse _build() {
    final _$result = _$v ??
        _$DtoSignupResponse._(
          accessToken: accessToken,
          id: id,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
