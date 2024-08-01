part of 'people_bloc.dart';

class PeopleState extends Equatable{
  final List<PeopleModel> data;

  const PeopleState({this.data = const []});

  @override
  List<Object> get props => [
    data,
  ];
}

class PeopleLoading extends PeopleState {
  const PeopleLoading();

  @override
  List<Object> get props => [];
}

class PeopleError extends PeopleState {
  final String message;
  const PeopleError({required this.message});

  @override
  List<Object> get props => [message];
}
