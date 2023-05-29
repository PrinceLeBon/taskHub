import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/business_logic/cubit/task/task_cubit.dart';
import 'package:task_manager/presentation/widgets/profile_picture.dart';
import '../widgets/list_users_profiles_pictures.dart';
import '../widgets/packages/confirmation_slider.dart';

class TaskDetails extends StatefulWidget {
  final String id;
  final String boardName;
  final List<String> listOfUsersPhoto;
  final String title;
  final String description;
  final bool state;
  final DateTime creationDate;
  final DateTime dateForTheTask;
  final String hourForTheTask;

  const TaskDetails(
      {Key? key,
      required this.id,
      required this.boardName,
      required this.listOfUsersPhoto,
      required this.title,
      required this.description,
      required this.state,
      required this.creationDate,
      required this.dateForTheTask,
      required this.hourForTheTask})
      : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(5, 4, 43, 1), shape: BoxShape.circle),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(5, 4, 43, 1), shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_control),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                        color: const Color.fromRGBO(5, 4, 43, 1), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  child: Text(
                    widget.boardName,
                    style: const TextStyle(color: Color.fromRGBO(5, 4, 43, 1)),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    color: Color.fromRGBO(
                      5,
                      4,
                      43,
                      1,
                    ),
                    fontSize: 60),
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Date & Time',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text('Assignee', style: TextStyle(color: Colors.blueGrey)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.hourForTheTask,
                        style: const TextStyle(
                            color: Color.fromRGBO(
                              5,
                              4,
                              43,
                              1,
                            ),
                            fontSize: 30),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy').format(widget.dateForTheTask),
                        style: const TextStyle(
                            color: Color.fromRGBO(
                          5,
                          4,
                          43,
                          1,
                        )),
                      ),
                    ],
                  ),
                  ListUserInABoard(listOfUsersPhoto: widget.listOfUsersPhoto),
                ],
              ),
              Container(
                height: 20,
              ),
              const Text(
                'Additional Decription',
                style: TextStyle(color: Colors.blueGrey),
              ),
              Container(
                height: 20,
              ),
              Text(
                widget.description,
                style: const TextStyle(
                    color: Color.fromRGBO(
                  5,
                  4,
                  43,
                  1,
                )),
              ),
              Container(
                height: 20,
              ),
              const Text(
                'Created',
                style: TextStyle(color: Colors.blueGrey),
              ),
              Container(
                height: 20,
              ),
              Row(
                children: [
                  //TODO How to get user's information like his name
                  BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
                    if (state is CreatorGotten) {
                      return Text(
                        '${DateFormat('MMM d').format(widget.creationDate)}, by ${state.user.username}',
                        style:
                            const TextStyle(color: Color.fromRGBO(5, 4, 43, 1)),
                      );
                    } else {
                      return Text(
                        '${DateFormat('MMM d').format(widget.creationDate)}, by',
                        style:
                            const TextStyle(color: Color.fromRGBO(5, 4, 43, 1)),
                      );
                    }
                  }),
                  Container(
                    width: 5,
                  ),
                  ProfilePicture(
                      radius: 20, imageId: widget.listOfUsersPhoto[0])
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: (widget.state)
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ConfirmationSlider(
                onConfirmation: () {},
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ConfirmationSlider(
                onConfirmation: setAsDone,
              ),
            ),
    );
  }

  void setAsDone() {
    /*FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.id)
        .collection('tasks')
        .doc(widget.id)
        .update({'etat': 'done'}).onError((error, stackTrace) => print(
            'Error updating state of this tasks Boards document: $error'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Set As Done')),
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MyHomePage()));*/
  }
}
