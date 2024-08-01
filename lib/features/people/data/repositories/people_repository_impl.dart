import 'package:dartz/dartz.dart';
import 'package:people_managment/features/people/data/datasources/local_people_data_source.dart';
import 'package:people_managment/features/people/domain/repositories/people_repository.dart';

import '../../../../core/error/failures.dart';
import '../models/people_model.dart';

class PeopleRepositoryImpl implements PeopleRepository{
  final LocalPeopleDataSource localPeopleDataSource;

  PeopleRepositoryImpl({required this.localPeopleDataSource});

  @override
  Future<Either<Failure, void>> insertPerson(PeopleModel person) async{
    try{
      final result=await localPeopleDataSource.insertPerson(person);
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to insert person"));
    }
  }

  @override
  Future<Either<Failure, void>> updatePerson(PeopleModel person) async{
    try{
      final result=await localPeopleDataSource.updatePerson(person);
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to update person"));
    }
  }

  @override
  Future<Either<Failure, void>> deletePerson(int id) async{
    try{
      final result=await localPeopleDataSource.deletePerson(id);
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to delete person"));
    }
  }

  @override
  Future<Either<Failure, List<PeopleModel>>> getPeople() async{
    try{
      final result=await localPeopleDataSource.getPeople();
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to get people"));
    }
  }
}