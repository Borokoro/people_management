import 'package:people_managment/features/groups/data/models/groups_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:people_managment/core/database/database_service.dart';
import 'package:people_managment/core/constants/constants.dart' as c;

abstract class LocalGroupsDataSource {
  Future<void> insertGroup(GroupsModel group);
  Future<List<GroupsModel>> getGroups();
  Future<void> updateGroup(GroupsModel group);
  Future<void> deleteGroup(int id);
}

class LocalGroupsDataSourceImpl extends LocalGroupsDataSource {
  @override
  Future<void> insertGroup(GroupsModel group) async {
    int id;
    try {
      Database db = await DatabaseService().database;
      id = await db.insert(c.tableNameGroup, group.toJson());
      for (int i = 0; i < group.people.length; i++) {
        await db.rawInsert(
            'INSERT INTO ${c.tableNamePeople}_${c.tableNameGroup}(FK_${c.tableNamePeople}ID, FK_${c.tableNameGroup}ID)'
            'VALUES(?, ?)',
            [group.people[i], id]);
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  @override
  Future<List<GroupsModel>> getGroups() async {
    List<GroupsModel> dataFromDatabase = [];
    List<dynamic> people = [];
    try {
      Database db = await DatabaseService().database;
      for (var elementGroup in await db.query(c.tableNameGroup)) {
        var id = elementGroup["PK_${c.tableNameGroup}ID"];
        for (var elementPeople in await db.query(
            '${c.tableNamePeople}_${c.tableNameGroup}',
            where: 'FK_${c.tableNameGroup}ID=?',
            whereArgs: [id])) {
          people.add(elementPeople['FK_${c.tableNamePeople}ID']);
        }
        dataFromDatabase.add(GroupsModel.fromDatabase(elementGroup, people));
        people = [];
      }
      return dataFromDatabase;
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  @override
  Future<void> updateGroup(GroupsModel group) async {
    try {
      Database db = await DatabaseService().database;
      await db.delete('${c.tableNamePeople}_${c.tableNameGroup}',
          where: 'FK_${c.tableNameGroup}ID = ?', whereArgs: [group.id]);
      await db.update(c.tableNameGroup, group.toJson(),
          where: 'PK_${c.tableNameGroup}ID = ?', whereArgs: [group.id]);
      for (int i = 0; i < group.people.length; i++) {
        await db.rawInsert(
            'INSERT INTO ${c.tableNamePeople}_${c.tableNameGroup}(FK_${c.tableNamePeople}ID, FK_${c.tableNameGroup}ID)'
            'VALUES(?, ?)',
            [group.people[i], group.id]);
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  @override
  Future<void> deleteGroup(int id) async {
    try {
      Database db = await DatabaseService().database;
      await db.delete(c.tableNameGroup,
          where: 'PK_${c.tableNameGroup}ID = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }
}
