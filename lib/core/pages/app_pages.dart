import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/presentation/auth/bloc/auth_bloc.dart';
import 'package:scribe/presentation/auth/cubit/timer_cubit.dart';
import 'package:scribe/presentation/auth/view/phone_view.dart';
import 'package:scribe/presentation/board/bloc/board_bloc.dart';
import 'package:scribe/presentation/board/bloc/board_event.dart';
import 'package:scribe/presentation/home/cubit/tab_cubit.dart';
import 'package:scribe/presentation/home/views/home_view.dart';
import 'package:scribe/presentation/profile/bloc/profile_bloc.dart';
import 'package:scribe/presentation/profile/bloc/profile_event.dart';
import 'package:scribe/presentation/register/bloc/register_bloc.dart';
import 'package:scribe/presentation/register/cubit/gender_cubit.dart';
import 'package:scribe/presentation/register/cubit/image_picker_cubit.dart';
import 'package:scribe/presentation/register/views/register_view.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_bloc.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_event.dart';
import 'package:scribe/presentation/reviews/bloc/review_bloc.dart';
import 'package:scribe/presentation/reviews/bloc/review_event.dart';
import 'package:scribe/presentation/splash/bloc/splash_bloc.dart';
import 'package:scribe/presentation/splash/view/splash_view.dart';

class AppRoutes {
  static const String home = "/home";
  static const String splash = "/";
  static const String phone = "/phone";
  static const String register = "/register";
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.phone:
      (ctx) => MultiBlocProvider(
        providers: [
            BlocProvider(create: (ctx) => AuthBloc(),),
            BlocProvider(create: (ctx) => TimerCubit(),),
        ], child: PhoneView()
      ),
  AppRoutes.home:
      (ctx) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => TabCubit()),
            BlocProvider(create: (ctx) => RequestBloc()..add(GetRequests())),
            BlocProvider(create: (ctx) => ReviewBloc()..add(GetReviews())),
            BlocProvider(create: (ctx) => BoardBloc()..add(GetBoardReqEvent())),
            BlocProvider(create: (ctx) => ProfileBloc()..add(GetScribeData())),
          ],
          child: HomeView()
      ),
  AppRoutes.register:
      (ctx) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => RegisterBloc()),
            BlocProvider(create: (ctx) => GenderCubit()),
            BlocProvider(create: (ctx) => LanguageCubit()),
            BlocProvider(create: (ctx) => ImagePickerCubit()),
          ],
          child: RegisterView()
      ),
  AppRoutes.splash:
      (ctx) => BlocProvider(
          create: (ctx) => SplashBloc(),
          child: SplashView()
      ),
};
