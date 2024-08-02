import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:people_managment/features/groups/data/datasources/local_groups_data_source.dart';
import 'package:people_managment/features/people/data/datasources/local_people_data_source.dart';
import 'package:people_managment/features/people/domain/repositories/people_repository.dart';
import 'package:people_managment/features/people/presentation/bloc/people_bloc.dart';
import 'package:people_managment/features/post_code/data/datasources/remote_post_code_data_source.dart';
import 'package:people_managment/features/post_code/data/repositories/post_code_repository_impl.dart';
import 'package:people_managment/features/post_code/domain/repositories/post_code_repository.dart';
import 'package:people_managment/features/post_code/domain/usecases/get_post_code_data_usecase.dart';
import 'package:people_managment/features/post_code/presentation/bloc/post_code_cubit.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'features/bottom_navigation/bloc/bottom_navigation_cubit.dart';
import 'features/groups/data/repositories/groups_repository_impl.dart';
import 'features/groups/domain/repositories/groups_repository.dart';
import 'features/groups/domain/usecases/delete_group_usecase.dart';
import 'features/groups/domain/usecases/get_groups_usecase.dart';
import 'features/groups/domain/usecases/insert_group_usecase.dart';
import 'features/groups/domain/usecases/update_group_usecase.dart';
import 'features/groups/presentation/bloc/groups_bloc.dart';
import 'features/people/data/repositories/people_repository_impl.dart';
import 'features/people/domain/usecases/delete_person_usecase.dart';
import 'features/people/domain/usecases/get_people_usecase.dart';
import 'features/people/domain/usecases/insert_person_usecase.dart';
import 'features/people/domain/usecases/update_person_usecase.dart';

final locator = GetIt.instance;

void setupLocator() {
  //cubit
  locator.registerFactory(() => BottomNavigationCubit());
  locator
      .registerFactory(() => PostCodeCubit(getPostCodeDataUseCase: locator()));

  //bloc
  locator.registerFactory(() => PeopleBloc(
      getPeopleUseCase: locator(),
      deletePersonUseCase: locator(),
      updatePersonUseCase: locator(),
      insertPersonUseCase: locator()));
  locator.registerFactory(() => GroupsBloc(
      getGroupsUseCase: locator(),
      deleteGroupUseCase: locator(),
      updateGroupUseCase: locator(),
      insertGroupUseCase: locator()));

  //use-cases
  locator.registerLazySingleton(
      () => DeletePersonUseCase(peopleRepository: locator()));
  locator.registerLazySingleton(
      () => GetPeopleUseCase(peopleRepository: locator()));
  locator.registerLazySingleton(
      () => InsertPersonUseCase(peopleRepository: locator()));
  locator.registerLazySingleton(
      () => UpdatePersonUseCase(peopleRepository: locator()));

  locator.registerLazySingleton(
      () => DeleteGroupUseCase(groupsRepository: locator()));
  locator.registerLazySingleton(
      () => GetGroupsUseCase(groupsRepository: locator()));
  locator.registerLazySingleton(
      () => InsertGroupUseCase(groupsRepository: locator()));
  locator.registerLazySingleton(
      () => UpdateGroupUseCase(groupsRepository: locator()));

  locator.registerLazySingleton(
      () => GetPostCodeDataUseCase(postCodeRepository: locator()));

  //repositories
  locator.registerLazySingleton<PeopleRepository>(
      () => PeopleRepositoryImpl(localPeopleDataSource: locator()));
  locator.registerLazySingleton<GroupsRepository>(
      () => GroupsRepositoryImpl(localGroupsDataSource: locator()));
  locator.registerLazySingleton<PostCodeRepository>(
      () => PostCodeRepositoryImpl(remotePostCodeDataSource: locator()));

  //data-sources
  locator.registerLazySingleton<LocalPeopleDataSource>(
      () => LocalPeopleDataSourceImpl());
  locator.registerLazySingleton<LocalGroupsDataSource>(
      () => LocalGroupsDataSourceImpl());
  locator.registerLazySingleton<RemotePostCodeDataSource>(
      () => RemotePostCodeDataSourceImpl(dio: locator()));
  //clients
  locator.registerLazySingleton(
      () => Dio()..interceptors.add(RequestsInspectorInterceptor()));
}
