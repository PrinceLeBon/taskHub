import 'package:flutter/material.dart';
import 'package:task_manager/business_logic/cubit/appwrite_sdk/appwrite_sdk_cubit.dart';
import 'package:task_manager/presentation/homepage.dart';
import 'package:task_manager/presentation/login/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppwriteSdkCubit>(
            create: (BuildContext context) =>
                AppwriteSdkCubit()..initAppWriteSdk(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: const Color(0xFF5E6472),
            scaffoldBackgroundColor: Colors.white,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFFFFA69E),
            ),
            appBarTheme: const AppBarTheme(color: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
          home: const SignUp(),
        ));
  }
}
