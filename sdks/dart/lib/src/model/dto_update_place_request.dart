//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_update_place_request.g.dart';

/// DtoUpdatePlaceRequest
///
/// Properties:
/// * [address] 
/// * [amenities] 
/// * [categories] 
/// * [location] 
/// * [longDescription] 
/// * [placeType] 
/// * [primaryImageUrl] 
/// * [shortDescription] 
/// * [slug] 
/// * [subtitle] 
/// * [thumbnailUrl] 
/// * [title] 
@BuiltValue()
abstract class DtoUpdatePlaceRequest implements Built<DtoUpdatePlaceRequest, DtoUpdatePlaceRequestBuilder> {
  @BuiltValueField(wireName: r'address')
  BuiltMap<String, String>? get address;

  @BuiltValueField(wireName: r'amenities')
  BuiltList<String>? get amenities;

  @BuiltValueField(wireName: r'categories')
  BuiltList<String>? get categories;

  @BuiltValueField(wireName: r'location')
  TypesLocation? get location;

  @BuiltValueField(wireName: r'long_description')
  String? get longDescription;

  @BuiltValueField(wireName: r'place_type')
  String? get placeType;

  @BuiltValueField(wireName: r'primary_image_url')
  String? get primaryImageUrl;

  @BuiltValueField(wireName: r'short_description')
  String? get shortDescription;

  @BuiltValueField(wireName: r'slug')
  String? get slug;

  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  @BuiltValueField(wireName: r'thumbnail_url')
  String? get thumbnailUrl;

  @BuiltValueField(wireName: r'title')
  String? get title;

  DtoUpdatePlaceRequest._();

  factory DtoUpdatePlaceRequest([void updates(DtoUpdatePlaceRequestBuilder b)]) = _$DtoUpdatePlaceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoUpdatePlaceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoUpdatePlaceRequest> get serializer => _$DtoUpdatePlaceRequestSerializer();
}

class _$DtoUpdatePlaceRequestSerializer implements PrimitiveSerializer<DtoUpdatePlaceRequest> {
  @override
  final Iterable<Type> types = const [DtoUpdatePlaceRequest, _$DtoUpdatePlaceRequest];

  @override
  final String wireName = r'DtoUpdatePlaceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoUpdatePlaceRequest object, {
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
    if (object.primaryImageUrl != null) {
      yield r'primary_image_url';
      yield serializers.serialize(
        object.primaryImageUrl,
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoUpdatePlaceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoUpdatePlaceRequestBuilder result,
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
        case r'primary_image_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryImageUrl = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoUpdatePlaceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoUpdatePlaceRequestBuilder();
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

