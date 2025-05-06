import 'package:scribe/domain/model/scribe/gender_model.dart';
import 'package:scribe/domain/model/scribe/language_model.dart';

abstract class RegisterEvent{}

class ScribeRegister extends RegisterEvent{
  final Gender gender; final List<Language> langKnown;

  ScribeRegister({required this.gender, required this.langKnown});
}

class ScribeExistsEvent extends RegisterEvent{}
