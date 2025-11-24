//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_review_entity_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_rating_stats_response.g.dart';

/// DtoRatingStatsResponse
///
/// Properties:
/// * [averageRating] 
/// * [entityId] 
/// * [entityType] 
/// * [fiveStarCount] 
/// * [fourStarCount] 
/// * [oneStarCount] 
/// * [ratingDistribution] - rating -> count
/// * [reviewsWithContent] 
/// * [reviewsWithImages] 
/// * [threeStarCount] 
/// * [totalReviews] 
/// * [twoStarCount] 
/// * [verifiedReviews] 
@BuiltValue()
abstract class DtoRatingStatsResponse implements Built<DtoRatingStatsResponse, DtoRatingStatsResponseBuilder> {
  @BuiltValueField(wireName: r'average_rating')
  num? get averageRating;

  @BuiltValueField(wireName: r'entity_id')
  String? get entityId;

  @BuiltValueField(wireName: r'entity_type')
  TypesReviewEntityType? get entityType;
  // enum entityTypeEnum {  place,  hotel,  restaurant,  event,  experience,  attraction,  };

  @BuiltValueField(wireName: r'five_star_count')
  int? get fiveStarCount;

  @BuiltValueField(wireName: r'four_star_count')
  int? get fourStarCount;

  @BuiltValueField(wireName: r'one_star_count')
  int? get oneStarCount;

  /// rating -> count
  @BuiltValueField(wireName: r'rating_distribution')
  BuiltMap<String, int>? get ratingDistribution;

  @BuiltValueField(wireName: r'reviews_with_content')
  int? get reviewsWithContent;

  @BuiltValueField(wireName: r'reviews_with_images')
  int? get reviewsWithImages;

  @BuiltValueField(wireName: r'three_star_count')
  int? get threeStarCount;

  @BuiltValueField(wireName: r'total_reviews')
  int? get totalReviews;

  @BuiltValueField(wireName: r'two_star_count')
  int? get twoStarCount;

  @BuiltValueField(wireName: r'verified_reviews')
  int? get verifiedReviews;

  DtoRatingStatsResponse._();

  factory DtoRatingStatsResponse([void updates(DtoRatingStatsResponseBuilder b)]) = _$DtoRatingStatsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoRatingStatsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoRatingStatsResponse> get serializer => _$DtoRatingStatsResponseSerializer();
}

class _$DtoRatingStatsResponseSerializer implements PrimitiveSerializer<DtoRatingStatsResponse> {
  @override
  final Iterable<Type> types = const [DtoRatingStatsResponse, _$DtoRatingStatsResponse];

  @override
  final String wireName = r'DtoRatingStatsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoRatingStatsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.averageRating != null) {
      yield r'average_rating';
      yield serializers.serialize(
        object.averageRating,
        specifiedType: const FullType(num),
      );
    }
    if (object.entityId != null) {
      yield r'entity_id';
      yield serializers.serialize(
        object.entityId,
        specifiedType: const FullType(String),
      );
    }
    if (object.entityType != null) {
      yield r'entity_type';
      yield serializers.serialize(
        object.entityType,
        specifiedType: const FullType(TypesReviewEntityType),
      );
    }
    if (object.fiveStarCount != null) {
      yield r'five_star_count';
      yield serializers.serialize(
        object.fiveStarCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.fourStarCount != null) {
      yield r'four_star_count';
      yield serializers.serialize(
        object.fourStarCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.oneStarCount != null) {
      yield r'one_star_count';
      yield serializers.serialize(
        object.oneStarCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.ratingDistribution != null) {
      yield r'rating_distribution';
      yield serializers.serialize(
        object.ratingDistribution,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.reviewsWithContent != null) {
      yield r'reviews_with_content';
      yield serializers.serialize(
        object.reviewsWithContent,
        specifiedType: const FullType(int),
      );
    }
    if (object.reviewsWithImages != null) {
      yield r'reviews_with_images';
      yield serializers.serialize(
        object.reviewsWithImages,
        specifiedType: const FullType(int),
      );
    }
    if (object.threeStarCount != null) {
      yield r'three_star_count';
      yield serializers.serialize(
        object.threeStarCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalReviews != null) {
      yield r'total_reviews';
      yield serializers.serialize(
        object.totalReviews,
        specifiedType: const FullType(int),
      );
    }
    if (object.twoStarCount != null) {
      yield r'two_star_count';
      yield serializers.serialize(
        object.twoStarCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.verifiedReviews != null) {
      yield r'verified_reviews';
      yield serializers.serialize(
        object.verifiedReviews,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoRatingStatsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoRatingStatsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'average_rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.averageRating = valueDes;
          break;
        case r'entity_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.entityId = valueDes;
          break;
        case r'entity_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesReviewEntityType),
          ) as TypesReviewEntityType;
          result.entityType = valueDes;
          break;
        case r'five_star_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fiveStarCount = valueDes;
          break;
        case r'four_star_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fourStarCount = valueDes;
          break;
        case r'one_star_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.oneStarCount = valueDes;
          break;
        case r'rating_distribution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>;
          result.ratingDistribution.replace(valueDes);
          break;
        case r'reviews_with_content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.reviewsWithContent = valueDes;
          break;
        case r'reviews_with_images':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.reviewsWithImages = valueDes;
          break;
        case r'three_star_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.threeStarCount = valueDes;
          break;
        case r'total_reviews':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalReviews = valueDes;
          break;
        case r'two_star_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.twoStarCount = valueDes;
          break;
        case r'verified_reviews':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.verifiedReviews = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoRatingStatsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoRatingStatsResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

