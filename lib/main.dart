import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/business_logic/cubit/appwrite_sdk/appwrite_sdk_cubit.dart';
import 'package:task_manager/business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:task_manager/business_logic/cubit/board/board_cubit.dart';
import 'package:task_manager/business_logic/cubit/task/task_cubit.dart';
import 'package:task_manager/data/repositories/authentication.dart';
import 'package:task_manager/data/repositories/board.dart';
import 'package:task_manager/data/repositories/file.dart';
import 'package:task_manager/data/repositories/task.dart';
import 'package:task_manager/presentation/screens/homepage.dart';
import 'package:task_manager/presentation/screens/login/login.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:appwrite/appwrite.dart';

Client client = Client().setEndpoint(endPoint).setProject(projectId);

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("TaskHub");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Box taskHubBox = Hive.box("TaskHub");
    final String userId = taskHubBox.get("userId");
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => AuthenticationRepository()),
          RepositoryProvider<FileRepository>(
              create: (context) => FileRepository()),
          RepositoryProvider<TaskRepository>(
              create: (context) => TaskRepository()),
          RepositoryProvider<BoardRepository>(
              create: (context) => BoardRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<AppwriteSdkCubit>(
                create: (BuildContext context) =>
                    AppwriteSdkCubit()..initAppWriteSdk(),
              ),
              BlocProvider<AuthenticationCubit>(
                create: (BuildContext context) => AuthenticationCubit(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
              ),
              BlocProvider<BoardCubit>(
                  create: (BuildContext context) => BoardCubit(
                      boardRepository:
                          RepositoryProvider.of<BoardRepository>(context))
                    ..getBoard(client, userId)),
              BlocProvider<TaskCubit>(
                  create: (BuildContext context) => TaskCubit(
                      taskRepository:
                          RepositoryProvider.of<TaskRepository>(context))
                    ..getTask(client, DateTime.now().day, userId)),
            ],
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: const Color(0xFF5E6472),
                scaffoldBackgroundColor: Colors.white,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: kPrimaryColor,
                ),
                appBarTheme: const AppBarTheme(color: Colors.white),
              ),
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<AppwriteSdkCubit, AppwriteSdkState>(
                  builder: (context, appWriteSdkState) {
                if (appWriteSdkState is AppwriteSdkLoading) {
                  return const Scaffold(
                      body: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ));
                } else if (appWriteSdkState is AppwriteSdkLoaded) {
                  return FutureBuilder(
                      future: appWriteSdkState.account.get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Scaffold(
                              body: Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          ));
                        } else if (snapshot.hasData) {
                          final session = snapshot.data;
                          Logger().i(session);
                          return const MyHomePage();
                        } else {
                          return LoginScreen(account: appWriteSdkState.account);
                        }
                      });
                } else {
                  return const Scaffold(
                    body: Center(
                      child: Text("Erreur oh"),
                    ),
                  );
                }
              }),
            )));
  }
}
