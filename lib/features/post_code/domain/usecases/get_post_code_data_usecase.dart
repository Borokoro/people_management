import 'package:dartz/dartz.dart';
import 'package:people_managment/core/error/failures.dart';
import 'package:people_managment/features/post_code/data/models/post_code_data_model.dart';
import 'package:people_managment/features/post_code/domain/repositories/post_code_repository.dart';

class GetPostCodeDataUseCase {
  final PostCodeRepository postCodeRepository;

  const GetPostCodeDataUseCase({required this.postCodeRepository});

  Future<Either<Failure, PostCodeDataModel>> call(String postCode) {
    return postCodeRepository.getPostCodeData(postCode);
  }
}
