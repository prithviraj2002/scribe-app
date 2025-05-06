abstract class RegisterState{}

class InitialState extends RegisterState{}

class LoadingState extends RegisterState{}

class RegisterFailedState extends RegisterState{
  final String errorMsg;

  RegisterFailedState({required this.errorMsg});
}

class RegisterDoneState extends RegisterState{}

class ScribeExistsState extends RegisterState{}