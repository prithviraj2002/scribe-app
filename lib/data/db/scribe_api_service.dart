import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/client/http_client.dart';
import 'package:scribe/data/endpoints.dart';
import 'package:scribe/domain/model/scribe/scribe_model.dart';
import 'package:scribe/domain/model/student_model/student_model.dart';
import 'package:scribe/domain/model/volunteer_req_model/volunteer_req_model.dart';

class ScribeApiService{
  ScribeClient client = getIt<ScribeClient>();

  Future<dynamic> setUserRole(Map<String, dynamic> data) async{
    return await client.post(Endpoints.setUserRole, data);
  }

  Future<dynamic> getUserRole(String endpoint) async{
    return await client.get(endpoint);
  }

  //Scribe functions
  Future<ScribeModel> getScribe() async{
    final response = await client.get(Endpoints.scribe);

    return ScribeModel.fromJson(response['data']);
  }

  Future<dynamic> createScribe(ScribeModel scribe) async{
    return await client.post(Endpoints.scribe, scribe.toMap());
  }

  Future<void> updateScribe(Map<String, dynamic> data) async{
    return await client.patch(Endpoints.scribe, data);
  }

  Future<void> deleteScribe() async{
    return await client.delete(Endpoints.scribe);
  }

  Future<dynamic> checkIfScribeExists() async{
    return await client.get(Endpoints.checkScribe);
  }

  //Review functions
  Future<dynamic> getScribeReviews(String uid) async{
    return await client.get(Endpoints.review + uid);
  }

  //Scribe Request functions
  Future<dynamic> getScribeReqs({String isComplete = "false", String isOpen = "true"}) async{
    return await client.get('${Endpoints.scribeReq}/?isComplete=$isComplete&isOpen=$isOpen');
  }

  Future<dynamic> getScribeReqForScribe(String scribeId, {String isComplete = "false", String isOpen = "true"}) async{
    return await client.get('${Endpoints.scribeReqByScribe}$scribeId/?isComplete=$isComplete&isOpen=$isOpen');
  }

  //Student function
  Future<StudentModel> getStudent(String studentId) async{
    final response = await client.get(Endpoints.student + studentId);

    return StudentModel.fromJson(response['data']);
  }

  //apply to scribe req as volunteer
  Future<dynamic> applyToScribeReq(VolunteerRequest req) async{
    return await client.post(
        Endpoints.createReq + req.scribeReqId,
        req.toJson()
    );
  }

  Future<dynamic> checkIfApplied(String id) async{
    return await client.get(
      '${Endpoints.checkApplied}/$id'
    );
  }

  Future<dynamic> getReqAppliedByScribe() async{
    return await client.get(Endpoints.appliedVolunteer);
  }
}