import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/pages/app_pages.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/domain/model/scribe/gender_model.dart';
import 'package:scribe/domain/model/scribe/language_model.dart';
import 'package:scribe/presentation/components/common_long_button.dart';
import 'package:scribe/presentation/components/common_text_field.dart';
import 'package:scribe/presentation/register/bloc/register_bloc.dart';
import 'package:scribe/presentation/register/bloc/register_event.dart';
import 'package:scribe/presentation/register/bloc/register_state.dart';
import 'package:scribe/presentation/register/components/gender_dropdown.dart';
import 'package:scribe/presentation/register/components/lang_list.dart';
import 'package:scribe/presentation/register/cubit/gender_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = context.read<RegisterBloc>();
    registerBloc.add(ScribeExistsEvent());

    final langCubit = context.read<LanguageCubit>();
    final genderCubit = context.read<GenderCubit>();
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (BuildContext ctx, RegisterState state){
            if(state is InitialState){
              return Form(
                key: registerBloc.registerKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          // ImageSelector(cubit: context.read<ImagePickerCubit>()),
                          // const SizedBox(height: 20,),
                          Text(AppStrings.register, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 24,),
                          Text(AppStrings.name),
                          const SizedBox(height: 8,),
                          CommonTextField(
                              controller: registerBloc.name,
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
                                    controller: registerBloc.age,
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
                              controller: registerBloc.email,
                              textInputType: TextInputType.emailAddress,
                              hintText: ""
                          ),
                          const SizedBox(height: 12,),
                          Text(AppStrings.address),
                          const SizedBox(height: 8,),
                          CommonTextField(
                            showCounter: true,
                              controller: registerBloc.address,
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
                                    controller: registerBloc.city,
                                    hintText: ""
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CommonTextField(
                                    controller: registerBloc.pincode,
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
                              controller: registerBloc.contact,
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
                                text: AppStrings.done,
                                onTap: () {
                                  if(registerBloc.registerKey.currentState!.validate() && langCubit.state.isNotEmpty){
                                    registerBloc.add(
                                        ScribeRegister(
                                            gender: genderCubit.state,
                                            langKnown: langCubit.state
                                        )
                                    );
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
            else if(state is RegisterFailedState){
              return Center(child: Text("An error occurred!"));
            }
            else if(state is LoadingState){
              return Center(child: CircularProgressIndicator());
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, RegisterState state){
            if(state is ScribeExistsState){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (dynamic) => false);
            }
            else if(state is RegisterDoneState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Done!")));
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (dynamic) => false);
            }
            else if(state is RegisterFailedState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          }
      ),
    );
  }
}
