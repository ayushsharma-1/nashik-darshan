// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_update_review_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoUpdateReviewRequest extends DtoUpdateReviewRequest {
  @override
  final String? content;
  @override
  final BuiltList<String>? images;
  @override
  final num? rating;
  @override
  final BuiltList<String>? tags;
  @override
  final String? title;

  factory _$DtoUpdateReviewRequest(
          [void Function(DtoUpdateReviewRequestBuilder)? updates]) =>
      (DtoUpdateReviewRequestBuilder()..update(updates))._build();

  _$DtoUpdateReviewRequest._(
      {this.content, this.images, this.rating, this.tags, this.title})
      : super._();
  @override
  DtoUpdateReviewRequest rebuild(
          void Function(DtoUpdateReviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoUpdateReviewRequestBuilder toBuilder() =>
      DtoUpdateReviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoUpdateReviewRequest &&
        content == other.content &&
        images == other.images &&
        rating == other.rating &&
        tags == other.tags &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoUpdateReviewRequest')
          ..add('content', content)
          ..add('images', images)
          ..add('rating', rating)
          ..add('tags', tags)
          ..add('title', title))
        .toString();
  }
}

class DtoUpdateReviewRequestBuilder
    implements Builder<DtoUpdateReviewRequest, DtoUpdateReviewRequestBuilder> {
  _$DtoUpdateReviewRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

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

  DtoUpdateReviewRequestBuilder() {
    DtoUpdateReviewRequest._defaults(this);
  }

  DtoUpdateReviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _images = $v.images?.toBuilder();
      _rating = $v.rating;
      _tags = $v.tags?.toBuilder();
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoUpdateReviewRequest other) {
    _$v = other as _$DtoUpdateReviewRequest;
  }

  @override
  void update(void Function(DtoUpdateReviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoUpdateReviewRequest build() => _build();

  _$DtoUpdateReviewRequest _build() {
    _$DtoUpdateReviewRequest _$result;
    try {
      _$result = _$v ??
          _$DtoUpdateReviewRequest._(
            content: content,
            images: _images?.build(),
            rating: rating,
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
            r'DtoUpdateReviewRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
