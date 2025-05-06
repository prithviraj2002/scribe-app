abstract class VolunteerReqState{}

class InitialState extends VolunteerReqState{}

class AppliedAsVolunteer extends VolunteerReqState{}

class NotAppliedAsVolunteer extends VolunteerReqState{}

class VolunteerReqLoading extends VolunteerReqState{}

class VolunteerReqSuccess extends VolunteerReqState{}

class VolunteerReqError extends VolunteerReqState{
  final String errorMsg;

  VolunteerReqError({required this.errorMsg});
}