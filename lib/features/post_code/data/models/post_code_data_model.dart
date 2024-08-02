import 'package:people_managment/features/post_code/domain/entities/post_code_entity.dart';

class PostCodeDataModel extends PostCodeEntity {
  const PostCodeDataModel({
    required super.city,
    required super.county,
    required super.postCode,
    required super.street,
    required super.voivodeship,
  });

  factory PostCodeDataModel.fromApi(Map<String, dynamic> json) {
    return PostCodeDataModel(
      city: json['miejscowosc'],
      county: json['powiat'],
      postCode: json['kod'],
      street: json['ulica'],
      voivodeship: json['wojewodztwo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postCode': postCode,
      'city': city,
      'street': street,
      'county': county,
      'voivodeship': voivodeship,
    };
  }
}
