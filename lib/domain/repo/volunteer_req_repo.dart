import 'package:firebase_auth/firebase_auth.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/domain/model/volunteer_req_model/volunteer_req_model.dart';

class VolunteerReqRepo{

  ScribeApiService service = getIt<ScribeApiService>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> applyToScribeReq(String scribeReqId) async{
    String phone = auth.currentUser!.phoneNumber ?? "";
    return await service.applyToScribeReq(
        VolunteerRequest(
            scribeReqId: scribeReqId,
            scribeId: phone,
          isOpen: true
        )
    );
  }

  Future<bool> checkIfApplied(String id) async{
    final response = await service.checkIfApplied(id);

    return response['msg'];
  }
}