// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ierr_error_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IerrErrorResponse extends IerrErrorResponse {
  @override
  final IerrErrorDetail? error;
  @override
  final bool? success;

  factory _$IerrErrorResponse(
          [void Function(IerrErrorResponseBuilder)? updates]) =>
      (IerrErrorResponseBuilder()..update(updates))._build();

  _$IerrErrorResponse._({this.error, this.success}) : super._();
  @override
  IerrErrorResponse rebuild(void Function(IerrErrorResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IerrErrorResponseBuilder toBuilder() =>
      IerrErrorResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IerrErrorResponse &&
        error == other.error &&
        success == other.success;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IerrErrorResponse')
          ..add('error', error)
          ..add('success', success))
        .toString();
  }
}

class IerrErrorResponseBuilder
    implements Builder<IerrErrorResponse, IerrErrorResponseBuilder> {
  _$IerrErrorResponse? _$v;

  IerrErrorDetailBuilder? _error;
  IerrErrorDetailBuilder get error =>
      _$this._error ??= IerrErrorDetailBuilder();
  set error(IerrErrorDetailBuilder? error) => _$this._error = error;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  IerrErrorResponseBuilder() {
    IerrErrorResponse._defaults(this);
  }

  IerrErrorResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error?.toBuilder();
      _success = $v.success;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IerrErrorResponse other) {
    _$v = other as _$IerrErrorResponse;
  }

  @override
  void update(void Function(IerrErrorResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IerrErrorResponse build() => _build();

  _$IerrErrorResponse _build() {
    _$IerrErrorResponse _$result;
    try {
      _$result = _$v ??
          _$IerrErrorResponse._(
            error: _error?.build(),
            success: success,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IerrErrorResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
