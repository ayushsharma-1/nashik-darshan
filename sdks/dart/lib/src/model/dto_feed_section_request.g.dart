// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_feed_section_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DtoFeedSectionRequestOrderEnum _$dtoFeedSectionRequestOrderEnum_asc =
    const DtoFeedSectionRequestOrderEnum._('asc');
const DtoFeedSectionRequestOrderEnum _$dtoFeedSectionRequestOrderEnum_desc =
    const DtoFeedSectionRequestOrderEnum._('desc');

DtoFeedSectionRequestOrderEnum _$dtoFeedSectionRequestOrderEnumValueOf(
    String name) {
  switch (name) {
    case 'asc':
      return _$dtoFeedSectionRequestOrderEnum_asc;
    case 'desc':
      return _$dtoFeedSectionRequestOrderEnum_desc;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DtoFeedSectionRequestOrderEnum>
    _$dtoFeedSectionRequestOrderEnumValues = BuiltSet<
        DtoFeedSectionRequestOrderEnum>(const <DtoFeedSectionRequestOrderEnum>[
  _$dtoFeedSectionRequestOrderEnum_asc,
  _$dtoFeedSectionRequestOrderEnum_desc,
]);

Serializer<DtoFeedSectionRequestOrderEnum>
    _$dtoFeedSectionRequestOrderEnumSerializer =
    _$DtoFeedSectionRequestOrderEnumSerializer();

class _$DtoFeedSectionRequestOrderEnumSerializer
    implements PrimitiveSerializer<DtoFeedSectionRequestOrderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'asc': 'asc',
    'desc': 'desc',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'asc': 'asc',
    'desc': 'desc',
  };

  @override
  final Iterable<Type> types = const <Type>[DtoFeedSectionRequestOrderEnum];
  @override
  final String wireName = 'DtoFeedSectionRequestOrderEnum';

  @override
  Object serialize(
          Serializers serializers, DtoFeedSectionRequestOrderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DtoFeedSectionRequestOrderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DtoFeedSectionRequestOrderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DtoFeedSectionRequest extends DtoFeedSectionRequest {
  @override
  final String? endTime;
  @override
  final String? expand;
  @override
  final num? latitude;
  @override
  final int? limit;
  @override
  final num? longitude;
  @override
  final int? offset;
  @override
  final DtoFeedSectionRequestOrderEnum? order;
  @override
  final num? radiusKm;
  @override
  final String? sort;
  @override
  final String? startTime;
  @override
  final TypesStatus? status;
  @override
  final TypesFeedSectionType type;

  factory _$DtoFeedSectionRequest(
          [void Function(DtoFeedSectionRequestBuilder)? updates]) =>
      (DtoFeedSectionRequestBuilder()..update(updates))._build();

  _$DtoFeedSectionRequest._(
      {this.endTime,
      this.expand,
      this.latitude,
      this.limit,
      this.longitude,
      this.offset,
      this.order,
      this.radiusKm,
      this.sort,
      this.startTime,
      this.status,
      required this.type})
      : super._();
  @override
  DtoFeedSectionRequest rebuild(
          void Function(DtoFeedSectionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoFeedSectionRequestBuilder toBuilder() =>
      DtoFeedSectionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoFeedSectionRequest &&
        endTime == other.endTime &&
        expand == other.expand &&
        latitude == other.latitude &&
        limit == other.limit &&
        longitude == other.longitude &&
        offset == other.offset &&
        order == other.order &&
        radiusKm == other.radiusKm &&
        sort == other.sort &&
        startTime == other.startTime &&
        status == other.status &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, expand.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jc(_$hash, radiusKm.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoFeedSectionRequest')
          ..add('endTime', endTime)
          ..add('expand', expand)
          ..add('latitude', latitude)
          ..add('limit', limit)
          ..add('longitude', longitude)
          ..add('offset', offset)
          ..add('order', order)
          ..add('radiusKm', radiusKm)
          ..add('sort', sort)
          ..add('startTime', startTime)
          ..add('status', status)
          ..add('type', type))
        .toString();
  }
}

class DtoFeedSectionRequestBuilder
    implements Builder<DtoFeedSectionRequest, DtoFeedSectionRequestBuilder> {
  _$DtoFeedSectionRequest? _$v;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  String? _expand;
  String? get expand => _$this._expand;
  set expand(String? expand) => _$this._expand = expand;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  DtoFeedSectionRequestOrderEnum? _order;
  DtoFeedSectionRequestOrderEnum? get order => _$this._order;
  set order(DtoFeedSectionRequestOrderEnum? order) => _$this._order = order;

  num? _radiusKm;
  num? get radiusKm => _$this._radiusKm;
  set radiusKm(num? radiusKm) => _$this._radiusKm = radiusKm;

  String? _sort;
  String? get sort => _$this._sort;
  set sort(String? sort) => _$this._sort = sort;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  TypesFeedSectionType? _type;
  TypesFeedSectionType? get type => _$this._type;
  set type(TypesFeedSectionType? type) => _$this._type = type;

  DtoFeedSectionRequestBuilder() {
    DtoFeedSectionRequest._defaults(this);
  }

  DtoFeedSectionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _endTime = $v.endTime;
      _expand = $v.expand;
      _latitude = $v.latitude;
      _limit = $v.limit;
      _longitude = $v.longitude;
      _offset = $v.offset;
      _order = $v.order;
      _radiusKm = $v.radiusKm;
      _sort = $v.sort;
      _startTime = $v.startTime;
      _status = $v.status;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoFeedSectionRequest other) {
    _$v = other as _$DtoFeedSectionRequest;
  }

  @override
  void update(void Function(DtoFeedSectionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoFeedSectionRequest build() => _build();

  _$DtoFeedSectionRequest _build() {
    final _$result = _$v ??
        _$DtoFeedSectionRequest._(
          endTime: endTime,
          expand: expand,
          latitude: latitude,
          limit: limit,
          longitude: longitude,
          offset: offset,
          order: order,
          radiusKm: radiusKm,
          sort: sort,
          startTime: startTime,
          status: status,
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'DtoFeedSectionRequest', 'type'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
