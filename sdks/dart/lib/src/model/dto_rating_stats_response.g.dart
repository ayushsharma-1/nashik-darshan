// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_rating_stats_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoRatingStatsResponse extends DtoRatingStatsResponse {
  @override
  final num? averageRating;
  @override
  final String? entityId;
  @override
  final TypesReviewEntityType? entityType;
  @override
  final int? fiveStarCount;
  @override
  final int? fourStarCount;
  @override
  final int? oneStarCount;
  @override
  final BuiltMap<String, int>? ratingDistribution;
  @override
  final int? reviewsWithContent;
  @override
  final int? reviewsWithImages;
  @override
  final int? threeStarCount;
  @override
  final int? totalReviews;
  @override
  final int? twoStarCount;
  @override
  final int? verifiedReviews;

  factory _$DtoRatingStatsResponse(
          [void Function(DtoRatingStatsResponseBuilder)? updates]) =>
      (DtoRatingStatsResponseBuilder()..update(updates))._build();

  _$DtoRatingStatsResponse._(
      {this.averageRating,
      this.entityId,
      this.entityType,
      this.fiveStarCount,
      this.fourStarCount,
      this.oneStarCount,
      this.ratingDistribution,
      this.reviewsWithContent,
      this.reviewsWithImages,
      this.threeStarCount,
      this.totalReviews,
      this.twoStarCount,
      this.verifiedReviews})
      : super._();
  @override
  DtoRatingStatsResponse rebuild(
          void Function(DtoRatingStatsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoRatingStatsResponseBuilder toBuilder() =>
      DtoRatingStatsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoRatingStatsResponse &&
        averageRating == other.averageRating &&
        entityId == other.entityId &&
        entityType == other.entityType &&
        fiveStarCount == other.fiveStarCount &&
        fourStarCount == other.fourStarCount &&
        oneStarCount == other.oneStarCount &&
        ratingDistribution == other.ratingDistribution &&
        reviewsWithContent == other.reviewsWithContent &&
        reviewsWithImages == other.reviewsWithImages &&
        threeStarCount == other.threeStarCount &&
        totalReviews == other.totalReviews &&
        twoStarCount == other.twoStarCount &&
        verifiedReviews == other.verifiedReviews;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, averageRating.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, fiveStarCount.hashCode);
    _$hash = $jc(_$hash, fourStarCount.hashCode);
    _$hash = $jc(_$hash, oneStarCount.hashCode);
    _$hash = $jc(_$hash, ratingDistribution.hashCode);
    _$hash = $jc(_$hash, reviewsWithContent.hashCode);
    _$hash = $jc(_$hash, reviewsWithImages.hashCode);
    _$hash = $jc(_$hash, threeStarCount.hashCode);
    _$hash = $jc(_$hash, totalReviews.hashCode);
    _$hash = $jc(_$hash, twoStarCount.hashCode);
    _$hash = $jc(_$hash, verifiedReviews.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoRatingStatsResponse')
          ..add('averageRating', averageRating)
          ..add('entityId', entityId)
          ..add('entityType', entityType)
          ..add('fiveStarCount', fiveStarCount)
          ..add('fourStarCount', fourStarCount)
          ..add('oneStarCount', oneStarCount)
          ..add('ratingDistribution', ratingDistribution)
          ..add('reviewsWithContent', reviewsWithContent)
          ..add('reviewsWithImages', reviewsWithImages)
          ..add('threeStarCount', threeStarCount)
          ..add('totalReviews', totalReviews)
          ..add('twoStarCount', twoStarCount)
          ..add('verifiedReviews', verifiedReviews))
        .toString();
  }
}

class DtoRatingStatsResponseBuilder
    implements Builder<DtoRatingStatsResponse, DtoRatingStatsResponseBuilder> {
  _$DtoRatingStatsResponse? _$v;

  num? _averageRating;
  num? get averageRating => _$this._averageRating;
  set averageRating(num? averageRating) =>
      _$this._averageRating = averageRating;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  TypesReviewEntityType? _entityType;
  TypesReviewEntityType? get entityType => _$this._entityType;
  set entityType(TypesReviewEntityType? entityType) =>
      _$this._entityType = entityType;

  int? _fiveStarCount;
  int? get fiveStarCount => _$this._fiveStarCount;
  set fiveStarCount(int? fiveStarCount) =>
      _$this._fiveStarCount = fiveStarCount;

  int? _fourStarCount;
  int? get fourStarCount => _$this._fourStarCount;
  set fourStarCount(int? fourStarCount) =>
      _$this._fourStarCount = fourStarCount;

  int? _oneStarCount;
  int? get oneStarCount => _$this._oneStarCount;
  set oneStarCount(int? oneStarCount) => _$this._oneStarCount = oneStarCount;

  MapBuilder<String, int>? _ratingDistribution;
  MapBuilder<String, int> get ratingDistribution =>
      _$this._ratingDistribution ??= MapBuilder<String, int>();
  set ratingDistribution(MapBuilder<String, int>? ratingDistribution) =>
      _$this._ratingDistribution = ratingDistribution;

  int? _reviewsWithContent;
  int? get reviewsWithContent => _$this._reviewsWithContent;
  set reviewsWithContent(int? reviewsWithContent) =>
      _$this._reviewsWithContent = reviewsWithContent;

  int? _reviewsWithImages;
  int? get reviewsWithImages => _$this._reviewsWithImages;
  set reviewsWithImages(int? reviewsWithImages) =>
      _$this._reviewsWithImages = reviewsWithImages;

  int? _threeStarCount;
  int? get threeStarCount => _$this._threeStarCount;
  set threeStarCount(int? threeStarCount) =>
      _$this._threeStarCount = threeStarCount;

  int? _totalReviews;
  int? get totalReviews => _$this._totalReviews;
  set totalReviews(int? totalReviews) => _$this._totalReviews = totalReviews;

  int? _twoStarCount;
  int? get twoStarCount => _$this._twoStarCount;
  set twoStarCount(int? twoStarCount) => _$this._twoStarCount = twoStarCount;

  int? _verifiedReviews;
  int? get verifiedReviews => _$this._verifiedReviews;
  set verifiedReviews(int? verifiedReviews) =>
      _$this._verifiedReviews = verifiedReviews;

  DtoRatingStatsResponseBuilder() {
    DtoRatingStatsResponse._defaults(this);
  }

  DtoRatingStatsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _averageRating = $v.averageRating;
      _entityId = $v.entityId;
      _entityType = $v.entityType;
      _fiveStarCount = $v.fiveStarCount;
      _fourStarCount = $v.fourStarCount;
      _oneStarCount = $v.oneStarCount;
      _ratingDistribution = $v.ratingDistribution?.toBuilder();
      _reviewsWithContent = $v.reviewsWithContent;
      _reviewsWithImages = $v.reviewsWithImages;
      _threeStarCount = $v.threeStarCount;
      _totalReviews = $v.totalReviews;
      _twoStarCount = $v.twoStarCount;
      _verifiedReviews = $v.verifiedReviews;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoRatingStatsResponse other) {
    _$v = other as _$DtoRatingStatsResponse;
  }

  @override
  void update(void Function(DtoRatingStatsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoRatingStatsResponse build() => _build();

  _$DtoRatingStatsResponse _build() {
    _$DtoRatingStatsResponse _$result;
    try {
      _$result = _$v ??
          _$DtoRatingStatsResponse._(
            averageRating: averageRating,
            entityId: entityId,
            entityType: entityType,
            fiveStarCount: fiveStarCount,
            fourStarCount: fourStarCount,
            oneStarCount: oneStarCount,
            ratingDistribution: _ratingDistribution?.build(),
            reviewsWithContent: reviewsWithContent,
            reviewsWithImages: reviewsWithImages,
            threeStarCount: threeStarCount,
            totalReviews: totalReviews,
            twoStarCount: twoStarCount,
            verifiedReviews: verifiedReviews,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ratingDistribution';
        _ratingDistribution?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoRatingStatsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
