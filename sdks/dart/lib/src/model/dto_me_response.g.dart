// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_me_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoMeResponse extends DtoMeResponse {
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? email;
  @override
  final String? id;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final TypesUserRole? role;
  @override
  final TypesStatus? status;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;

  factory _$DtoMeResponse([void Function(DtoMeResponseBuilder)? updates]) =>
      (DtoMeResponseBuilder()..update(updates))._build();

  _$DtoMeResponse._(
      {this.createdAt,
      this.createdBy,
      this.email,
      this.id,
      this.metadata,
      this.name,
      this.phone,
      this.role,
      this.status,
      this.updatedAt,
      this.updatedBy})
      : super._();
  @override
  DtoMeResponse rebuild(void Function(DtoMeResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoMeResponseBuilder toBuilder() => DtoMeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoMeResponse &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        email == other.email &&
        id == other.id &&
        metadata == other.metadata &&
        name == other.name &&
        phone == other.phone &&
        role == other.role &&
        status == other.status &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoMeResponse')
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('email', email)
          ..add('id', id)
          ..add('metadata', metadata)
          ..add('name', name)
          ..add('phone', phone)
          ..add('role', role)
          ..add('status', status)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy))
        .toString();
  }
}

class DtoMeResponseBuilder
    implements Builder<DtoMeResponse, DtoMeResponseBuilder> {
  _$DtoMeResponse? _$v;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  TypesUserRole? _role;
  TypesUserRole? get role => _$this._role;
  set role(TypesUserRole? role) => _$this._role = role;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  DtoMeResponseBuilder() {
    DtoMeResponse._defaults(this);
  }

  DtoMeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _email = $v.email;
      _id = $v.id;
      _metadata = $v.metadata?.toBuilder();
      _name = $v.name;
      _phone = $v.phone;
      _role = $v.role;
      _status = $v.status;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoMeResponse other) {
    _$v = other as _$DtoMeResponse;
  }

  @override
  void update(void Function(DtoMeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoMeResponse build() => _build();

  _$DtoMeResponse _build() {
    _$DtoMeResponse _$result;
    try {
      _$result = _$v ??
          _$DtoMeResponse._(
            createdAt: createdAt,
            createdBy: createdBy,
            email: email,
            id: id,
            metadata: _metadata?.build(),
            name: name,
            phone: phone,
            role: role,
            status: status,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoMeResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
