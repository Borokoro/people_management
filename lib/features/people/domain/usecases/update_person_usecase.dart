import 'package:dartz/dartz.dart';
import 'package:people_managment/features/people/data/models/people_model.dart';
import 'package:people_managment/features/people/domain/repositories/people_repository.dart';

import '../../../../core/error/failures.dart';

class UpdatePersonUseCase{
  final PeopleRepository peopleRepository;

  const UpdatePersonUseCase({required this.peopleRepository});

  Future<Either<Failure, void>> call(PeopleModel person){
    return peopleRepository.updatePerson(person);
  }
}