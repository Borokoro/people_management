import 'package:people_managment/features/people/data/models/people_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:people_managment/core/database/database_service.dart';
import 'package:people_managment/core/constants/constants.dart' as c;

abstract class LocalPeopleDataSource {
  Future<void> insertPerson(PeopleModel person);
  Future<List<PeopleModel>> getPeople();
  Future<void> updatePerson(PeopleModel person);
  Future<void> deletePerson(int id);
}

class LocalPeopleDataSourceImpl extends LocalPeopleDataSource {
  @override
  Future<void> insertPerson(PeopleModel person) async {
    int id;
    try {
      Database db = await DatabaseService().database;
      id = await db.insert(c.tableNamePeople, person.toJson());
      for (int i = 0; i < person.groups.length; i++) {
        await db.rawInsert(
            'INSERT INTO ${c.tableNamePeople}_${c.tableNameGroup}(FK_${c.tableNamePeople}ID, FK_${c.tableNameGroup}ID)'
            'VALUES(?, ?)',
            [id, person.groups[i]]);
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  @override
  Future<List<PeopleModel>> getPeople() async {
    List<PeopleModel> dataFromDatabase = [];
    List<dynamic> groups = [];
    try {
      Database db = await DatabaseService().database;
      for (var elementPeople in await db.query(c.tableNamePeople)) {
        var id = elementPeople["PK_${c.tableNamePeople}ID"];
        for (var elementGroup in await db.query(
            '${c.tableNamePeople}_${c.tableNameGroup}',
            where: 'FK_${c.tableNamePeople}ID=?',
            whereArgs: [id])) {
          groups.add(elementGroup['FK_${c.tableNameGroup}ID']);
        }
        dataFromDatabase.add(PeopleModel.fromDatabase(elementPeople, groups));
        groups = [];
      }
      return dataFromDatabase;
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  @override
  Future<void> updatePerson(PeopleModel person) async {
    try {
      Database db = await DatabaseService().database;
      await db.delete('${c.tableNamePeople}_${c.tableNameGroup}',
          where: 'FK_${c.tableNamePeople}ID = ?', whereArgs: [person.id]);
      await db.update(c.tableNamePeople, person.toJson(),
          where: 'PK_${c.tableNamePeople}ID = ?', whereArgs: [person.id]);
      for (int i = 0; i < person.groups.length; i++) {
        await db.rawInsert(
            'INSERT INTO ${c.tableNamePeople}_${c.tableNameGroup}(FK_${c.tableNamePeople}ID, FK_${c.tableNameGroup}ID)'
            'VALUES(?, ?)',
            [person.id, person.groups[i]]);
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  @override
  Future<void> deletePerson(int id) async {
    try {
      Database db = await DatabaseService().database;
      await db.delete(c.tableNamePeople,
          where: 'PK_${c.tableNamePeople}ID = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }
}
