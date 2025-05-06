import 'package:flutter/material.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/domain/model/scribe/language_model.dart';
import 'package:scribe/presentation/register/components/lang_chip.dart';
import 'package:scribe/presentation/register/cubit/gender_cubit.dart';

class LangList extends StatelessWidget {
  final LanguageCubit cubit;
  const LangList({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index){
                  return LangChip(
                      cubit: cubit,
                      language: Language.values[index]
                  );
                },
                separatorBuilder: (ctx, index){
                  return const SizedBox(width: 12,);
                },
                itemCount: Language.values.length
            ),
          ),
          Row(
            children: [
              Text(AppStrings.selectAll),
              const SizedBox(width: 4,),
              Checkbox(
                  value: cubit.state.contains(Language.hindi) && cubit.state.contains(Language.gujarati) && cubit.state.contains(Language.english),
                  onChanged: (bool? value){
                    if(value != null){
                      if(value){
                        cubit.selectAll();
                      }
                      else{
                        cubit.unselectAll();
                      }
                    }
                    else{
                      cubit.unselectAll();
                    }
                  }
              )
            ],
          )
        ],
      ),
    );
  }
}
