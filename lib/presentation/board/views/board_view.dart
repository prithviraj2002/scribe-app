import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/presentation/board/bloc/board_bloc.dart';
import 'package:scribe/presentation/board/bloc/board_event.dart';
import 'package:scribe/presentation/board/bloc/board_state.dart';
import 'package:scribe/presentation/components/common_scribe_request.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  late BoardBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bloc = context.read<BoardBloc>();
    bloc.add(GetBoardReqEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request board"),
      ),
      body: BlocBuilder<BoardBloc, BoardState>(
          builder: (BuildContext ctx, BoardState state){
            if(state is BoardDataError){
              return const Center(child: Text("An error occurred"));
            }
            else if(state is BoardDataLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is BoardReqData){
              List<ScribeRequest> ongoingReqs = state.ongoingRequests;
              List<ScribeRequest> completedReqs = state.completedRequests;

              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ongoing requests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                      Text("Requests where you are selected as scribe by the student, will be visible here", style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 12,),
                      ongoingReqs.isNotEmpty
                          ? SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, int index) {
                            return CommonScribeRequest(
                              request: ongoingReqs[index],
                            );
                          },
                          separatorBuilder: (
                              BuildContext ctx,
                              int index,
                              ) {
                            return const SizedBox(width: 12);
                          },
                          itemCount: ongoingReqs.length,
                        ),
                      )
                          : const Center(
                        child: Text(
                          "No ongoing requests",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text("Completed Requests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                      Text("Requests completed by you, will be visible here", style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 12,),
                      completedReqs.isNotEmpty
                          ? SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, int index) {
                            return CommonScribeRequest(
                              request: completedReqs[index],
                            );
                          },
                          separatorBuilder: (
                              BuildContext ctx,
                              int index,
                              ) {
                            return const SizedBox(width: 12);
                          },
                          itemCount: completedReqs.length,
                        ),
                      )
                          : const Center(
                        child: Text(
                          "No completed requests",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else{
              return const Center(child: Text("Something went wrong"));
            }
          }
      ),
    );
  }
}
