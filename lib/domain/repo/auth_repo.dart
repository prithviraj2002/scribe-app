import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/data/endpoints.dart';

class AuthRepo{
  ScribeApiService service = getIt<ScribeApiService>();

  Future<void> setUserRole(String uid) async{
    return await service.setUserRole(
        {
          'uid': uid,
          'role': 'scribe'
        }
    );
  }

  Future<dynamic> getUserRole(String uid) async{
    final response = await service.getUserRole('${Endpoints.getUserRole}?uid=$uid');

    return response;
  }
}