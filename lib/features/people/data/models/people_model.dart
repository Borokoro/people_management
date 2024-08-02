import 'package:people_managment/features/people/domain/entities/people_entity.dart';
import 'package:people_managment/core/constants/constants.dart' as c;

class PeopleModel extends PeopleEntity {
  const PeopleModel({
    required super.birthDate,
    required super.city,
    required super.county,
    required super.name,
    required super.postCode,
    required super.street,
    required super.surname,
    required super.voivodeship,
    required super.groups,
    required super.id,
  });

  factory PeopleModel.fromDatabase(
      Map<String, dynamic> json, List<dynamic> groups) {
    return PeopleModel(
      id: json['PK_${c.tableNamePeople}ID'],
      birthDate: json['birthDate'],
      city: json['city'],
      county: json['county'],
      name: json['name'],
      postCode: json['postCode'],
      street: json['street'],
      surname: json['surname'],
      voivodeship: json['voivodeship'],
      groups: groups,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      'postCode': postCode,
      'city': city,
      'street': street,
      'county': county,
      'voivodeship': voivodeship,
    };
  }
}
