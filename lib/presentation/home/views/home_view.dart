import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/colors/app_colors.dart';
import 'package:scribe/core/strings/app_strings.dart';
import 'package:scribe/presentation/board/bloc/board_bloc.dart';
import 'package:scribe/presentation/board/views/board_view.dart';
import 'package:scribe/presentation/home/cubit/tab_cubit.dart';
import 'package:scribe/presentation/profile/bloc/profile_bloc.dart';
import 'package:scribe/presentation/profile/view/profile_view.dart';
import 'package:scribe/presentation/requests/bloc/req_bloc/requests_bloc.dart';
import 'package:scribe/presentation/requests/views/requests_view.dart';
import 'package:scribe/presentation/reviews/bloc/review_bloc.dart';
import 'package:scribe/presentation/reviews/views/review_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TabCubit tabCubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    tabCubit = context.read<TabCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabCubit, int>(
        builder: (BuildContext ctx, int tab){
          if(tab == 0){
            return BlocProvider.value(
              value: context.read<RequestBloc>(),
                child: RequestsView()
            );
          }
          else if(tab == 1){
            return BlocProvider.value(
              value: context.read<BoardBloc>(),
                child: BoardView());
          }
          else if(tab == 2){
            return BlocProvider.value(
              value: context.read<ReviewBloc>(),
                child: ReviewView());
          }
          else if(tab == 3){
            return BlocProvider.value(
              value: context.read<ProfileBloc>(),
                child: ProfileView());
          }
          else{
            return BlocProvider.value(
                value: context.read<ProfileBloc>(),
                child: ProfileView());
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<TabCubit, int>(
        builder: (BuildContext ctx, int page){
          return BottomNavigationBar(
            currentIndex: page,
              onTap: (int value){
                tabCubit.setTab(value);
              },
              selectedLabelStyle: TextStyle(color: AppColors.primaryColor),
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: AppStrings.requests
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.date_range_sharp),
                    label: "Dashboard"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star_border),
                    label: AppStrings.reviews
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: AppStrings.profile
                ),
              ]
          );
        }
      ),
    );
  }
}
