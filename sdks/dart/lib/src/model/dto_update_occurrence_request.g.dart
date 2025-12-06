// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_occurrence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdateOccurrenceRequest extends DtoUpdateOccurrenceRequest {
  @override
  final int? dayOfMonth;
  @override
  final int? dayOfWeek;
  @override
  final String? endTime;
  @override
  final BuiltList<String>? exceptionDates;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final int? monthOfYear;
  @override
  final TypesRecurrenceType? recurrenceType;
  @override
  final String? startTime;

  factory _$DtoUpdateOccurrenceRequest(
          [void Function(DtoUpdateOccurrenceRequestBuilder)? updates]) =>
      (DtoUpdateOccurrenceRequestBuilder()..update(updates))._build();

  _$DtoUpdateOccurrenceRequest._(
      {this.dayOfMonth,
      this.dayOfWeek,
      this.endTime,
      this.exceptionDates,
      this.metadata,
      this.monthOfYear,
      this.recurrenceType,
      this.startTime})
      : super._();
  @override
  DtoUpdateOccurrenceRequest rebuild(
          void Function(DtoUpdateOccurrenceRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdateOccurrenceRequestBuilder toBuilder() =>
      DtoUpdateOccurrenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdateOccurrenceRequest &&
        dayOfMonth == other.dayOfMonth &&
        dayOfWeek == other.dayOfWeek &&
        endTime == other.endTime &&
        exceptionDates == other.exceptionDates &&
        metadata == other.metadata &&
        monthOfYear == other.monthOfYear &&
        recurrenceType == other.recurrenceType &&
        startTime == other.startTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dayOfMonth.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, exceptionDates.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, monthOfYear.hashCode);
    _$hash = $jc(_$hash, recurrenceType.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdateOccurrenceRequest')
          ..add('dayOfMonth', dayOfMonth)
          ..add('dayOfWeek', dayOfWeek)
          ..add('endTime', endTime)
          ..add('exceptionDates', exceptionDates)
          ..add('metadata', metadata)
          ..add('monthOfYear', monthOfYear)
          ..add('recurrenceType', recurrenceType)
          ..add('startTime', startTime))
        .toString();
  }
}

class DtoUpdateOccurrenceRequestBuilder
    implements
        Builder<DtoUpdateOccurrenceRequest, DtoUpdateOccurrenceRequestBuilder> {
  _$DtoUpdateOccurrenceRequest? _$v;

  int? _dayOfMonth;
  int? get dayOfMonth => _$this._dayOfMonth;
  set dayOfMonth(int? dayOfMonth) => _$this._dayOfMonth = dayOfMonth;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  ListBuilder<String>? _exceptionDates;
  ListBuilder<String> get exceptionDates =>
      _$this._exceptionDates ??= ListBuilder<String>();
  set exceptionDates(ListBuilder<String>? exceptionDates) =>
      _$this._exceptionDates = exceptionDates;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  int? _monthOfYear;
  int? get monthOfYear => _$this._monthOfYear;
  set monthOfYear(int? monthOfYear) => _$this._monthOfYear = monthOfYear;

  TypesRecurrenceType? _recurrenceType;
  TypesRecurrenceType? get recurrenceType => _$this._recurrenceType;
  set recurrenceType(TypesRecurrenceType? recurrenceType) =>
      _$this._recurrenceType = recurrenceType;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  DtoUpdateOccurrenceRequestBuilder() {
    DtoUpdateOccurrenceRequest._defaults(this);
  }

  DtoUpdateOccurrenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dayOfMonth = $v.dayOfMonth;
      _dayOfWeek = $v.dayOfWeek;
      _endTime = $v.endTime;
      _exceptionDates = $v.exceptionDates?.toBuilder();
      _metadata = $v.metadata?.toBuilder();
      _monthOfYear = $v.monthOfYear;
      _recurrenceType = $v.recurrenceType;
      _startTime = $v.startTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdateOccurrenceRequest other) {
    _$v = other as _$DtoUpdateOccurrenceRequest;
  }

  @override
  void update(void Function(DtoUpdateOccurrenceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdateOccurrenceRequest build() => _build();

  _$DtoUpdateOccurrenceRequest _build() {
    _$DtoUpdateOccurrenceRequest _$result;
    try {
      _$result = _$v ??
          _$DtoUpdateOccurrenceRequest._(
            dayOfMonth: dayOfMonth,
            dayOfWeek: dayOfWeek,
            endTime: endTime,
            exceptionDates: _exceptionDates?.build(),
            metadata: _metadata?.build(),
            monthOfYear: monthOfYear,
            recurrenceType: recurrenceType,
            startTime: startTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'exceptionDates';
        _exceptionDates?.build();
        _$failedField = 'metadata';
        _metadata?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoUpdateOccurrenceRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
