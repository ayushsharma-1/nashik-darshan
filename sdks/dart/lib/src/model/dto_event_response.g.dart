// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_event_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoEventResponse extends DtoEventResponse {
  @override
  final String? coverImageUrl;
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? description;
  @override
  final String? endDate;
  @override
  final String? id;
  @override
  final BuiltList<String>? images;
  @override
  final int? interestedCount;
  @override
  final num? latitude;
  @override
  final String? locationName;
  @override
  final num? longitude;
  @override
  final BuiltMap<String, String>? metadata;
  @override
  final BuiltList<EventEventOccurrence>? occurrences;
  @override
  final String? placeId;
  @override
  final String? slug;
  @override
  final String? startDate;
  @override
  final TypesStatus? status;
  @override
  final String? subtitle;
  @override
  final BuiltList<String>? tags;
  @override
  final String? title;
  @override
  final TypesEventType? type;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;
  @override
  final int? viewCount;

  factory _$DtoEventResponse(
          [void Function(DtoEventResponseBuilder)? updates]) =>
      (DtoEventResponseBuilder()..update(updates))._build();

  _$DtoEventResponse._(
      {this.coverImageUrl,
      this.createdAt,
      this.createdBy,
      this.description,
      this.endDate,
      this.id,
      this.images,
      this.interestedCount,
      this.latitude,
      this.locationName,
      this.longitude,
      this.metadata,
      this.occurrences,
      this.placeId,
      this.slug,
      this.startDate,
      this.status,
      this.subtitle,
      this.tags,
      this.title,
      this.type,
      this.updatedAt,
      this.updatedBy,
      this.viewCount})
      : super._();
  @override
  DtoEventResponse rebuild(void Function(DtoEventResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoEventResponseBuilder toBuilder() =>
      DtoEventResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoEventResponse &&
        coverImageUrl == other.coverImageUrl &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        description == other.description &&
        endDate == other.endDate &&
        id == other.id &&
        images == other.images &&
        interestedCount == other.interestedCount &&
        latitude == other.latitude &&
        locationName == other.locationName &&
        longitude == other.longitude &&
        metadata == other.metadata &&
        occurrences == other.occurrences &&
        placeId == other.placeId &&
        slug == other.slug &&
        startDate == other.startDate &&
        status == other.status &&
        subtitle == other.subtitle &&
        tags == other.tags &&
        title == other.title &&
        type == other.type &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        viewCount == other.viewCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, interestedCount.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, locationName.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jc(_$hash, occurrences.hashCode);
    _$hash = $jc(_$hash, placeId.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jc(_$hash, viewCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoEventResponse')
          ..add('coverImageUrl', coverImageUrl)
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('description', description)
          ..add('endDate', endDate)
          ..add('id', id)
          ..add('images', images)
          ..add('interestedCount', interestedCount)
          ..add('latitude', latitude)
          ..add('locationName', locationName)
          ..add('longitude', longitude)
          ..add('metadata', metadata)
          ..add('occurrences', occurrences)
          ..add('placeId', placeId)
          ..add('slug', slug)
          ..add('startDate', startDate)
          ..add('status', status)
          ..add('subtitle', subtitle)
          ..add('tags', tags)
          ..add('title', title)
          ..add('type', type)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy)
          ..add('viewCount', viewCount))
        .toString();
  }
}

class DtoEventResponseBuilder
    implements Builder<DtoEventResponse, DtoEventResponseBuilder> {
  _$DtoEventResponse? _$v;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _endDate;
  String? get endDate => _$this._endDate;
  set endDate(String? endDate) => _$this._endDate = endDate;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<String>? _images;
  ListBuilder<String> get images => _$this._images ??= ListBuilder<String>();
  set images(ListBuilder<String>? images) => _$this._images = images;

  int? _interestedCount;
  int? get interestedCount => _$this._interestedCount;
  set interestedCount(int? interestedCount) =>
      _$this._interestedCount = interestedCount;

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

  ListBuilder<EventEventOccurrence>? _occurrences;
  ListBuilder<EventEventOccurrence> get occurrences =>
      _$this._occurrences ??= ListBuilder<EventEventOccurrence>();
  set occurrences(ListBuilder<EventEventOccurrence>? occurrences) =>
      _$this._occurrences = occurrences;

  String? _placeId;
  String? get placeId => _$this._placeId;
  set placeId(String? placeId) => _$this._placeId = placeId;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _startDate;
  String? get startDate => _$this._startDate;
  set startDate(String? startDate) => _$this._startDate = startDate;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

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

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  int? _viewCount;
  int? get viewCount => _$this._viewCount;
  set viewCount(int? viewCount) => _$this._viewCount = viewCount;

  DtoEventResponseBuilder() {
    DtoEventResponse._defaults(this);
  }

  DtoEventResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coverImageUrl = $v.coverImageUrl;
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _description = $v.description;
      _endDate = $v.endDate;
      _id = $v.id;
      _images = $v.images?.toBuilder();
      _interestedCount = $v.interestedCount;
      _latitude = $v.latitude;
      _locationName = $v.locationName;
      _longitude = $v.longitude;
      _metadata = $v.metadata?.toBuilder();
      _occurrences = $v.occurrences?.toBuilder();
      _placeId = $v.placeId;
      _slug = $v.slug;
      _startDate = $v.startDate;
      _status = $v.status;
      _subtitle = $v.subtitle;
      _tags = $v.tags?.toBuilder();
      _title = $v.title;
      _type = $v.type;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _viewCount = $v.viewCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoEventResponse other) {
    _$v = other as _$DtoEventResponse;
  }

  @override
  void update(void Function(DtoEventResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoEventResponse build() => _build();

  _$DtoEventResponse _build() {
    _$DtoEventResponse _$result;
    try {
      _$result = _$v ??
          _$DtoEventResponse._(
            coverImageUrl: coverImageUrl,
            createdAt: createdAt,
            createdBy: createdBy,
            description: description,
            endDate: endDate,
            id: id,
            images: _images?.build(),
            interestedCount: interestedCount,
            latitude: latitude,
            locationName: locationName,
            longitude: longitude,
            metadata: _metadata?.build(),
            occurrences: _occurrences?.build(),
            placeId: placeId,
            slug: slug,
            startDate: startDate,
            status: status,
            subtitle: subtitle,
            tags: _tags?.build(),
            title: title,
            type: type,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
            viewCount: viewCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();

        _$failedField = 'metadata';
        _metadata?.build();
        _$failedField = 'occurrences';
        _occurrences?.build();

        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoEventResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
