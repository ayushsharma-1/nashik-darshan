// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_review_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoReviewResponse extends DtoReviewResponse {
  @override
  final String? content;
  @override
  final String? createdAt;
  @override
  final String? createdBy;
  @override
  final String? entityId;
  @override
  final TypesReviewEntityType? entityType;
  @override
  final int? helpfulCount;
  @override
  final String? id;
  @override
  final BuiltList<String>? images;
  @override
  final bool? isFeatured;
  @override
  final bool? isVerified;
  @override
  final int? notHelpfulCount;
  @override
  final num? rating;
  @override
  final TypesStatus? status;
  @override
  final BuiltList<String>? tags;
  @override
  final String? title;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;
  @override
  final String? userId;

  factory _$DtoReviewResponse(
          [void Function(DtoReviewResponseBuilder)? updates]) =>
      (DtoReviewResponseBuilder()..update(updates))._build();

  _$DtoReviewResponse._(
      {this.content,
      this.createdAt,
      this.createdBy,
      this.entityId,
      this.entityType,
      this.helpfulCount,
      this.id,
      this.images,
      this.isFeatured,
      this.isVerified,
      this.notHelpfulCount,
      this.rating,
      this.status,
      this.tags,
      this.title,
      this.updatedAt,
      this.updatedBy,
      this.userId})
      : super._();
  @override
  DtoReviewResponse rebuild(void Function(DtoReviewResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoReviewResponseBuilder toBuilder() =>
      DtoReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoReviewResponse &&
        content == other.content &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        entityId == other.entityId &&
        entityType == other.entityType &&
        helpfulCount == other.helpfulCount &&
        id == other.id &&
        images == other.images &&
        isFeatured == other.isFeatured &&
        isVerified == other.isVerified &&
        notHelpfulCount == other.notHelpfulCount &&
        rating == other.rating &&
        status == other.status &&
        tags == other.tags &&
        title == other.title &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, helpfulCount.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, isFeatured.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jc(_$hash, notHelpfulCount.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, updatedBy.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoReviewResponse')
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('createdBy', createdBy)
          ..add('entityId', entityId)
          ..add('entityType', entityType)
          ..add('helpfulCount', helpfulCount)
          ..add('id', id)
          ..add('images', images)
          ..add('isFeatured', isFeatured)
          ..add('isVerified', isVerified)
          ..add('notHelpfulCount', notHelpfulCount)
          ..add('rating', rating)
          ..add('status', status)
          ..add('tags', tags)
          ..add('title', title)
          ..add('updatedAt', updatedAt)
          ..add('updatedBy', updatedBy)
          ..add('userId', userId))
        .toString();
  }
}

class DtoReviewResponseBuilder
    implements Builder<DtoReviewResponse, DtoReviewResponseBuilder> {
  _$DtoReviewResponse? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  TypesReviewEntityType? _entityType;
  TypesReviewEntityType? get entityType => _$this._entityType;
  set entityType(TypesReviewEntityType? entityType) =>
      _$this._entityType = entityType;

  int? _helpfulCount;
  int? get helpfulCount => _$this._helpfulCount;
  set helpfulCount(int? helpfulCount) => _$this._helpfulCount = helpfulCount;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<String>? _images;
  ListBuilder<String> get images => _$this._images ??= ListBuilder<String>();
  set images(ListBuilder<String>? images) => _$this._images = images;

  bool? _isFeatured;
  bool? get isFeatured => _$this._isFeatured;
  set isFeatured(bool? isFeatured) => _$this._isFeatured = isFeatured;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  int? _notHelpfulCount;
  int? get notHelpfulCount => _$this._notHelpfulCount;
  set notHelpfulCount(int? notHelpfulCount) =>
      _$this._notHelpfulCount = notHelpfulCount;

  num? _rating;
  num? get rating => _$this._rating;
  set rating(num? rating) => _$this._rating = rating;

  TypesStatus? _status;
  TypesStatus? get status => _$this._status;
  set status(TypesStatus? status) => _$this._status = status;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _updatedBy;
  String? get updatedBy => _$this._updatedBy;
  set updatedBy(String? updatedBy) => _$this._updatedBy = updatedBy;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  DtoReviewResponseBuilder() {
    DtoReviewResponse._defaults(this);
  }

  DtoReviewResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _createdAt = $v.createdAt;
      _createdBy = $v.createdBy;
      _entityId = $v.entityId;
      _entityType = $v.entityType;
      _helpfulCount = $v.helpfulCount;
      _id = $v.id;
      _images = $v.images?.toBuilder();
      _isFeatured = $v.isFeatured;
      _isVerified = $v.isVerified;
      _notHelpfulCount = $v.notHelpfulCount;
      _rating = $v.rating;
      _status = $v.status;
      _tags = $v.tags?.toBuilder();
      _title = $v.title;
      _updatedAt = $v.updatedAt;
      _updatedBy = $v.updatedBy;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoReviewResponse other) {
    _$v = other as _$DtoReviewResponse;
  }

  @override
  void update(void Function(DtoReviewResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoReviewResponse build() => _build();

  _$DtoReviewResponse _build() {
    _$DtoReviewResponse _$result;
    try {
      _$result = _$v ??
          _$DtoReviewResponse._(
            content: content,
            createdAt: createdAt,
            createdBy: createdBy,
            entityId: entityId,
            entityType: entityType,
            helpfulCount: helpfulCount,
            id: id,
            images: _images?.build(),
            isFeatured: isFeatured,
            isVerified: isVerified,
            notHelpfulCount: notHelpfulCount,
            rating: rating,
            status: status,
            tags: _tags?.build(),
            title: title,
            updatedAt: updatedAt,
            updatedBy: updatedBy,
            userId: userId,
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
            r'DtoReviewResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
