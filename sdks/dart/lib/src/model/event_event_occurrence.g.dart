// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_event_occurrence.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EventEventOccurrence extends EventEventOccurrence {
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final int? dayOfMonth;
  @override
  final int? dayOfWeek;
  @override
  final int? durationMinutes;
  @override
  final String? endTime;
  @override
  final String? eventId;
  @override
  final BuiltList<String>? exceptionDates;
  @override
  final String? id;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final int? monthOfYear;
  @override
  final TypesRecurrenceType? recurrenceType;
  @override
  final String? startTime;
  @override
  final TypesStatus? status;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;

  factory _$EventEventOccurrence(
          [void Function(EventEventOccurrenceBuilder)? updates]) =>
      (EventEventOccurrenceBuilder()..update(updates))._build();

  _$EventEventOccurrence._(
      {this.createdAt,
      this.createdBy,
      this.dayOfMonth,
      this.dayOfWeek,
      this.durationMinutes,
      this.endTime,
      this.eventId,
      this.exceptionDates,
      this.id,
      this.metadata,
      this.monthOfYear,
      this.recurrenceType,
      this.startTime,
      this.status,
      this.updatedAt,
      this.updatedBy})
      : super._();
  @override
  EventEventOccurrence rebuild(
          void Function(EventEventOccurrenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventEventOccurrenceBuilder toBuilder() =>
      EventEventOccurrenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EventEventOccurrence &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        dayOfMonth == other.dayOfMonth &&
        dayOfWeek == other.dayOfWeek &&
        durationMinutes == other.durationMinutes &&
        endTime == other.endTime &&
        eventId == other.eventId &&
        exceptionDates == other.exceptionDates &&
        id == other.id &&
        metadata == other.metadata &&
        monthOfYear == other.monthOfYear &&
        recurrenceType == other.recurrenceType &&
        startTime == other.startTime &&
        status == other.status &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, dayOfMonth.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, durationMinutes.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, exceptionDates.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, monthOfYear.hashCode);
    _$hash = $jc(_$hash, recurrenceType.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EventEventOccurrence')
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('dayOfMonth', dayOfMonth)
          ..add('dayOfWeek', dayOfWeek)
          ..add('durationMinutes', durationMinutes)
          ..add('endTime', endTime)
          ..add('eventId', eventId)
          ..add('exceptionDates', exceptionDates)
          ..add('id', id)
          ..add('metadata', metadata)
          ..add('monthOfYear', monthOfYear)
          ..add('recurrenceType', recurrenceType)
          ..add('startTime', startTime)
          ..add('status', status)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy))
        .toString();
  }
}

class EventEventOccurrenceBuilder
    implements Builder<EventEventOccurrence, EventEventOccurrenceBuilder> {
  _$EventEventOccurrence? _$v;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  int? _dayOfMonth;
  int? get dayOfMonth => _$this._dayOfMonth;
  set dayOfMonth(int? dayOfMonth) => _$this._dayOfMonth = dayOfMonth;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

  int? _durationMinutes;
  int? get durationMinutes => _$this._durationMinutes;
  set durationMinutes(int? durationMinutes) =>
      _$this._durationMinutes = durationMinutes;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(String? eventId) => _$this._eventId = eventId;

  ListBuilder<String>? _exceptionDates;
  ListBuilder<String> get exceptionDates =>
      _$this._exceptionDates ??= ListBuilder<String>();
  set exceptionDates(ListBuilder<String>? exceptionDates) =>
      _$this._exceptionDates = exceptionDates;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  EventEventOccurrenceBuilder() {
    EventEventOccurrence._defaults(this);
  }

  EventEventOccurrenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _dayOfMonth = $v.dayOfMonth;
      _dayOfWeek = $v.dayOfWeek;
      _durationMinutes = $v.durationMinutes;
      _endTime = $v.endTime;
      _eventId = $v.eventId;
      _exceptionDates = $v.exceptionDates?.toBuilder();
      _id = $v.id;
      _metadata = $v.metadata?.toBuilder();
      _monthOfYear = $v.monthOfYear;
      _recurrenceType = $v.recurrenceType;
      _startTime = $v.startTime;
      _status = $v.status;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EventEventOccurrence other) {
    _$v = other as _$EventEventOccurrence;
  }

  @override
  void update(void Function(EventEventOccurrenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EventEventOccurrence build() => _build();

  _$EventEventOccurrence _build() {
    _$EventEventOccurrence _$result;
    try {
      _$result = _$v ??
          _$EventEventOccurrence._(
            createdAt: createdAt,
            createdBy: createdBy,
            dayOfMonth: dayOfMonth,
            dayOfWeek: dayOfWeek,
            durationMinutes: durationMinutes,
            endTime: endTime,
            eventId: eventId,
            exceptionDates: _exceptionDates?.build(),
            id: id,
            metadata: _metadata?.build(),
            monthOfYear: monthOfYear,
            recurrenceType: recurrenceType,
            startTime: startTime,
            status: status,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
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
            r'EventEventOccurrence', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
