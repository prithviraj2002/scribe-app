import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/domain/model/scribe/gender_model.dart';
import 'package:scribe/domain/model/scribe/language_model.dart';
import 'package:scribe/presentation/components/common_long_button.dart';
import 'package:scribe/presentation/components/common_text_field.dart';
import 'package:scribe/presentation/profile/bloc/profile_bloc.dart';
import 'package:scribe/presentation/profile/bloc/profile_event.dart';
import 'package:scribe/presentation/profile/bloc/profile_state.dart';
import 'package:scribe/presentation/register/components/gender_dropdown.dart';
import 'package:scribe/presentation/register/components/lang_list.dart';
import 'package:scribe/presentation/register/cubit/gender_cubit.dart';

class PersonalDetailView extends StatelessWidget {
  const PersonalDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    final genderCubit = context.read<GenderCubit>();
    final langCubit = context.read<LanguageCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.personalDetails),),
      body: BlocConsumer<ProfileBloc, ProfileState>(
          builder: (BuildContext ctx, ProfileState state){
            if(state is ScribeDataState){
              genderCubit.selectGender(state.scribe.gender);
              langCubit.setLangList(state.scribe.langKnown);
              return Form(
                key: profileBloc.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Text(AppStrings.name),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              controller: profileBloc.name,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.age)),
                              const SizedBox(width: 16,),
                              Expanded(child: Text(AppStrings.gender)),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                    controller: profileBloc.age,
                                    textInputType: TextInputType.number,
                                    hintText: ""
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black45
                                      ),
                                      borderRadius: const BorderRadius. all(Radius. circular(4.0))
                                  ),
                                  child: Center(
                                    child: BlocBuilder<GenderCubit, Gender>(
                                      bloc: genderCubit,
                                      builder: (BuildContext ctx, Gender gender) {
                                        return GenderDropdown(cubit: genderCubit);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12,),
                          Text(AppStrings.email),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              controller: profileBloc.email,
                              textInputType: TextInputType.emailAddress,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Text(AppStrings.address),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              showCounter: true,
                              controller: profileBloc.address,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            children: [
                              Expanded(child: Text(AppStrings.city)),
                              const SizedBox(width: 16,),
                              Expanded(child: Text(AppStrings.pincode)),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                    controller: profileBloc.city,
                                    hintText: ""
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CommonTextField(
                                    controller: profileBloc.pincode,
                                    maxLength: 6,
                                    textInputType: TextInputType.number,
                                    hintText: ""
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12,),
                          Text(AppStrings.contact),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              controller: profileBloc.contact,
                              textInputType: TextInputType.phone,
                              hintText: ""
                          ),
                          const SizedBox(height: 20,),
                          Text(AppStrings.langKnown, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 12,),
                          BlocBuilder<LanguageCubit, List<Language>>(
                              bloc: langCubit,
                              builder: (BuildContext ctx, List<Language> l){
                                return LangList(cubit: langCubit);
                              }
                          ),
                          const SizedBox(height: 12,),
                          Center(
                            child: CommonLongButton(
                                text: AppStrings.update,
                                onTap: () {
                                  if(profileBloc.formKey.currentState!.validate()){
                                    profileBloc.add(UpdateProfile(
                                        genderCubit: genderCubit,
                                        languageCubit: langCubit
                                    ));
                                  }
                                }
                            ),
                          ),
                          const SizedBox(height: 24,),
                        ],
                      ),
                    ),
                  )
              );
            }
            else if(state is ScribeDataErrorState){
              return const Center(child: Text("Couldn't get scribe data"));
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, ProfileState state){
            if(state is UpdateProfileLoading){
              showAboutDialog(
                  context: context,
                children: [
                  Center(child: CircularProgressIndicator())
                ]
              );
            }
            else if(state is UpdateProfileDone){
              Navigator.pop(context);
              showAboutDialog(
                  context: context,
                applicationName: "Done!",
                children: [
                  Center(child: Icon(Icons.check, color: Colors.green, size: 24,))
                ]
              );
            }
            else if(state is UpdateProfileError){
              Navigator.pop(context);
              showAboutDialog(
                  context: context,
                  applicationName: "Error!",
                  children: [
                    Center(child: Icon(Icons.cancel_outlined, color: Colors.red, size: 24,))
                  ]
              );
            }
          }
      ),
    );
  }
}
