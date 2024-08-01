import 'package:dartz/dartz.dart';
import 'package:people_managment/features/people/domain/repositories/people_repository.dart';

import '../../../../core/error/failures.dart';

class DeletePersonUseCase{
  final PeopleRepository peopleRepository;

  const DeletePersonUseCase({required this.peopleRepository});

  Future<Either<Failure, void>> call(int id){
    return peopleRepository.deletePerson(id);
  }
}