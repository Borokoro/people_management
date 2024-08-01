import 'package:flutter/material.dart';
import 'package:people_managment/features/bottom_navigation/bloc/bottom_navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_managment/features/bottom_navigation/widgets/bottom_navigation_widget.dart';
import 'package:people_managment/features/skeleton/presentation/widgets/skeleton_widgets.dart';

import '../../groups/presentation/pages/groups_screen.dart';
import '../../people/presentation/pages/people_screen.dart';

List<Widget> pages= const[
  PeopleScreen(),
  GroupsScreen(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit,BottomNavigationChosenScreen>(
      builder: (context, state){
        return Scaffold(
          appBar: appBarSkeleton(context, state.chosenScreen),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: const BottomNavigationWidget(),
          body: SafeArea(
            child: pages[state.chosenScreen],
          ),
        );
      },
    );
  }
}
