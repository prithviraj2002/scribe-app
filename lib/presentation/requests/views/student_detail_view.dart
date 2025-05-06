import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_bloc.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_event.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_state.dart';

class StudentDetailView extends StatefulWidget {
  final String studentId;
  const StudentDetailView({required this.studentId, super.key});

  @override
  State<StudentDetailView> createState() => _StudentDetailViewState();
}

class _StudentDetailViewState extends State<StudentDetailView> {
  
  late StudentBloc studentBloc;
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    studentBloc = context.read<StudentBloc>();
    studentBloc.add(GetStudentData(studentId: widget.studentId));
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.studentDetails),
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
          builder: (BuildContext ctx, StudentState state){
            if(state is StudentDataSuccess){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    Text("Student name:"),
                    const SizedBox(height: 12,),
                    Text(state.student.name)
                  ],
                ),
              );
            }
            else if(state is LoadingStudentData){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is StudentDataError){
              return Center(child: Text(state.errorMsg));
            }
            else{
              return const Center(child: Text("No state detected"),);
            }
          }
      ),
    );
  }
}
