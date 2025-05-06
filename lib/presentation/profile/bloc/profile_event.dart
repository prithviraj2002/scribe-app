import 'package:scribe/presentation/register/cubit/gender_cubit.dart';

abstract class ProfileEvent{}

class GetScribeData extends ProfileEvent{}

class DeleteProfile extends ProfileEvent{}

class Logout extends ProfileEvent{}

class UpdateProfile extends ProfileEvent{
  final GenderCubit genderCubit;
  final LanguageCubit languageCubit;

  UpdateProfile({required this.genderCubit, required this.languageCubit});
}
