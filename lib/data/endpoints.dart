class Endpoints{
  static const String baseUrl = "http://10.0.2.2:8000/";

  //user endpoints
  static const String setUserRole = "user/setRole";
  static const String getUserRole = "user/getUserRole";

  //scribe endpoints
  static const String scribe = "scribe/";
  static const String checkScribe = "scribe/check/";

  //review endpoints
  static const String review = "review/";

  //request endpoints
  static const String scribeReq = "scribeReq/";
  static const String scribeReqByScribe = "scribeReq/scribe/";

  //student endpoint
  static const String student = 'student';

  //file upload endpoint
  static const String upload = 'upload';

  //volunteer request endpoint
  static const String volunteer = "volunteer/";
  static const String createReq = "volunteer/createReq/";
  static const String getReqById = "volunteer/getReqById/";
  static const String appliedVolunteer = "volunteer/applied";
  static const String checkApplied = "volunteer/checkApplied";
}