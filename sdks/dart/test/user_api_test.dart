import 'package:test/test.dart';
import 'package:nashik_darshan_sdk/openapi.dart';


/// tests for UserApi
void main() {
  final instance = Openapi().getUserApi();

  group(UserApi, () {
    // Get current user
    //
    // Get the current user's information
    //
    //Future<DtoMeResponse> userMeGet() async
    test('test userMeGet', () async {
      // TODO
    });

    // Update current user
    //
    // Update the current user's information
    //
    //Future<DtoMeResponse> userPut(DtoUpdateUserRequest request) async
    test('test userPut', () async {
      // TODO
    });

  });
}
