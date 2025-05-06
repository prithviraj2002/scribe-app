import 'package:scribe/domain/model/scribe_req/scribe_req.dart';

abstract class BoardState{}

class InitialState extends BoardState{}

class BoardDataLoading extends BoardState{}

class BoardDataError extends BoardState{
  final String errorMsg;

  BoardDataError({required this.errorMsg});
}

class BoardReqData extends BoardState{
  final List<ScribeRequest> ongoingRequests;
  final List<ScribeRequest> completedRequests;

  BoardReqData({required this.ongoingRequests, required this.completedRequests});
}