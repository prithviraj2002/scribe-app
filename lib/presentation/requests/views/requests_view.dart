import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/presentation/components/common_scribe_request.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_bloc.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_event.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_state.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  late RequestBloc requestBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    requestBloc = context.read<RequestBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.requests),
      ),
      body: BlocConsumer<RequestBloc, RequestState>(
          builder: (BuildContext ctx, RequestState state){
            if(state is RequestDataState){
              List<ScribeRequest> requests = state.requests;
              List<ScribeRequest> appliedReqs = state.appliedReqs;
              if(requests.isEmpty){
                return const Center(child: Text("No scribe requests to show here, check board", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),));
              }
              else if(appliedReqs.isNotEmpty && requests.isNotEmpty){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: RefreshIndicator(
                    onRefresh: () async{
                      requestBloc.add(GetRequests());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Upcoming Requests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                            TextButton(onPressed: () {
                                requestBloc.add(GetRequests());
                              }, child: Text("Refresh"))
                          ],
                        ),
                        const SizedBox(height: 12,),
                        SizedBox(
                          height: 240,
                          child: RefreshIndicator(
                            onRefresh: () async{
                              requestBloc.add(GetRequests());
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index){
                                return BlocProvider.value(
                                  value: requestBloc,
                                  child: CommonScribeRequest(
                                    request: requests[index],
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return const SizedBox(width: 12,);
                              },
                              itemCount: requests.length,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Applied Requests", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                            TextButton(onPressed: () {
                            requestBloc.add(GetRequests());
                            }, child: Text("Refresh"))
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (ctx, index){
                              return BlocProvider.value(
                                value: requestBloc,
                                child: CommonScribeRequest(
                                  request: appliedReqs[index],
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const SizedBox(height: 12,);
                            },
                            itemCount: appliedReqs.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              else if(appliedReqs.isEmpty && requests.isNotEmpty){
                return RefreshIndicator(
                  onRefresh: () async{
                    requestBloc.add(GetRequests());
                  },
                  child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                      itemBuilder: (ctx, index){
                        return CommonScribeRequest(
                          request: requests[index],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(height: 12,);
                      },
                      itemCount: requests.length,
                  ),
                );
              }
              else{
                return const Center(child: Text("Something went wrong!"));
              }
            }
            else if(state is RequestLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is RequestErrorState){
              return const Center(
                  child: Text("Couldn't get scribe requests",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),));
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, RequestState state){
            if(state is RequestErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          }
      ),
    );
  }
}
