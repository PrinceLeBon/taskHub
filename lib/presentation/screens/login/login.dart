import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:task_manager/presentation/screens/homepage.dart';
import 'package:task_manager/presentation/screens/login/signup.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import '../../../business_logic/cubit/board/board_cubit.dart';
import '../../../business_logic/cubit/task/task_cubit.dart';

class LoginScreen extends StatefulWidget {
  final Account account;

  const LoginScreen({Key? key, required this.account}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
        if (state is Login) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (state is LoginFailed) {
          return const Center(
            child: Text("We have a problem, please try again later."),
          );
        } else {
          return Container(
            margin: MediaQuery.of(context).padding,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Email : '),
                          Container(
                            height: 10,
                          ),
                          TextFormField(
                            style: const TextStyle(fontSize: 13),
                            controller: myController1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.mail, color: kPrimaryColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          ),
                          Container(
                            height: 20,
                          ),
                          const Text('Password : '),
                          Container(
                            height: 10,
                          ),
                          TextFormField(
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black),
                            obscureText: true,
                            obscuringCharacter: '*',
                            controller: myController2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: kPrimaryColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                          ),
                          Container(
                            height: 20,
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                            width: 120,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationCubit>().login(
                                widget.account,
                                myController1.text.trim(),
                                myController2.text.trim());
                          }
                        },
                      ),
                      Container(
                        height: 20,
                      ),
                      InkWell(
                        child: const Text(
                          'Forgot your password ?',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        onTap: () {},
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account ?"),
                          Container(
                            width: 10,
                          ),
                          InkWell(
                            child: const Text(
                              'Create an account',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen(
                                        account: widget.account,
                                      )));
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          );
        }
      }, listener: (context, state) {
        if (state is Logged) {
          final Box taskHubBox = Hive.box("TaskHub");
          final String userId = taskHubBox.get("userId");
          context.read<BoardCubit>().getBoard(widget.account.client, userId);
          context
              .read<TaskCubit>()
              .getTask(widget.account.client, DateTime.now().day, userId);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyHomePage(client: widget.account.client)));
        }
      }),
    );
  }
}
