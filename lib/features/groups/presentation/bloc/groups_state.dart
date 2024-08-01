part of 'groups_bloc.dart';

class GroupsState extends Equatable{
  final List<GroupsModel> data;

  const GroupsState({this.data = const []});

  @override
  List<Object> get props => [
    data,
  ];
}

class GroupsLoading extends GroupsState {
  const GroupsLoading();

  @override
  List<Object> get props => [];
}

class GroupsError extends GroupsState {
  final String message;
  const GroupsError({required this.message});

  @override
  List<Object> get props => [message];
}
