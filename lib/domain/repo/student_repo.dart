import 'package:flutter/material.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/data/db/scribe_api_service.dart';
import 'package:scribe/domain/model/student_model/student_model.dart';

class StudentRepo{
  ScribeApiService service = getIt<ScribeApiService>();

  Future<StudentModel> getStudent(String studentId) async{
   final String id = studentId.replaceAll("+", "%2B");
   debugPrint("Trying to call: $id");
   return await service.getStudent("?phone=$id");
  }
}