import 'package:scribe/domain/model/scribe/scribe_model.dart';

abstract class ProfileState{}

//State for getting scribe data.
class InitialState extends ProfileState{}

class ScribeDataLoadingState extends ProfileState{}

class ScribeDataState extends ProfileState{
  final ScribeModel scribe;

  ScribeDataState({required this.scribe});
}

class ScribeDataErrorState extends ProfileState{
  final String errorMsg;

  ScribeDataErrorState({required this.errorMsg});
}

class LogoutProfileLoading extends ProfileState{}

class LogoutProfileError extends ProfileState{
  final String errorMsg;

  LogoutProfileError({required this.errorMsg});
}

class LogoutProfileDone extends ProfileState{}

//Delete account states.
class DeleteAccountDone extends ProfileState{}

class DeleteAccountLoading extends ProfileState{}

class DeleteAccountErrorState extends ProfileState{
  final String errorMsg;

  DeleteAccountErrorState({required this.errorMsg});
}

//Update profile states.
class UpdateProfileLoading extends ProfileState{}

class UpdateProfileError extends ProfileState{
  final String errorMsg;

  UpdateProfileError({required this.errorMsg});
}

class UpdateProfileDone extends ProfileState{}