import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/business_logic/cubit/appwrite_sdk/appwrite_sdk_cubit.dart';
import 'package:task_manager/business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:task_manager/data/repositories/authentication.dart';
import 'package:task_manager/presentation/screens/homepage.dart';
import 'package:task_manager/presentation/screens/login/login.dart';
import 'package:task_manager/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => AuthenticationRepository()),
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
