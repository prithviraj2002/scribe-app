import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/domain/model/review_model/review_model.dart';

class ReviewRepo{
  ScribeApiService service = getIt<ScribeApiService>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<ReviewModel>> getScribeReviews() async{
    List<ReviewModel> reviews = [];
    String? phone = auth.currentUser!.phoneNumber;
    if(auth.currentUser != null && phone!.isNotEmpty){
      final response = await service.getScribeReviews(phone);

      for(Map<String, dynamic> review in response['data']){
        reviews.add(ReviewModel.fromJson(review));
      }

      return reviews;
    }
    else{
      debugPrint("Could not get user id");
      throw Exception("Could not get user id!");
    }
  }
}