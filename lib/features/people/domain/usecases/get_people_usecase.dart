import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/people_model.dart';
import '../repositories/people_repository.dart';

class GetPeopleUseCase{
  final PeopleRepository peopleRepository;

  const GetPeopleUseCase({required this.peopleRepository});

  Future<Either<Failure, List<PeopleModel>>> call(){
    return peopleRepository.getPeople();
  }
}