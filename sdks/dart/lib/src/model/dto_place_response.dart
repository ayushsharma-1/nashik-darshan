//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/dto_place_image_response.dart';
import 'package:nashik_darshan_sdk/src/model/types_location.dart';
import 'package:nashik_darshan_sdk/src/model/types_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_place_response.g.dart';

/// DtoPlaceResponse
///
/// Properties:
/// * [address] 
/// * [amenities] 
/// * [categories] 
/// * [createdAt] 
/// * [createdBy] 
/// * [id] 
/// * [images] 
/// * [lastViewedAt] 
/// * [location] 
/// * [longDescription] 
/// * [placeType] 
/// * [popularityScore] 
/// * [primaryImageUrl] 
/// * [ratingAvg] 
/// * [ratingCount] 
/// * [shortDescription] 
/// * [slug] 
/// * [status] 
/// * [subtitle] 
/// * [thumbnailUrl] 
/// * [title] 
/// * [updatedAt] 
/// * [updatedBy] 
/// * [viewCount] - Engagement fields for feed functionality
@BuiltValue()
abstract class DtoPlaceResponse implements Built<DtoPlaceResponse, DtoPlaceResponseBuilder> {
  @BuiltValueField(wireName: r'address')
  BuiltMap<String, String>? get address;

  @BuiltValueField(wireName: r'amenities')
  BuiltList<String>? get amenities;

  @BuiltValueField(wireName: r'categories')
  BuiltList<String>? get categories;

  @BuiltValueField(wireName: r'created_at')
  String? get createdAt;

  @BuiltValueField(wireName: r'created_by')
  String? get createdBy;

  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'images')
  BuiltList<DtoPlaceImageResponse>? get images;

  @BuiltValueField(wireName: r'last_viewed_at')
  String? get lastViewedAt;

  @BuiltValueField(wireName: r'location')
  TypesLocation? get location;

  @BuiltValueField(wireName: r'long_description')
  String? get longDescription;

  @BuiltValueField(wireName: r'place_type')
  String? get placeType;

  @BuiltValueField(wireName: r'popularity_score')
  num? get popularityScore;

  @BuiltValueField(wireName: r'primary_image_url')
  String? get primaryImageUrl;

  @BuiltValueField(wireName: r'rating_avg')
  num? get ratingAvg;

  @BuiltValueField(wireName: r'rating_count')
  int? get ratingCount;

  @BuiltValueField(wireName: r'short_description')
  String? get shortDescription;

  @BuiltValueField(wireName: r'slug')
  String? get slug;

  @BuiltValueField(wireName: r'status')
  TypesStatus? get status;
  // enum statusEnum {  published,  deleted,  archived,  inactive,  pending,  };

  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  @BuiltValueField(wireName: r'thumbnail_url')
  String? get thumbnailUrl;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'updated_at')
  String? get updatedAt;

  @BuiltValueField(wireName: r'updated_by')
  String? get updatedBy;

  /// Engagement fields for feed functionality
  @BuiltValueField(wireName: r'view_count')
  int? get viewCount;

  DtoPlaceResponse._();

  factory DtoPlaceResponse([void updates(DtoPlaceResponseBuilder b)]) = _$DtoPlaceResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoPlaceResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoPlaceResponse> get serializer => _$DtoPlaceResponseSerializer();
}

class _$DtoPlaceResponseSerializer implements PrimitiveSerializer<DtoPlaceResponse> {
  @override
  final Iterable<Type> types = const [DtoPlaceResponse, _$DtoPlaceResponse];

  @override
  final String wireName = r'DtoPlaceResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoPlaceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.amenities != null) {
      yield r'amenities';
      yield serializers.serialize(
        object.amenities,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.categories != null) {
      yield r'categories';
      yield serializers.serialize(
        object.categories,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdBy != null) {
      yield r'created_by';
      yield serializers.serialize(
        object.createdBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.images != null) {
      yield r'images';
      yield serializers.serialize(
        object.images,
        specifiedType: const FullType(BuiltList, [FullType(DtoPlaceImageResponse)]),
      );
    }
    if (object.lastViewedAt != null) {
      yield r'last_viewed_at';
      yield serializers.serialize(
        object.lastViewedAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(TypesLocation),
      );
    }
    if (object.longDescription != null) {
      yield r'long_description';
      yield serializers.serialize(
        object.longDescription,
        specifiedType: const FullType(String),
      );
    }
    if (object.placeType != null) {
      yield r'place_type';
      yield serializers.serialize(
        object.placeType,
        specifiedType: const FullType(String),
      );
    }
    if (object.popularityScore != null) {
      yield r'popularity_score';
      yield serializers.serialize(
        object.popularityScore,
        specifiedType: const FullType(num),
      );
    }
    if (object.primaryImageUrl != null) {
      yield r'primary_image_url';
      yield serializers.serialize(
        object.primaryImageUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.ratingAvg != null) {
      yield r'rating_avg';
      yield serializers.serialize(
        object.ratingAvg,
        specifiedType: const FullType(num),
      );
    }
    if (object.ratingCount != null) {
      yield r'rating_count';
      yield serializers.serialize(
        object.ratingCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.shortDescription != null) {
      yield r'short_description';
      yield serializers.serialize(
        object.shortDescription,
        specifiedType: const FullType(String),
      );
    }
    if (object.slug != null) {
      yield r'slug';
      yield serializers.serialize(
        object.slug,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TypesStatus),
      );
    }
    if (object.subtitle != null) {
      yield r'subtitle';
      yield serializers.serialize(
        object.subtitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.thumbnailUrl != null) {
      yield r'thumbnail_url';
      yield serializers.serialize(
        object.thumbnailUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.updatedBy != null) {
      yield r'updated_by';
      yield serializers.serialize(
        object.updatedBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.viewCount != null) {
      yield r'view_count';
      yield serializers.serialize(
        object.viewCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoPlaceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoPlaceResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>;
          result.address.replace(valueDes);
          break;
        case r'amenities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.amenities.replace(valueDes);
          break;
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.categories.replace(valueDes);
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdBy = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'images':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DtoPlaceImageResponse)]),
          ) as BuiltList<DtoPlaceImageResponse>;
          result.images.replace(valueDes);
          break;
        case r'last_viewed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastViewedAt = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesLocation),
          ) as TypesLocation;
          result.location.replace(valueDes);
          break;
        case r'long_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.longDescription = valueDes;
          break;
        case r'place_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.placeType = valueDes;
          break;
        case r'popularity_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.popularityScore = valueDes;
          break;
        case r'primary_image_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryImageUrl = valueDes;
          break;
        case r'rating_avg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.ratingAvg = valueDes;
          break;
        case r'rating_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ratingCount = valueDes;
          break;
        case r'short_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shortDescription = valueDes;
          break;
        case r'slug':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.slug = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesStatus),
          ) as TypesStatus;
          result.status = valueDes;
          break;
        case r'subtitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtitle = valueDes;
          break;
        case r'thumbnail_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.thumbnailUrl = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.updatedAt = valueDes;
          break;
        case r'updated_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.updatedBy = valueDes;
          break;
        case r'view_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.viewCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoPlaceResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoPlaceResponseBuilder();
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

