import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_managment/core/error/failures.dart';
import 'package:people_managment/features/people/domain/usecases/insert_person_usecase.dart';
import 'package:people_managment/features/successful_operation_checker/presentation/successful_operation_checker_cubit.dart';

import '../../data/models/people_model.dart';
import '../../domain/usecases/delete_person_usecase.dart';
import '../../domain/usecases/get_people_usecase.dart';
import '../../domain/usecases/update_person_usecase.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final DeletePersonUseCase deletePersonUseCase;
  final GetPeopleUseCase getPeopleUseCase;
  final InsertPersonUseCase insertPersonUseCase;
  final UpdatePersonUseCase updatePersonUseCase;

  PeopleBloc({
    required this.updatePersonUseCase,
    required this.getPeopleUseCase,
    required this.deletePersonUseCase,
  required this.insertPersonUseCase,}) : super(const PeopleState()) {
    on<DeletePersonEvent>(_onDeletePersonEvent);
    on<GetPeopleEvent>(_onGetPeopleEvent);
    on<InsertPersonEvent>(_onInsertPersonEvent);
    on<UpdatePersonEvent>(_onUpdatePersonEvent);
  }

  _onDeletePersonEvent(DeletePersonEvent event, Emitter<PeopleState> emit) async{
    final Either<Failure, void> result= await deletePersonUseCase.call(event.id);
    result.fold((l){
      event.context.read<SuccessfulOperationCheckerCubit>().operationUnSuccessful();
    }, (r){
      event.context.read<SuccessfulOperationCheckerCubit>().operationSuccessful();
      event.context.read<PeopleBloc>().add(const GetPeopleEvent());
    });
  }

  _onGetPeopleEvent(GetPeopleEvent event, Emitter<PeopleState> emit) async{
    emit(const PeopleLoading());
    final Either<Failure, List<PeopleModel>> result= await getPeopleUseCase.call();

    result.fold((l)=> emit(PeopleError(message: l.toString())), (r){
      emit(PeopleState(data: r));
    });
  }

  _onInsertPersonEvent(InsertPersonEvent event, Emitter<PeopleState> emit) async{
    final Either<Failure, void> result= await insertPersonUseCase.call(event.person);
    result.fold((l){
      event.context.read<SuccessfulOperationCheckerCubit>().operationUnSuccessful();
    }, (r){
      event.context.read<SuccessfulOperationCheckerCubit>().operationSuccessful();
      event.context.read<PeopleBloc>().add(const GetPeopleEvent());
    });
  }

  _onUpdatePersonEvent(UpdatePersonEvent event, Emitter<PeopleState> emit) async{
    final Either<Failure, void> result= await updatePersonUseCase.call(event.person);
    result.fold((l){
      event.context.read<SuccessfulOperationCheckerCubit>().operationUnSuccessful();
    }, (r){
      event.context.read<SuccessfulOperationCheckerCubit>().operationSuccessful();
      event.context.read<PeopleBloc>().add(const GetPeopleEvent());
    });
  }

}
