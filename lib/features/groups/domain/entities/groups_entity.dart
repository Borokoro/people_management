import 'package:equatable/equatable.dart';

class GroupsEntity extends Equatable {
  final int id;
  final String name;
  final List<dynamic> people;

  const GroupsEntity({
    required this.name,
    required this.people,
    required this.id,
  });

  @override
  List<Object> get props =>
      [name, people, id];
}
