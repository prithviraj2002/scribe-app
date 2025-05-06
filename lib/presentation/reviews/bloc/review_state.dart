import 'package:scribe/domain/model/review_model/review_model.dart';

abstract class ReviewState{}

class InitialState extends ReviewState{}

class ReviewsLoadingState extends ReviewState{}

class ReviewsDataState extends ReviewState{
  final List<ReviewModel> reviews;

  ReviewsDataState({required this.reviews});
}

class ReviewsErrorState extends ReviewState{
  final String errorMsg;

  ReviewsErrorState({required this.errorMsg});
}