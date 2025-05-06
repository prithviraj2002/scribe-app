import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/scribe/scribe_model.dart';
import 'package:scribe/domain/repo/scribe_repo.dart';
import 'package:scribe/presentation/register/bloc/register_event.dart';
import 'package:scribe/presentation/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  ScribeRepo repo = getIt<ScribeRepo>();

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController contact = TextEditingController();

  final registerKey = GlobalKey<FormState>();

  RegisterBloc(): super(InitialState()){

    on<ScribeRegister>((event, emit) async{
      emit(LoadingState());
      final response = await repo.createScribe(
          ScribeModel(
            name: name.text,
            email: email.text,
            gender: event.gender,
            address: address.text,
            city: city.text,
            pincode: pincode.text,
            age: int.parse(age.text),
            contact: contact.text,
            langKnown: event.langKnown,
          )
      );

      if(response != null && response['data'] != null){
        emit(RegisterDoneState());
      }
      else{
        emit(RegisterFailedState(errorMsg: "An error occurred!"));
      }
    });

    on<ScribeExistsEvent>((event, emit) async{
      emit(LoadingState());
      bool exists = await repo.checkScribe();

      if(exists){
        emit(ScribeExistsState());
      }
      else{
        emit(InitialState());
      }
    });
  }
}