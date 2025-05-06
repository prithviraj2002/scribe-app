import 'package:bloc/bloc.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/domain/repo/requests_repo.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_event.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState>{
  RequestsRepo repo = getIt<RequestsRepo>();
  List<ScribeRequest> reqs = [];
  List<ScribeRequest> appliedReqs = [];

  RequestBloc(): super(InitialState()){
    on<GetRequests>((event, emit) async{
      emit(RequestLoadingState());

      try{
        reqs = await repo.getScribeReq();

        appliedReqs = await repo.getAppliedReqs();

        reqs.removeWhere((ScribeRequest req) => appliedReqs.contains(req));
        emit(RequestDataState(requests: reqs.reversed.toList(), appliedReqs: appliedReqs.reversed.toList()));
      } catch(e){
        emit(RequestErrorState(errorMsg: e.toString()));
      }
    });
  }

  Future<List<ScribeRequest>> getCompletedScribeReq() async{
    return await repo.getCompletedReqs();
  }
}