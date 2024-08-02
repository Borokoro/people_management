import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_managment/features/groups/data/models/groups_model.dart';
import 'package:people_managment/features/groups/domain/usecases/delete_group_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_groups_usecase.dart';
import '../../domain/usecases/insert_group_usecase.dart';
import '../../domain/usecases/update_group_usecase.dart';

part 'groups_event.dart';
part 'groups_state.dart';


class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final DeleteGroupUseCase deleteGroupUseCase;
  final GetGroupsUseCase getGroupsUseCase;
  final InsertGroupUseCase insertGroupUseCase;
  final UpdateGroupUseCase updateGroupUseCase;

  GroupsBloc({
    required this.updateGroupUseCase,
    required this.getGroupsUseCase,
    required this.deleteGroupUseCase,
    required this.insertGroupUseCase,}) : super(const GroupsState()) {
    on<DeleteGroupEvent>(_onDeleteGroupEvent);
    on<GetGroupsEvent>(_onGetGroupsEvent);
    on<InsertGroupEvent>(_onInsertGroupEvent);
    on<UpdateGroupEvent>(_onUpdateGroupEvent);
  }

  _onDeleteGroupEvent(DeleteGroupEvent event, Emitter<GroupsState> emit) async{
    final Either<Failure, void> result= await deleteGroupUseCase.call(event.id);
    result.fold((l){}, (r){
      event.context.read<GroupsBloc>().add(const GetGroupsEvent());
    });
  }

  _onGetGroupsEvent(GetGroupsEvent event, Emitter<GroupsState> emit) async{
    emit(const GroupsLoading());
    final Either<Failure, List<GroupsModel>> result= await getGroupsUseCase.call();

    result.fold((l)=> emit(GroupsError(message: l.toString())), (r){
      emit(GroupsState(data: r));
    });
  }

  _onInsertGroupEvent(InsertGroupEvent event, Emitter<GroupsState> emit) async{
    final Either<Failure, void> result= await insertGroupUseCase.call(event.group);
    result.fold((l){}, (r){
      event.context.read<GroupsBloc>().add(const GetGroupsEvent());
    });
  }

  _onUpdateGroupEvent(UpdateGroupEvent event, Emitter<GroupsState> emit) async{
    final Either<Failure, void> result= await updateGroupUseCase.call(event.group);
    result.fold((l){}, (r){
      event.context.read<GroupsBloc>().add(const GetGroupsEvent());
    });
  }

}