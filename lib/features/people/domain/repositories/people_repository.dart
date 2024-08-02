import 'package:dartz/dartz.dart';
import 'package:people_managment/features/people/data/models/people_model.dart';

import '../../../../core/error/failures.dart';

abstract class PeopleRepository {
  Future<Either<Failure, void>> insertPerson(PeopleModel person);
  Future<Either<Failure, List<PeopleModel>>> getPeople();
  Future<Either<Failure, void>> updatePerson(PeopleModel person);
  Future<Either<Failure, void>> deletePerson(int id);
}
