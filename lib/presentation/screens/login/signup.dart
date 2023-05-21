import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/models/user.dart';
import 'package:task_manager/utils/constants.dart';
import '../../../business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:appwrite/appwrite.dart';
import 'package:logger/logger.dart';
import 'login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  final Account account;

  const SignUpScreen({Key? key, required this.account}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late File image = File('');
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
        if (state is Signing) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (state is SigningFailed) {
          return const Center(
            child: Text("We have a problem, please try again later."),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
              margin: MediaQuery.of(context).padding,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InkWell(
                          child: Stack(
                            children: [
                              Positioned(
                                  child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(File(image.path)),
                                        fit: BoxFit.cover)),
                              )),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(5, 4, 43, 1),
                                      shape: BoxShape.circle),
                                  child: const Center(
                                    child: Icon(Icons.camera_alt,
                                        color: kPrimaryColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Last Name : '),
                            Container(
                              height: 10,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                              controller: myController1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: kPrimaryColor),
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
                            const Text('First Name : '),
                            Container(
                              height: 10,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                              controller: myController2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your fist name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.person, color: kPrimaryColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                            ),
                            const Text('Username : '),
                            Container(
                              height: 10,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                              controller: myController3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: kPrimaryColor),
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
                            const Text('Birthdate : '),
                            Container(
                              height: 10,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                              readOnly: true,
                              controller: myController4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please choose your birth day';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1920),
                                                builder: (context, child) {
                                                  return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        colorScheme:
                                                            const ColorScheme
                                                                .light(
                                                          primary:
                                                              Color.fromRGBO(
                                                                  5, 4, 43, 1),
                                                          onPrimary:
                                                              Colors.white,
                                                          onSurface:
                                                              Colors.black,
                                                        ),
                                                        textButtonTheme:
                                                            TextButtonThemeData(
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .black, // button text color
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!);
                                                },
                                                lastDate: DateTime.now(),
                                                initialEntryMode:
                                                    DatePickerEntryMode
                                                        .calendar)
                                            .then((value) {
                                          setState(() {
                                            date = value!;
                                            myController4.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(date);
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.date_range,
                                          color: kPrimaryColor)),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  )),
                            ),
                            Container(
                              height: 20,
                            ),
                            const Text('Email : '),
                            Container(
                              height: 10,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                              controller: myController5,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
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
                              controller: myController6,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.password,
                                      color: kPrimaryColor),
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
                              height: 10,
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('Already have an account ?'),
                            Container(
                              width: 10,
                            ),
                            InkWell(
                              child: const Text(
                                'Log In',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen(account: widget.account)));
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
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
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthenticationCubit>().signUp(
                                  widget.account,
                                  User(
                                    id: "id",
                                    name: myController1.text.trim(),
                                    surname: myController2.text.trim(),
                                    photo: image.path,
                                    email: myController5.text.trim(),
                                    birthday: myController4.text.trim(),
                                    username: myController3.text.trim(),
                                  ),
                                  myController6.text.trim());
                            }
                          },
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    )),
              ),
            ),
          );
        }
      }, listener: (context, state) {
        if (state is Signed) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginScreen(account: widget.account)));
        }
      }),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return;

      final imageTemporary = File(image2.path);
      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      Logger().e('Failure to select the image: $e');
    }
  }
}
