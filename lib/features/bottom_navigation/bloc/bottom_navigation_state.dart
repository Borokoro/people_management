part of 'bottom_navigation_cubit.dart';

class BottomNavigationChosenScreen extends Equatable {
  final int chosenScreen;
  const BottomNavigationChosenScreen(this.chosenScreen);

  @override
  List<Object> get props => [
        chosenScreen,
      ];
}
