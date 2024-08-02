part of 'people_bloc.dart';

class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object> get props => [];
}

class GetPeopleEvent extends PeopleEvent {
  const GetPeopleEvent();

  @override
  List<Object> get props => [];
}

class DeletePersonEvent extends PeopleEvent {
  final int id;
  final BuildContext context;
  const DeletePersonEvent({required this.id, required this.context});

  @override
  List<Object> get props => [id, context];
}

class InsertPersonEvent extends PeopleEvent {
  final PeopleModel person;
  final BuildContext context;
  const InsertPersonEvent({required this.person, required this.context});

  @override
  List<Object> get props => [person, context];
}

class UpdatePersonEvent extends PeopleEvent {
  final PeopleModel person;
  final BuildContext context;
  const UpdatePersonEvent({required this.person, required this.context});

  @override
  List<Object> get props => [person, context];
}
