import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_navigation_cubit.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationChosenScreen>(
      builder: (context, state) {
        return SafeArea(
          child: BottomAppBar(
            height: 72,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: TextButton.icon(
                    onPressed: () {
                      BlocProvider.of<BottomNavigationCubit>(context)
                          .changeScreen(state.chosenScreen, 0);
                    },
                    icon: Icon(
                      const IconData(0xe491, fontFamily: 'MaterialIcons'),
                      color: state.chosenScreen == 0 ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                    label: Text(
                      'Person',
                      style: TextStyle(
                        color:
                            state.chosenScreen == 0 ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 65),
                  child: TextButton.icon(
                    onPressed: () {
                      BlocProvider.of<BottomNavigationCubit>(context)
                          .changeScreen(state.chosenScreen, 1);
                    },
                    icon: Icon(
                      const IconData(0xe2eb, fontFamily: 'MaterialIcons'),
                      color: state.chosenScreen == 1 ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                    label: Text(
                      'Groups',
                      style: TextStyle(
                        color:
                            state.chosenScreen == 1 ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
