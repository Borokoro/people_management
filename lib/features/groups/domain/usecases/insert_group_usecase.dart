import 'package:dartz/dartz.dart';
import 'package:people_managment/features/groups/data/models/groups_model.dart';

import '../../../../core/error/failures.dart';
import '../repositories/groups_repository.dart';

class InsertGroupUseCase {
  final GroupsRepository groupsRepository;

  const InsertGroupUseCase({required this.groupsRepository});

  Future<Either<Failure, void>> call(GroupsModel group) {
    return groupsRepository.insertGroup(group);
  }
}
