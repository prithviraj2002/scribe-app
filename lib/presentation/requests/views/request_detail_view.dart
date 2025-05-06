import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/domain/model/scribe/gender_model.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/presentation/components/common_long_button.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_bloc.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_event.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_bloc.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_state.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_bloc.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_events.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_states.dart';
import 'package:intl/intl.dart';

class RequestDetailView extends StatefulWidget {
  final ScribeRequest request;
  const RequestDetailView({required this.request, super.key});

  @override
  State<RequestDetailView> createState() => _RequestDetailViewState();
}

class _RequestDetailViewState extends State<RequestDetailView> {
  late VolunteerReqBloc bloc;
  late StudentBloc studentBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<VolunteerReqBloc>();
    studentBloc = context.read<StudentBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text("Student Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
              const SizedBox(height: 12,),
              BlocConsumer<StudentBloc, StudentState>(
                  builder: (BuildContext context, StudentState state){
                    if(state is LoadingStudentData){
                      return Center(child: const CircularProgressIndicator());
                    }
                    else if(state is StudentDataError){
                      return Center(child: const Text("Couldn't get student details!"));
                    }
                    else if(state is StudentDataSuccess){
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 120,
                        child: Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20,),
                              Container(
                                  height: 75, width: 75,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all()
                                  ),
                                  child: Center(child: Icon(Icons.person, size: 50,))
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.student.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                  Text("${state.student.age} years old, ${getStringFromGender(state.student.gender)}", style: TextStyle(fontSize: 16),),
                                  Text("Lives in ${state.student.city}", style: TextStyle(fontSize: 16),),
                                ],
                              ),
                              const SizedBox(width: 20,),
                            ],
                          ),
                        ),
                      );
                    }
                    else{
                      return const Center(child: Text("Something went wrong!"),);
                    }
                  },
                listener: (BuildContext ctx, StudentState state){
                    if(state is StudentDataError){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Couldn't get student details!")));
                    }
                },
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text("Exam Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
              const SizedBox(height: 12,),
              BlocListener<VolunteerReqBloc, VolunteerReqState>(
                listener: (BuildContext context, VolunteerReqState state) {
                  if(state is VolunteerReqError){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                  else if(state is VolunteerReqLoading){
                    showAboutDialog(
                        context: context,
                      applicationName: "Applying...",
                      children: [
                        Center(child: CircularProgressIndicator())
                      ]
                    );
                  }
                  else if(state is VolunteerReqSuccess){
                    Navigator.pop(context);
                    context.read<RequestBloc>().add(GetRequests());
                    showAboutDialog(
                        context: context,
                        applicationName: "Success",
                        children: [
                          Center(child: Icon(Icons.check, color: Colors.green, size: 36,))
                        ]
                    );

                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12,),
                            ListTile(
                              title: Text("Exam name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text(widget.request.examName, style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Subject", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text(widget.request.subject, style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Language", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text(widget.request.language, style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.request.date)), style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Time", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text(widget.request.time, style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Duration", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text("${widget.request.duration} hours", style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Exam center", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text("${widget.request.address}, ${widget.request.city}, ${widget.request.pincode}", style: TextStyle(fontSize: 18),),
                            ),
                            ListTile(
                              title: Text("Board", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              subtitle: Text(widget.request.board, style: TextStyle(fontSize: 18),),
                            ),
                            const SizedBox(height: 12,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.request.isOpen ?
      BlocBuilder<VolunteerReqBloc, VolunteerReqState>(
        builder: (BuildContext ctx, VolunteerReqState state) {
          if (state is AppliedAsVolunteer || state is VolunteerReqSuccess){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonLongButton(
                  text: "Applied",
                  onTap: () {

                  }
              ),
            );
          }
          else{
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonLongButton(
                  text: "Apply",
                  onTap: () {
                    bloc.add(ApplyAsVolunteer(scribeReqId: widget.request.id));
                  }
              ),
            );
          }
        }
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CommonLongButton(
            text: "No longer accepting responses",
            onTap: () {

            }
        ),
      ),
    );
  }
}
