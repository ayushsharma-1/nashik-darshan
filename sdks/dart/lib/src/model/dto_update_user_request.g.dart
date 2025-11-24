// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdateUserRequest extends DtoUpdateUserRequest {
  @override
  final String? name;
  @override
  final String? phone;

  factory _$DtoUpdateUserRequest(
          [void Function(DtoUpdateUserRequestBuilder)? updates]) =>
      (DtoUpdateUserRequestBuilder()..update(updates))._build();

  _$DtoUpdateUserRequest._({this.name, this.phone}) : super._();
  @override
  DtoUpdateUserRequest rebuild(
          void Function(DtoUpdateUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdateUserRequestBuilder toBuilder() =>
      DtoUpdateUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdateUserRequest &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdateUserRequest')
          ..add('name', name)
          ..add('phone', phone))
        .toString();
  }
}

class DtoUpdateUserRequestBuilder
    implements Builder<DtoUpdateUserRequest, DtoUpdateUserRequestBuilder> {
  _$DtoUpdateUserRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  DtoUpdateUserRequestBuilder() {
    DtoUpdateUserRequest._defaults(this);
  }

  DtoUpdateUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdateUserRequest other) {
    _$v = other as _$DtoUpdateUserRequest;
  }

  @override
  void update(void Function(DtoUpdateUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdateUserRequest build() => _build();

  _$DtoUpdateUserRequest _build() {
    final _$result = _$v ??
        _$DtoUpdateUserRequest._(
          name: name,
          phone: phone,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
