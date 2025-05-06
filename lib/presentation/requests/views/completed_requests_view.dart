import 'package:flutter/material.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/scribe_req/scribe_req.dart';
import 'package:scribe/domain/repo/requests_repo.dart';
import 'package:scribe/presentation/components/common_scribe_request.dart';

class CompletedRequestsView extends StatelessWidget {
  const CompletedRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Requests"),
      ),
      body: FutureBuilder<List<ScribeRequest>>(
          future: getIt<RequestsRepo>().getCompletedReqs(),
          builder: (BuildContext ctx, AsyncSnapshot<List<ScribeRequest>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return const Center(child: Text("No completed requests yet!"));
            }
            else if(snapshot.hasData){
              List<ScribeRequest> reqs = snapshot.data!;
              if(reqs.isNotEmpty){
                return ListView.separated(
                    itemBuilder: (BuildContext ctx, int index){
                      return CommonScribeRequest(request: reqs[index]);
                    },
                    separatorBuilder: (BuildContext ctx, int index) {
                      return const SizedBox(height: 12,);
                    },
                    itemCount: reqs.length);
              }
              else if(reqs.isEmpty){
                return const Center(child: Text("No completed requests yet!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),);
              }
              else{
                return Container();
              }
            }
            else{
              return const Center(child: Text("Something went wrong!", style: TextStyle(fontWeight: FontWeight.bold),));
            }
          }
      ),
    );
  }
}
