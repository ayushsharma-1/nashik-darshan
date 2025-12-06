// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_signup_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoSignupRequest extends DtoSignupRequest {
  @override
  final String accessToken;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? phone;

  factory _$DtoSignupRequest(
          [void Function(DtoSignupRequestBuilder)? updates]) =>
      (DtoSignupRequestBuilder()..update(updates))._build();

  _$DtoSignupRequest._(
      {required this.accessToken,
      required this.email,
      required this.name,
      this.phone})
      : super._();
  @override
  DtoSignupRequest rebuild(void Function(DtoSignupRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoSignupRequestBuilder toBuilder() =>
      DtoSignupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoSignupRequest &&
        accessToken == other.accessToken &&
        email == other.email &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoSignupRequest')
          ..add('accessToken', accessToken)
          ..add('email', email)
          ..add('name', name)
          ..add('phone', phone))
        .toString();
  }
}

class DtoSignupRequestBuilder
    implements Builder<DtoSignupRequest, DtoSignupRequestBuilder> {
  _$DtoSignupRequest? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  DtoSignupRequestBuilder() {
    DtoSignupRequest._defaults(this);
  }

  DtoSignupRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _email = $v.email;
      _name = $v.name;
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoSignupRequest other) {
    _$v = other as _$DtoSignupRequest;
  }

  @override
  void update(void Function(DtoSignupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoSignupRequest build() => _build();

  _$DtoSignupRequest _build() {
    final _$result = _$v ??
        _$DtoSignupRequest._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
              accessToken, r'DtoSignupRequest', 'accessToken'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'DtoSignupRequest', 'email'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'DtoSignupRequest', 'name'),
          phone: phone,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
