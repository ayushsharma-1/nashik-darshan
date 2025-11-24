// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ierr_error_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IerrErrorDetail extends IerrErrorDetail {
  @override
  final BuiltMap<String, JsonObject>? details;
  @override
  final String? internalError;
  @override
  final String? message;

  factory _$IerrErrorDetail([void Function(IerrErrorDetailBuilder)? updates]) =>
      (IerrErrorDetailBuilder()..update(updates))._build();

  _$IerrErrorDetail._({this.details, this.internalError, this.message})
      : super._();
  @override
  IerrErrorDetail rebuild(void Function(IerrErrorDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IerrErrorDetailBuilder toBuilder() => IerrErrorDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IerrErrorDetail &&
        details == other.details &&
        internalError == other.internalError &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jc(_$hash, internalError.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IerrErrorDetail')
          ..add('details', details)
          ..add('internalError', internalError)
          ..add('message', message))
        .toString();
  }
}

class IerrErrorDetailBuilder
    implements Builder<IerrErrorDetail, IerrErrorDetailBuilder> {
  _$IerrErrorDetail? _$v;

  MapBuilder<String, JsonObject>? _details;
  MapBuilder<String, JsonObject> get details =>
      _$this._details ??= MapBuilder<String, JsonObject>();
  set details(MapBuilder<String, JsonObject>? details) =>
      _$this._details = details;

  String? _internalError;
  String? get internalError => _$this._internalError;
  set internalError(String? internalError) =>
      _$this._internalError = internalError;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  IerrErrorDetailBuilder() {
    IerrErrorDetail._defaults(this);
  }

  IerrErrorDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _details = $v.details?.toBuilder();
      _internalError = $v.internalError;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IerrErrorDetail other) {
    _$v = other as _$IerrErrorDetail;
  }

  @override
  void update(void Function(IerrErrorDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IerrErrorDetail build() => _build();

  _$IerrErrorDetail _build() {
    _$IerrErrorDetail _$result;
    try {
      _$result = _$v ??
          _$IerrErrorDetail._(
            details: _details?.build(),
            internalError: internalError,
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IerrErrorDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
