// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_feed_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DtoFeedResponse extends DtoFeedResponse {
  @override
  final BuiltList<DtoFeedSectionResponse>? sections;

  factory _$DtoFeedResponse([void Function(DtoFeedResponseBuilder)? updates]) =>
      (DtoFeedResponseBuilder()..update(updates))._build();

  _$DtoFeedResponse._({this.sections}) : super._();
  @override
  DtoFeedResponse rebuild(void Function(DtoFeedResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DtoFeedResponseBuilder toBuilder() => DtoFeedResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DtoFeedResponse && sections == other.sections;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sections.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DtoFeedResponse')
          ..add('sections', sections))
        .toString();
  }
}

class DtoFeedResponseBuilder
    implements Builder<DtoFeedResponse, DtoFeedResponseBuilder> {
  _$DtoFeedResponse? _$v;

  ListBuilder<DtoFeedSectionResponse>? _sections;
  ListBuilder<DtoFeedSectionResponse> get sections =>
      _$this._sections ??= ListBuilder<DtoFeedSectionResponse>();
  set sections(ListBuilder<DtoFeedSectionResponse>? sections) =>
      _$this._sections = sections;

  DtoFeedResponseBuilder() {
    DtoFeedResponse._defaults(this);
  }

  DtoFeedResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sections = $v.sections?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DtoFeedResponse other) {
    _$v = other as _$DtoFeedResponse;
  }

  @override
  void update(void Function(DtoFeedResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DtoFeedResponse build() => _build();

  _$DtoFeedResponse _build() {
    _$DtoFeedResponse _$result;
    try {
      _$result = _$v ??
          _$DtoFeedResponse._(
            sections: _sections?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sections';
        _sections?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DtoFeedResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
