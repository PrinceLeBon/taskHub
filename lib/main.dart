import 'package:flutter/material.dart';
import 'package:task_manager/presentation/homepage.dart';
import 'package:task_manager/presentation/login/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}