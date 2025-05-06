import 'package:bloc/bloc.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/repo/volunteer_req_repo.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_events.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_states.dart';

class VolunteerReqBloc extends Bloc<VolunteerReqEvent, VolunteerReqState>{
  VolunteerReqRepo volunteerRepo = getIt<VolunteerReqRepo>();

  VolunteerReqBloc(): super(InitialState()){

    on<CheckIfApplied>((event, emit) async{
      bool hasApplied = await volunteerRepo.checkIfApplied(event.id);

      if(hasApplied){
        emit(AppliedAsVolunteer());
      }
      else{
        emit(NotAppliedAsVolunteer());
      }
    });

    on<ApplyAsVolunteer>((event, emit) async{
      emit(VolunteerReqLoading());

      try{
        await volunteerRepo.applyToScribeReq(event.scribeReqId);

        emit(VolunteerReqSuccess());
      } catch(e){
        emit(VolunteerReqError(errorMsg: e.toString()));
      }
    });
  }
}