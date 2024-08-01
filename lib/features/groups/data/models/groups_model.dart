import 'package:people_managment/features/groups/domain/entities/groups_entity.dart';
import 'package:people_managment/features/people/domain/entities/people_entity.dart';
import 'package:people_managment/core/constants/constants.dart' as c;

class GroupsModel extends GroupsEntity {
  const GroupsModel({
    required super.name,
    required super.people,
    required super.id,
  });

  factory GroupsModel.fromDatabase(Map<String, dynamic> json, List<dynamic> people){
    return GroupsModel(
      id: json['PK_${c.tableNameGroup}ID'],
      name: json['name'],
      people: people,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
