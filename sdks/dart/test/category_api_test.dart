import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for CategoryApi
void main() {
  final instance = Openapi().getCategoryApi();

  group(CategoryApi, () {
    // List categories
    //
    // Get a paginated list of categories with filtering and pagination
    //
    //Future<DtoListCategoriesResponse> categoriesGet({ int limit, int offset, String status, String sort, String order, BuiltList<String> slug, BuiltList<String> name }) async
    test('test categoriesGet', () async {
      // TODO
    });

    // Delete a category
    //
    // Soft delete a category
    //
    //Future categoriesIdDelete(String id) async
    test('test categoriesIdDelete', () async {
      // TODO
    });

    // Get category by ID
    //
    // Get a category by its ID
    //
    //Future<DtoCategoryResponse> categoriesIdGet(String id) async
    test('test categoriesIdGet', () async {
      // TODO
    });

    // Update a category
    //
    // Update an existing category
    //
    //Future<DtoCategoryResponse> categoriesIdPut(String id, DtoUpdateCategoryRequest request) async
    test('test categoriesIdPut', () async {
      // TODO
    });

    // Create a new category
    //
    // Create a new category with the provided details
    //
    //Future<DtoCategoryResponse> categoriesPost(DtoCreateCategoryRequest request) async
    test('test categoriesPost', () async {
      // TODO
    });

    // Get category by slug
    //
    // Get a category by its slug
    //
    //Future<DtoCategoryResponse> categoriesSlugSlugGet(String slug) async
    test('test categoriesSlugSlugGet', () async {
      // TODO
    });

  });
}
