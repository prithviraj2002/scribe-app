import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/review_model/review_model.dart';
import 'package:scribe/domain/repo/review_repo.dart';
import 'package:scribe/presentation/reviews/bloc/review_event.dart';
import 'package:scribe/presentation/reviews/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState>{
  ReviewRepo repo = getIt<ReviewRepo>();

  ReviewBloc(): super(InitialState()){
    on<GetReviews>((event, emit) async{
      emit(ReviewsLoadingState());

      try{
        List<ReviewModel> reviews = await repo.getScribeReviews();

        emit(ReviewsDataState(reviews: reviews));
      } catch(e){
        emit(ReviewsErrorState(errorMsg: e.toString()));
      }
    });
  }
}