import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/groups_repository.dart';

class DeleteGroupUseCase{
  final GroupsRepository groupsRepository;

  const DeleteGroupUseCase({required this.groupsRepository});

  Future<Either<Failure, void>> call(int id){
    return groupsRepository.deleteGroup(id);
  }
}