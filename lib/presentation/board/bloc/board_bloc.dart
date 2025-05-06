import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/domain/repo/requests_repo.dart';
import 'package:scribe/presentation/board/bloc/board_event.dart';
import 'package:scribe/presentation/board/bloc/board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState>{
  RequestsRepo repo = getIt<RequestsRepo>();

  BoardBloc(): super(InitialState()){
    on<GetBoardReqEvent>((event, emit) async{
      emit(BoardDataLoading());
      try{
        List<ScribeRequest> completedReqs = await repo.getCompletedReqs();
        List<ScribeRequest> ongoingReqs = await repo.getOngoingScribeReq();

        emit(BoardReqData(ongoingRequests: ongoingReqs.reversed.toList(), completedRequests: completedReqs.reversed.toList()));
      } catch(e){
        emit(BoardDataError(errorMsg: e.toString()));
      }
    });
  }
}