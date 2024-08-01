part of 'groups_bloc.dart';

class GroupsEvent extends Equatable{
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class GetGroupsEvent extends GroupsEvent{
  const GetGroupsEvent();

  @override
  List<Object> get props => [];
}

class DeleteGroupEvent extends GroupsEvent{
  final int id;
  final BuildContext context;
  const DeleteGroupEvent({required this.id,required this.context});

  @override
  List<Object> get props => [id, context];
}

class InsertGroupEvent extends GroupsEvent{
  final GroupsModel group;
  final BuildContext context;
  const InsertGroupEvent({required this.group,required this.context});

  @override
  List<Object> get props => [group,context];
}

class UpdateGroupEvent extends GroupsEvent{
  final GroupsModel group;
  final BuildContext context;
  const UpdateGroupEvent({required this.group,required this.context});

  @override
  List<Object> get props => [group,context];
}

