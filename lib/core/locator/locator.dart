import 'package:get_it/get_it.dart';
import 'package:scribe/data/client/http_client.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/domain/repo/auth_repo.dart';
import 'package:scribe/domain/repo/requests_repo.dart';
import 'package:scribe/domain/repo/review_repo.dart';
import 'package:scribe/domain/repo/scribe_repo.dart';
import 'package:scribe/domain/repo/student_repo.dart';
import 'package:scribe/domain/repo/volunteer_req_repo.dart';

final getIt = GetIt.instance;

void setupLocator(){
  getIt.registerSingleton(ScribeClient());
  getIt.registerSingleton(ScribeApiService());

  getIt.registerSingleton(ScribeRepo());
  getIt.registerSingleton(ReviewRepo());
  getIt.registerSingleton(RequestsRepo());
  getIt.registerSingleton(AuthRepo());

  getIt.registerLazySingleton(() => StudentRepo());
  getIt.registerLazySingleton(() => VolunteerReqRepo());
}
