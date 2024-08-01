import 'package:dartz/dartz.dart';
import 'package:people_managment/core/error/exceptions.dart';
import 'package:people_managment/core/error/failures.dart';
import 'package:people_managment/features/post_code/data/datasources/remote_post_code_data_source.dart';
import 'package:people_managment/features/post_code/data/models/post_code_data_model.dart';
import 'package:people_managment/features/post_code/domain/repositories/post_code_repository.dart';

class PostCodeRepositoryImpl extends PostCodeRepository{
  final RemotePostCodeDataSource remotePostCodeDataSource;

  PostCodeRepositoryImpl({required this.remotePostCodeDataSource});

  @override
  Future<Either<Failure, PostCodeDataModel>> getPostCodeData(String postCode) async{
    try{
      final result=await remotePostCodeDataSource.fetchPostCodeData(postCode);
      return Right(result);
    } on ApiException{
      return const Left(ApiFailure("Failed to fetch data"));
    } on Exception{
      return const Left(ApiFailure("Failed to fetch data"));
    }
  }
}