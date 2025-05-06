import 'package:firebase_auth/firebase_auth.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';

class RequestsRepo{
  ScribeApiService service = getIt<ScribeApiService>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<ScribeRequest>> getScribeReq() async{
    List<ScribeRequest> reqs = [];

    final response = await service.getScribeReqs(isOpen: "true", isComplete: "false");

    for(Map<String, dynamic> req in response['data']){
      reqs.add(ScribeRequest.fromJson(req));
    }

    return reqs;
  }

  Future<List<ScribeRequest>> getCompletedReqs() async{
    final scribeId = auth.currentUser!.phoneNumber!;

    String id = scribeId.substring(1);
    id = "%2B$id";

    List<ScribeRequest> reqs = [];
    final response = await service.getScribeReqForScribe(id, isComplete: "true", isOpen: 'false');

    for(var req in response['data']){
      reqs.add(ScribeRequest.fromJson(req));
    }

    return reqs;
  }

  Future<List<ScribeRequest>> getOngoingScribeReq() async{
    final scribeId = auth.currentUser!.phoneNumber!;

    String id = scribeId.substring(1);
    id = "%2B$id";

    List<ScribeRequest> reqs = [];
    final response = await service.getScribeReqForScribe(id, isComplete: "false", isOpen: 'false');

    for(var req in response['data']){
      reqs.add(ScribeRequest.fromJson(req));
    }

    return reqs;
  }

  Future<List<ScribeRequest>> getAppliedReqs() async{
    List<ScribeRequest> reqs = [];

    final response = await service.getReqAppliedByScribe();

    for(Map<String, dynamic> req in response['data']){
      reqs.add(ScribeRequest.fromJson(req));
    }

    return reqs;
  }

}