import 'package:dartz/dartz.dart';
import 'package:people_managment/core/error/failures.dart';
import 'package:people_managment/features/post_code/data/models/post_code_data_model.dart';

abstract class PostCodeRepository{
  Future<Either<Failure, PostCodeDataModel>> getPostCodeData(String postCode);
}