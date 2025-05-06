abstract class VolunteerReqEvent{}

class ApplyAsVolunteer extends VolunteerReqEvent{
  final String scribeReqId;

  ApplyAsVolunteer({required this.scribeReqId});
}

class CheckIfApplied extends VolunteerReqEvent{
  final String id;

  CheckIfApplied({required this.id});
}