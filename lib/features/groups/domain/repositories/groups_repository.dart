import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/groups_model.dart';

abstract class GroupsRepository{
  Future<Either<Failure, void>> insertGroup(GroupsModel group);
  Future<Either<Failure, List<GroupsModel>>> getGroups();
  Future<Either<Failure, void>> updateGroup(GroupsModel group);
  Future<Either<Failure, void>> deleteGroup(int id);
}