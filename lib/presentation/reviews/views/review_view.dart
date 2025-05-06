import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/domain/model/review_model/review_model.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_bloc.dart';
import 'package:scribe/presentation/requests/bloc/student_bloc/student_event.dart';
import 'package:scribe/presentation/reviews/bloc/review_bloc.dart';
import 'package:scribe/presentation/reviews/bloc/review_event.dart';
import 'package:scribe/presentation/reviews/bloc/review_state.dart';
import 'package:scribe/presentation/reviews/components/common_review_tile.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  late ReviewBloc reviewBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    reviewBloc = context.read<ReviewBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.reviews),
      ),
      body: BlocConsumer<ReviewBloc, ReviewState>(
          builder: (BuildContext ctx, ReviewState state){
            if(state is ReviewsDataState){
              if(state.reviews.isEmpty){
                return const Center(child: Text("No reviews yet!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),));
              }
              else{
                return RefreshIndicator(
                  onRefresh: () async{
                    reviewBloc.add(GetReviews());
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (ctx, index){
                        ReviewModel review = state.reviews[index];
                        return BlocProvider(
                          create: (ctx) => StudentBloc()..add(GetStudentData(studentId: review.studentId)),
                            child: CommonReviewTile(
                              review: review,
                            )
                        );
                      },
                      separatorBuilder: (ctx, index){
                        return const SizedBox(height: 12,);
                      },
                      itemCount: state.reviews.length
                  ),
                );
              }
            }
            else if(state is ReviewsErrorState){
              return Center(child: Text("Couldn't get Reviews"));
            }
            else if(state is ReviewsLoadingState){
              return Center(child: CircularProgressIndicator());
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, ReviewState state){
            if(state is ReviewsErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          }
      ),
    );
  }
}
