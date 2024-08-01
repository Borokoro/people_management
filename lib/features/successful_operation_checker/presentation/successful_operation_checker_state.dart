part of 'successful_operation_checker_cubit.dart';

class SuccessfulOperationCheckerState extends Equatable {
  final bool operationSuccessful;
  const SuccessfulOperationCheckerState(this.operationSuccessful);

  @override
  List<Object> get props => [operationSuccessful];
}
