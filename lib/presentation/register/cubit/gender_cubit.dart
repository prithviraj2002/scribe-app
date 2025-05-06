import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/domain/model/scribe/gender_model.dart';
import 'package:scribe/domain/model/scribe/language_model.dart';

class GenderCubit extends Cubit<Gender>{
  GenderCubit(): super(Gender.female);

  void selectGender(Gender gender){
    emit(gender);
  }
}

class LanguageCubit extends Cubit<List<Language>>{
  LanguageCubit(): super([]);

  void addLang(Language lang){
    emit([...state, lang]);
  }

  void removeLang(Language lang){
    emit(state.where((t) => t != lang).toList());
  }

  void selectAll(){
    emit([...Language.values]);
  }

  void unselectAll(){
    emit([]);
  }

  void setLangList(List<Language> lang){
    emit(lang);
  }
}