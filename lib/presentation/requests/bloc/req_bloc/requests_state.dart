import 'package:scribe/domain/model/scribe_req/scribe_req.dart';

abstract class RequestState{}

class InitialState extends RequestState{}

class RequestDataState extends RequestState{
  final List<ScribeRequest> requests;
  final List<ScribeRequest> appliedReqs;

  RequestDataState({required this.requests, required this.appliedReqs});
}

class RequestErrorState extends RequestState{
  final String errorMsg;

  RequestErrorState({required this.errorMsg});
}

class RequestLoadingState extends RequestState{}

