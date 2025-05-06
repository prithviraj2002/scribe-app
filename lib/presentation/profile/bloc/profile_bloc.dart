import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribe/core/locator/locator.dart';
import 'package:scribe/domain/model/scribe/scribe_model.dart';
import 'package:scribe/domain/repo/scribe_repo.dart';
import 'package:scribe/presentation/profile/bloc/profile_event.dart';
import 'package:scribe/presentation/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  ScribeRepo repo = getIt<ScribeRepo>();
  FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController contact = TextEditingController();

  void setValues(ScribeModel model){
    name.value = TextEditingValue(text: model.name);
    age.value = TextEditingValue(text: model.age.toString());
    email.value = TextEditingValue(text: model.email);
    city.value = TextEditingValue(text: model.city);
    address.value = TextEditingValue(text: model.address);
    pincode.value = TextEditingValue(text: model.pincode);
    contact.value = TextEditingValue(text: model.contact);
  }

  ProfileBloc(): super(InitialState()){
    on<GetScribeData>((event, emit) async{
      emit(ScribeDataLoadingState());

      try{
        final ScribeModel model = await repo.getScribe();

        setValues(model);
        emit(ScribeDataState(scribe: model));
      } catch(e){
        emit(ScribeDataErrorState(errorMsg: e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async{
      emit(UpdateProfileLoading());

      try{
        await repo.updateScribe(
            ScribeModel(
                name: name.text,
                email: email.text,
                gender: event.genderCubit.state,
                address: address.text,
                city: city.text,
                pincode: pincode.text,
                age: int.parse(age.text),
                contact: contact.text,
                langKnown: event.languageCubit.state
            ).toMap()
        );
        emit(UpdateProfileDone());
        add(GetScribeData());
      } catch(e){
        emit(UpdateProfileError(errorMsg: e.toString()));
      }
    });

    on<DeleteProfile>((event, emit) async{
      emit(DeleteAccountLoading());

      try{
        await logout();
        await delFirebaseAccount();
        await repo.delScribe();

        emit(DeleteAccountDone());
      } catch(e){
        emit(DeleteAccountErrorState(errorMsg: e.toString()));
      }
    });

    on<Logout>((event, emit) async{
      emit(LogoutProfileLoading());
      try{
        await logout();

        emit(LogoutProfileDone());
      } catch(e){
        emit(LogoutProfileError(errorMsg: e.toString()));
      }
    });
  }

  Future<void> logout() async{
    await auth.signOut();
  }

  Future<void> delFirebaseAccount() async{
    await auth.currentUser!.delete();
  }
}