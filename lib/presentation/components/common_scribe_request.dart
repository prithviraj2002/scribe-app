import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/presentation/components/common_long_button.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_bloc.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_bloc.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_event.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_bloc.dart';
import 'package:scribe/presentation/requests/bloc/volunteer_req_bloc/volunteer_req_events.dart';
import 'package:scribe/presentation/requests/views/request_detail_view.dart';

class CommonScribeRequest extends StatelessWidget {
  final ScribeRequest request;
  const CommonScribeRequest({
    required this.request,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240, width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(request.examName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              const SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(request.subject, style: TextStyle(color: Colors.black45, fontSize: 18),),
                  Text(" | ", style: TextStyle(color: Colors.black45, fontSize: 18),),
                  Text(request.board, style: TextStyle(color: Colors.black45, fontSize: 18),)
                ],
              ),
              const SizedBox(height: 12,),
              Text(
                "Date: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(request.date))}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              const SizedBox(height: 4,),
              Text("Requirement: ${request.language.toUpperCase()} Scribe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              const SizedBox(height: 20,),
              CommonLongButton(
                text: "View Details",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (ctx) => VolunteerReqBloc()..add(CheckIfApplied(id: request.id))),
                              BlocProvider(create: (ctx) => StudentBloc()..add(GetStudentData(studentId: request.studentId))),
                              BlocProvider.value(value: context.read<RequestBloc>()),
                            ],
                            child: RequestDetailView(request: request),
                          )
                      )
                  );
                },
                height: 32, fontSize: 16,
              ),
            ],
          ),
        ),
      )
    );
  }
}
