import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationChosenScreen> {
  BottomNavigationCubit() : super(const BottomNavigationChosenScreen(0));

  void changeScreen(int screenInitial, int chosenScreen){
    if (screenInitial != chosenScreen){
      emit(BottomNavigationChosenScreen(chosenScreen));
    }
  }
}
