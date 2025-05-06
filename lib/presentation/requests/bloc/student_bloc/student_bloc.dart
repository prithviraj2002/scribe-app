import 'package:bloc/bloc.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/student_model/student_model.dart';
import 'package:scribe/domain/repo/student_repo.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_event.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState>{

  StudentRepo studentRepo = getIt<StudentRepo>();

  StudentBloc(): super(InitialStudentState()){
    on<GetStudentData>((event, emit) async{
      emit(LoadingStudentData());

      try{
        StudentModel student = await studentRepo.getStudent(event.studentId);

        emit(StudentDataSuccess(student: student));
      } catch(e){
        emit(StudentDataError(errorMsg: e.toString()));
      }
    });
  }
}