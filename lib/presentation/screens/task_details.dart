import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/presentation/widgets/profile_picture.dart';
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
                  (widget.listOfUsersPhoto.isNotEmpty)
                      ? SizedBox(
                          width: (widget.listOfUsersPhoto.length == 1)
                              ? 60
                              : (widget.listOfUsersPhoto.length == 2)
                                  ? 90
                                  : (widget.listOfUsersPhoto.length == 3)
                                      ? 120
                                      : (widget.listOfUsersPhoto.length == 4)
                                          ? 150
                                          : 180,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: ProfilePicture(
                                  radius: 50,
                                  imageId: widget.listOfUsersPhoto[0],
                                ),
                              ),
                              (widget.listOfUsersPhoto.length >= 2)
                                  ? Positioned(
                                      left: 30,
                                      bottom: 0,
                                      child: ProfilePicture(
                                        radius: 50,
                                        imageId: widget.listOfUsersPhoto[1],
                                      ),
                                    )
                                  : Container(),
                              (widget.listOfUsersPhoto.length >= 3)
                                  ? Positioned(
                                      left: 60,
                                      bottom: 0,
                                      child: ProfilePicture(
                                        radius: 50,
                                        imageId: widget.listOfUsersPhoto[2],
                                      ),
                                    )
                                  : Container(),
                              (widget.listOfUsersPhoto.length >= 4)
                                  ? Positioned(
                                      left: 90,
                                      bottom: 0,
                                      child: ProfilePicture(
                                        radius: 50,
                                        imageId: widget.listOfUsersPhoto[3],
                                      ),
                                    )
                                  : Container(),
                              (widget.listOfUsersPhoto.length >= 5)
                                  ? Positioned(
                                      left: 120,
                                      bottom: 0,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(5, 4, 43, 1),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Text(
                                            '+${widget.listOfUsersPhoto.length - 4}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container()
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
                  Text(
                    '${DateFormat('MMM d').format(widget.creationDate)}, by name of creator',
                    style: const TextStyle(
                        color: Color.fromRGBO(
                      5,
                      4,
                      43,
                      1,
                    )),
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
