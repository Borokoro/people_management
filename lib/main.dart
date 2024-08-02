import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_managment/features/groups/presentation/bloc/groups_bloc.dart';
import 'package:people_managment/features/people/presentation/bloc/people_bloc.dart';
import 'package:people_managment/features/post_code/presentation/bloc/post_code_cubit.dart';

import 'bloc_observer.dart';
import 'features/bottom_navigation/bloc/bottom_navigation_cubit.dart';
import 'features/skeleton/presentation/skeleton.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<BottomNavigationCubit>()),
        BlocProvider(create: (_) => locator<PostCodeCubit>()),
        BlocProvider(create: (_) => locator<PeopleBloc>()),
        BlocProvider(create: (_) => locator<GroupsBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        title: 'People Management',
        debugShowCheckedModeBanner: false,
        home: const Skeleton(),
      ),
    );
  }
}
