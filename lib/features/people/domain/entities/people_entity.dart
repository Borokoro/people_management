import 'package:equatable/equatable.dart';

class PeopleEntity extends Equatable {
  final int id;
  final String name;
  final String surname;
  final String birthDate;
  final String postCode;
  final String city;
  final String street;
  final String county;
  final String voivodeship;
  final List<dynamic> groups;

  const PeopleEntity({
    required this.surname,
    required this.birthDate,
    required this.name,
    required this.city,
    required this.county,
    required this.postCode,
    required this.street,
    required this.voivodeship,
    required this.groups,
    required this.id,
  });

  @override
  List<Object> get props => [
        name,
        surname,
        birthDate,
        postCode,
        city,
        street,
        county,
        voivodeship,
        groups,
        id
      ];
}
