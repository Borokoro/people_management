import 'package:equatable/equatable.dart';

class PostCodeEntity extends Equatable {
  final String postCode;
  final String city;
  final String street;
  final String county;
  final String voivodeship;

  const PostCodeEntity({
    required this.postCode,
    required this.county,
    required this.street,
    required this.voivodeship,
    required this.city,
  });

  @override
  List<Object> get props => [postCode, city, street, county, voivodeship];
}
