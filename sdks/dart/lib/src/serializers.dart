//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:nashik_darshan_sdk/src/date_serializer.dart';
import 'package:nashik_darshan_sdk/src/model/date.dart';

import 'package:nashik_darshan_sdk/src/model/dto_category_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_create_category_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_create_place_image_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_create_place_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_create_review_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_feed_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_feed_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_feed_section_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_feed_section_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_list_categories_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_list_places_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_me_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_place_image_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_place_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_rating_stats_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_review_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_signup_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_signup_response.dart';
import 'package:nashik_darshan_sdk/src/model/dto_update_category_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_update_place_image_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_update_place_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_update_review_request.dart';
import 'package:nashik_darshan_sdk/src/model/dto_update_user_request.dart';
import 'package:nashik_darshan_sdk/src/model/ierr_error_detail.dart';
import 'package:nashik_darshan_sdk/src/model/ierr_error_response.dart';
import 'package:nashik_darshan_sdk/src/model/place_place_image.dart';
import 'package:nashik_darshan_sdk/src/model/types_feed_section_type.dart';
import 'package:nashik_darshan_sdk/src/model/types_list_response_dto_review_response.dart';
import 'package:nashik_darshan_sdk/src/model/types_location.dart';
import 'package:nashik_darshan_sdk/src/model/types_pagination_response.dart';
import 'package:nashik_darshan_sdk/src/model/types_review_entity_type.dart';
import 'package:nashik_darshan_sdk/src/model/types_status.dart';
import 'package:nashik_darshan_sdk/src/model/types_user_role.dart';

part 'serializers.g.dart';

@SerializersFor([
  DtoCategoryResponse,
  DtoCreateCategoryRequest,
  DtoCreatePlaceImageRequest,
  DtoCreatePlaceRequest,
  DtoCreateReviewRequest,
  DtoFeedRequest,
  DtoFeedResponse,
  DtoFeedSectionRequest,
  DtoFeedSectionResponse,
  DtoListCategoriesResponse,
  DtoListPlacesResponse,
  DtoMeResponse,
  DtoPlaceImageResponse,
  DtoPlaceResponse,
  DtoRatingStatsResponse,
  DtoReviewResponse,
  DtoSignupRequest,
  DtoSignupResponse,
  DtoUpdateCategoryRequest,
  DtoUpdatePlaceImageRequest,
  DtoUpdatePlaceRequest,
  DtoUpdateReviewRequest,
  DtoUpdateUserRequest,
  IerrErrorDetail,
  IerrErrorResponse,
  PlacePlaceImage,
  TypesFeedSectionType,
  TypesListResponseDtoReviewResponse,
  TypesLocation,
  TypesPaginationResponse,
  TypesReviewEntityType,
  TypesStatus,
  TypesUserRole,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(DtoPlaceImageResponse)]),
        () => ListBuilder<DtoPlaceImageResponse>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
