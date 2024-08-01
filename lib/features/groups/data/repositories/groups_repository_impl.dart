import 'package:dartz/dartz.dart';
import 'package:people_managment/features/groups/data/datasources/local_groups_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/groups_repository.dart';
import '../models/groups_model.dart';

class GroupsRepositoryImpl implements GroupsRepository{
  final LocalGroupsDataSource localGroupsDataSource;

  GroupsRepositoryImpl({required this.localGroupsDataSource});

  @override
  Future<Either<Failure, void>> insertGroup(GroupsModel group) async{
    try{
      final result=await localGroupsDataSource.insertGroup(group);
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to insert group"));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroup(GroupsModel group) async{
    try{
      final result=await localGroupsDataSource.updateGroup(group);
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to update group"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroup(int id) async{
    try{
      final result=await localGroupsDataSource.deleteGroup(id);
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to delete group"));
    }
  }

  @override
  Future<Either<Failure, List<GroupsModel>>> getGroups() async{
    try{
      final result=await localGroupsDataSource.getGroups();
      return Right(result);
    } on Exception{
      return const Left(DatabaseFailure("Failed to get groups"));
    }
  }
}