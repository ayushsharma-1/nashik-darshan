// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_create_event_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoCreateEventRequest extends DtoCreateEventRequest {
  @override
  final String? coverImageUrl;
  @override
  final String? description;
  @override
  final String? endDate;
  @override
  final BuiltList<String>? images;
  @override
  final num? latitude;
  @override
  final String? locationName;
  @override
  final num? longitude;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final String? placeId;
  @override
  final String slug;
  @override
  final String? startDate;
  @override
  final String? subtitle;
  @override
  final BuiltList<String>? tags;
  @override
  final String title;
  @override
  final TypesEventType type;

  factory _$DtoCreateEventRequest(
          [void Function(DtoCreateEventRequestBuilder)? updates]) =>
      (DtoCreateEventRequestBuilder()..update(updates))._build();

  _$DtoCreateEventRequest._(
      {this.coverImageUrl,
      this.description,
      this.endDate,
      this.images,
      this.latitude,
      this.locationName,
      this.longitude,
      this.metadata,
      this.placeId,
      required this.slug,
      this.startDate,
      this.subtitle,
      this.tags,
      required this.title,
      required this.type})
      : super._();
  @override
  DtoCreateEventRequest rebuild(
          void Function(DtoCreateEventRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoCreateEventRequestBuilder toBuilder() =>
      DtoCreateEventRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoCreateEventRequest &&
        coverImageUrl == other.coverImageUrl &&
        description == other.description &&
        endDate == other.endDate &&
        images == other.images &&
        latitude == other.latitude &&
        locationName == other.locationName &&
        longitude == other.longitude &&
        metadata == other.metadata &&
        placeId == other.placeId &&
        slug == other.slug &&
        startDate == other.startDate &&
        subtitle == other.subtitle &&
        tags == other.tags &&
        title == other.title &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, locationName.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, placeId.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoCreateEventRequest')
          ..add('coverImageUrl', coverImageUrl)
          ..add('description', description)
          ..add('endDate', endDate)
          ..add('images', images)
          ..add('latitude', latitude)
          ..add('locationName', locationName)
          ..add('longitude', longitude)
          ..add('metadata', metadata)
          ..add('placeId', placeId)
          ..add('slug', slug)
          ..add('startDate', startDate)
          ..add('subtitle', subtitle)
          ..add('tags', tags)
          ..add('title', title)
          ..add('type', type))
        .toString();
  }
}

class DtoCreateEventRequestBuilder
    implements Builder<DtoCreateEventRequest, DtoCreateEventRequestBuilder> {
  _$DtoCreateEventRequest? _$v;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _endDate;
  String? get endDate => _$this._endDate;
  set endDate(String? endDate) => _$this._endDate = endDate;

  ListBuilder<String>? _images;
  ListBuilder<String> get images => _$this._images ??= ListBuilder<String>();
  set images(ListBuilder<String>? images) => _$this._images = images;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  String? _locationName;
  String? get locationName => _$this._locationName;
  set locationName(String? locationName) => _$this._locationName = locationName;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  MapBuilder<String, String>? _metadata;
  MapBuilder<String, String> get metadata =>
      _$this._metadata ??= MapBuilder<String, String>();
  set metadata(MapBuilder<String, String>? metadata) =>
      _$this._metadata = metadata;

  String? _placeId;
  String? get placeId => _$this._placeId;
  set placeId(String? placeId) => _$this._placeId = placeId;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _startDate;
  String? get startDate => _$this._startDate;
  set startDate(String? startDate) => _$this._startDate = startDate;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  TypesEventType? _type;
  TypesEventType? get type => _$this._type;
  set type(TypesEventType? type) => _$this._type = type;

  DtoCreateEventRequestBuilder() {
    DtoCreateEventRequest._defaults(this);
  }

  DtoCreateEventRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coverImageUrl = $v.coverImageUrl;
      _description = $v.description;
      _endDate = $v.endDate;
      _images = $v.images?.toBuilder();
      _latitude = $v.latitude;
      _locationName = $v.locationName;
      _longitude = $v.longitude;
      _metadata = $v.metadata?.toBuilder();
      _placeId = $v.placeId;
      _slug = $v.slug;
      _startDate = $v.startDate;
      _subtitle = $v.subtitle;
      _tags = $v.tags?.toBuilder();
      _title = $v.title;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoCreateEventRequest other) {
    _$v = other as _$DtoCreateEventRequest;
  }

  @override
  void update(void Function(DtoCreateEventRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoCreateEventRequest build() => _build();

  _$DtoCreateEventRequest _build() {
    _$DtoCreateEventRequest _$result;
    try {
      _$result = _$v ??
          _$DtoCreateEventRequest._(
            coverImageUrl: coverImageUrl,
            description: description,
            endDate: endDate,
            images: _images?.build(),
            latitude: latitude,
            locationName: locationName,
            longitude: longitude,
            metadata: _metadata?.build(),
            placeId: placeId,
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'DtoCreateEventRequest', 'slug'),
            startDate: startDate,
            subtitle: subtitle,
            tags: _tags?.build(),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'DtoCreateEventRequest', 'title'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'DtoCreateEventRequest', 'type'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();

        _$failedField = 'metadata';
        _metadata?.build();

        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoCreateEventRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
