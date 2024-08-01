import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'successful_operation_checker_state.dart';

class SuccessfulOperationCheckerCubit extends Cubit<SuccessfulOperationCheckerState> {
  SuccessfulOperationCheckerCubit() : super(const SuccessfulOperationCheckerState(true));

  void operationUnSuccessful(){
    emit(const SuccessfulOperationCheckerState(false));
  }

  void operationSuccessful(){
    emit(const SuccessfulOperationCheckerState(true));
  }
}
