// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_feed_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DtoFeedRequestOrderEnum _$dtoFeedRequestOrderEnum_asc =
    const DtoFeedRequestOrderEnum._('asc');
const DtoFeedRequestOrderEnum _$dtoFeedRequestOrderEnum_desc =
    const DtoFeedRequestOrderEnum._('desc');

DtoFeedRequestOrderEnum _$dtoFeedRequestOrderEnumValueOf(String name) {
  switch (name) {
    case 'asc':
      return _$dtoFeedRequestOrderEnum_asc;
    case 'desc':
      return _$dtoFeedRequestOrderEnum_desc;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DtoFeedRequestOrderEnum> _$dtoFeedRequestOrderEnumValues =
    BuiltSet<DtoFeedRequestOrderEnum>(const <DtoFeedRequestOrderEnum>[
  _$dtoFeedRequestOrderEnum_asc,
  _$dtoFeedRequestOrderEnum_desc,
]);

Serializer<DtoFeedRequestOrderEnum> _$dtoFeedRequestOrderEnumSerializer =
    _$DtoFeedRequestOrderEnumSerializer();

class _$DtoFeedRequestOrderEnumSerializer
    implements PrimitiveSerializer<DtoFeedRequestOrderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'asc': 'asc',
    'desc': 'desc',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'asc': 'asc',
    'desc': 'desc',
  };

  @override
  final Iterable<Type> types = const <Type>[DtoFeedRequestOrderEnum];
  @override
  final String wireName = 'DtoFeedRequestOrderEnum';

  @override
  Object serialize(Serializers serializers, DtoFeedRequestOrderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DtoFeedRequestOrderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DtoFeedRequestOrderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DtoFeedRequest extends DtoFeedRequest {
  @override
  final String? endTime;
  @override
  final String? expand;
  @override
  final int? limit;
  @override
  final int? offset;
  @override
  final DtoFeedRequestOrderEnum? order;
  @override
  final BuiltList<DtoFeedSectionRequest> sections;
  @override
  final String? sort;
  @override
  final String? startTime;
  @override
  final TypesStatus? status;

  factory _$DtoFeedRequest([void Function(DtoFeedRequestBuilder)? updates]) =>
      (DtoFeedRequestBuilder()..update(updates))._build();

  _$DtoFeedRequest._(
      {this.endTime,
      this.expand,
      this.limit,
      this.offset,
      this.order,
      required this.sections,
      this.sort,
      this.startTime,
      this.status})
      : super._();
  @override
  DtoFeedRequest rebuild(void Function(DtoFeedRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoFeedRequestBuilder toBuilder() => DtoFeedRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoFeedRequest &&
        endTime == other.endTime &&
        expand == other.expand &&
        limit == other.limit &&
        offset == other.offset &&
        order == other.order &&
        sections == other.sections &&
        sort == other.sort &&
        startTime == other.startTime &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, expand.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jc(_$hash, sections.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoFeedRequest')
          ..add('endTime', endTime)
          ..add('expand', expand)
          ..add('limit', limit)
          ..add('offset', offset)
          ..add('order', order)
          ..add('sections', sections)
          ..add('sort', sort)
          ..add('startTime', startTime)
          ..add('status', status))
        .toString();
  }
}

class DtoFeedRequestBuilder
    implements Builder<DtoFeedRequest, DtoFeedRequestBuilder> {
  _$DtoFeedRequest? _$v;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  String? _expand;
  String? get expand => _$this._expand;
  set expand(String? expand) => _$this._expand = expand;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  DtoFeedRequestOrderEnum? _order;
  DtoFeedRequestOrderEnum? get order => _$this._order;
  set order(DtoFeedRequestOrderEnum? order) => _$this._order = order;

  ListBuilder<DtoFeedSectionRequest>? _sections;
  ListBuilder<DtoFeedSectionRequest> get sections =>
      _$this._sections ??= ListBuilder<DtoFeedSectionRequest>();
  set sections(ListBuilder<DtoFeedSectionRequest>? sections) =>
      _$this._sections = sections;

  String? _sort;
  String? get sort => _$this._sort;
  set sort(String? sort) => _$this._sort = sort;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  DtoFeedRequestBuilder() {
    DtoFeedRequest._defaults(this);
  }

  DtoFeedRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _endTime = $v.endTime;
      _expand = $v.expand;
      _limit = $v.limit;
      _offset = $v.offset;
      _order = $v.order;
      _sections = $v.sections.toBuilder();
      _sort = $v.sort;
      _startTime = $v.startTime;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoFeedRequest other) {
    _$v = other as _$DtoFeedRequest;
  }

  @override
  void update(void Function(DtoFeedRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoFeedRequest build() => _build();

  _$DtoFeedRequest _build() {
    _$DtoFeedRequest _$result;
    try {
      _$result = _$v ??
          _$DtoFeedRequest._(
            endTime: endTime,
            expand: expand,
            limit: limit,
            offset: offset,
            order: order,
            sections: sections.build(),
            sort: sort,
            startTime: startTime,
            status: status,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sections';
        sections.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoFeedRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
