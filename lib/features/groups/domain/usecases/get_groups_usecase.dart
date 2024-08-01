import 'package:dartz/dartz.dart';
import 'package:people_managment/features/groups/data/models/groups_model.dart';

import '../../../../core/error/failures.dart';
import '../repositories/groups_repository.dart';

class GetGroupsUseCase{
  final GroupsRepository groupsRepository;

  const GetGroupsUseCase({required this.groupsRepository});

  Future<Either<Failure, List<GroupsModel>>> call(){
    return groupsRepository.getGroups();
  }
}