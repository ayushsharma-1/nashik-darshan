// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_create_review_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoCreateReviewRequest extends DtoCreateReviewRequest {
  @override
  final String? content;
  @override
  final String entityId;
  @override
  final TypesReviewEntityType entityType;
  @override
  final BuiltList<String>? images;
  @override
  final num rating;
  @override
  final BuiltList<String>? tags;
  @override
  final String? title;

  factory _$DtoCreateReviewRequest(
          [void Function(DtoCreateReviewRequestBuilder)? updates]) =>
      (DtoCreateReviewRequestBuilder()..update(updates))._build();

  _$DtoCreateReviewRequest._(
      {this.content,
      required this.entityId,
      required this.entityType,
      this.images,
      required this.rating,
      this.tags,
      this.title})
      : super._();
  @override
  DtoCreateReviewRequest rebuild(
          void Function(DtoCreateReviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoCreateReviewRequestBuilder toBuilder() =>
      DtoCreateReviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoCreateReviewRequest &&
        content == other.content &&
        entityId == other.entityId &&
        entityType == other.entityType &&
        images == other.images &&
        rating == other.rating &&
        tags == other.tags &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoCreateReviewRequest')
          ..add('content', content)
          ..add('entityId', entityId)
          ..add('entityType', entityType)
          ..add('images', images)
          ..add('rating', rating)
          ..add('tags', tags)
          ..add('title', title))
        .toString();
  }
}

class DtoCreateReviewRequestBuilder
    implements Builder<DtoCreateReviewRequest, DtoCreateReviewRequestBuilder> {
  _$DtoCreateReviewRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  TypesReviewEntityType? _entityType;
  TypesReviewEntityType? get entityType => _$this._entityType;
  set entityType(TypesReviewEntityType? entityType) =>
      _$this._entityType = entityType;

  ListBuilder<String>? _images;
  ListBuilder<String> get images => _$this._images ??= ListBuilder<String>();
  set images(ListBuilder<String>? images) => _$this._images = images;

  num? _rating;
  num? get rating => _$this._rating;
  set rating(num? rating) => _$this._rating = rating;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  DtoCreateReviewRequestBuilder() {
    DtoCreateReviewRequest._defaults(this);
  }

  DtoCreateReviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _entityId = $v.entityId;
      _entityType = $v.entityType;
      _images = $v.images?.toBuilder();
      _rating = $v.rating;
      _tags = $v.tags?.toBuilder();
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoCreateReviewRequest other) {
    _$v = other as _$DtoCreateReviewRequest;
  }

  @override
  void update(void Function(DtoCreateReviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoCreateReviewRequest build() => _build();

  _$DtoCreateReviewRequest _build() {
    _$DtoCreateReviewRequest _$result;
    try {
      _$result = _$v ??
          _$DtoCreateReviewRequest._(
            content: content,
            entityId: BuiltValueNullFieldError.checkNotNull(
                entityId, r'DtoCreateReviewRequest', 'entityId'),
            entityType: BuiltValueNullFieldError.checkNotNull(
                entityType, r'DtoCreateReviewRequest', 'entityType'),
            images: _images?.build(),
            rating: BuiltValueNullFieldError.checkNotNull(
                rating, r'DtoCreateReviewRequest', 'rating'),
            tags: _tags?.build(),
            title: title,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();

        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoCreateReviewRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
