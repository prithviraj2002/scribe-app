import 'package:scribe/domain/model/student_model/student_model.dart';

abstract class StudentState{}

class InitialStudentState extends StudentState{}

class LoadingStudentData extends StudentState{}

class StudentDataError extends StudentState{
  final String errorMsg;

  StudentDataError({required this.errorMsg});
}

class StudentDataSuccess extends StudentState{
  final StudentModel student;

  StudentDataSuccess({required this.student});
}