import 'package:dartz/dartz.dart';
import 'package:people_managment/features/groups/data/models/groups_model.dart';

import '../../../../core/error/failures.dart';
import '../repositories/groups_repository.dart';

class UpdateGroupUseCase {
  final GroupsRepository groupsRepository;

  const UpdateGroupUseCase({required this.groupsRepository});

  Future<Either<Failure, void>> call(GroupsModel group) {
    return groupsRepository.updateGroup(group);
  }
}
