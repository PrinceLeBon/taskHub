import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/business_logic/cubit/board/board_cubit.dart';

import 'list_users_profiles_pictures.dart';

class BoardsWidget extends StatefulWidget {
  final String boardId;
  final String boardName;
  final List<String> listOfUsersPhoto;
  final String color;
  final int numberOfTask;

  const BoardsWidget(
      {Key? key,
      required this.boardName,
      required this.listOfUsersPhoto,
      required this.numberOfTask,
      required this.color,
      required this.boardId})
      : super(key: key);

  @override
  State<BoardsWidget> createState() => _BoardsWidgetState();
}

class _BoardsWidgetState extends State<BoardsWidget> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String email = "";

  @override
  void dispose() {
    //myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: hexToColor(widget.color),
          borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: _showMyDialog,
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromRGBO(5, 4, 43, 1),
                          )),
                    ),
                    ListUserInABoard(listOfUsersPhoto: widget.listOfUsersPhoto),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.transparent, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_control_sharp),
                    color: const Color.fromRGBO(5, 4, 43, 1),
                  ),
                )
              ],
            ),
            Container(
              height: 10,
            ),
            Text('${widget.numberOfTask} Active Tasks'),
            Container(
              height: 10,
            ),
            Text(
              widget.boardName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text('Add user to ${widget.boardName} Board',
                  style: const TextStyle(color: Colors.white))),
          content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      controller: myController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter user's email";
                        }
                        return null;
                      },
                      onChanged: (value){
                        Logger().i(myController.text.trim());
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          hintText: "Enter user's email",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      height: 20,
                    ),
                  ],
                ),
              )),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                if (email.isNotEmpty) {
                  context.read<BoardCubit>().addMoreUsersToBoard(
                      email, widget.boardId);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: const Color.fromRGBO(5, 4, 43, 1),
        );
      },
    );
  }
}
