//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nashik_darshan_sdk/src/model/types_location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dto_update_hotel_request.g.dart';

/// DtoUpdateHotelRequest
///
/// Properties:
/// * [address] 
/// * [checkInTime] 
/// * [checkOutTime] 
/// * [currency] 
/// * [description] 
/// * [email] 
/// * [location] 
/// * [name] 
/// * [phone] 
/// * [priceMax] 
/// * [priceMin] 
/// * [primaryImageUrl] 
/// * [roomCount] 
/// * [starRating] 
/// * [thumbnailUrl] 
/// * [website] 
@BuiltValue()
abstract class DtoUpdateHotelRequest implements Built<DtoUpdateHotelRequest, DtoUpdateHotelRequestBuilder> {
  @BuiltValueField(wireName: r'address')
  BuiltMap<String, String>? get address;

  @BuiltValueField(wireName: r'check_in_time')
  String? get checkInTime;

  @BuiltValueField(wireName: r'check_out_time')
  String? get checkOutTime;

  @BuiltValueField(wireName: r'currency')
  String? get currency;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'location')
  TypesLocation? get location;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'price_max')
  num? get priceMax;

  @BuiltValueField(wireName: r'price_min')
  num? get priceMin;

  @BuiltValueField(wireName: r'primary_image_url')
  String? get primaryImageUrl;

  @BuiltValueField(wireName: r'room_count')
  int? get roomCount;

  @BuiltValueField(wireName: r'star_rating')
  int? get starRating;

  @BuiltValueField(wireName: r'thumbnail_url')
  String? get thumbnailUrl;

  @BuiltValueField(wireName: r'website')
  String? get website;

  DtoUpdateHotelRequest._();

  factory DtoUpdateHotelRequest([void updates(DtoUpdateHotelRequestBuilder b)]) = _$DtoUpdateHotelRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DtoUpdateHotelRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DtoUpdateHotelRequest> get serializer => _$DtoUpdateHotelRequestSerializer();
}

class _$DtoUpdateHotelRequestSerializer implements PrimitiveSerializer<DtoUpdateHotelRequest> {
  @override
  final Iterable<Type> types = const [DtoUpdateHotelRequest, _$DtoUpdateHotelRequest];

  @override
  final String wireName = r'DtoUpdateHotelRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DtoUpdateHotelRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.checkInTime != null) {
      yield r'check_in_time';
      yield serializers.serialize(
        object.checkInTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.checkOutTime != null) {
      yield r'check_out_time';
      yield serializers.serialize(
        object.checkOutTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
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
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType(String),
      );
    }
    if (object.priceMax != null) {
      yield r'price_max';
      yield serializers.serialize(
        object.priceMax,
        specifiedType: const FullType(num),
      );
    }
    if (object.priceMin != null) {
      yield r'price_min';
      yield serializers.serialize(
        object.priceMin,
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
    if (object.roomCount != null) {
      yield r'room_count';
      yield serializers.serialize(
        object.roomCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.starRating != null) {
      yield r'star_rating';
      yield serializers.serialize(
        object.starRating,
        specifiedType: const FullType(int),
      );
    }
    if (object.thumbnailUrl != null) {
      yield r'thumbnail_url';
      yield serializers.serialize(
        object.thumbnailUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.website != null) {
      yield r'website';
      yield serializers.serialize(
        object.website,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DtoUpdateHotelRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DtoUpdateHotelRequestBuilder result,
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
        case r'check_in_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checkInTime = valueDes;
          break;
        case r'check_out_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checkOutTime = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TypesLocation),
          ) as TypesLocation;
          result.location.replace(valueDes);
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        case r'price_max':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.priceMax = valueDes;
          break;
        case r'price_min':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.priceMin = valueDes;
          break;
        case r'primary_image_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryImageUrl = valueDes;
          break;
        case r'room_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.roomCount = valueDes;
          break;
        case r'star_rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.starRating = valueDes;
          break;
        case r'thumbnail_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.thumbnailUrl = valueDes;
          break;
        case r'website':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.website = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DtoUpdateHotelRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DtoUpdateHotelRequestBuilder();
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

