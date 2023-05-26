import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/task_details.dart';
import 'list_users_profiles_pictures.dart';

class TaskWidget extends StatefulWidget {
  final String id;
  final String boardId;
  final String userId;
  final String title;
  final String description;
  final bool state;
  final DateTime creationDate;
  final DateTime dateForTheTask;
  final String hourForTheTask;
  final List<String> listOfUsersPhoto;

  const TaskWidget(
      {Key? key,
      required this.id,
      required this.boardId,
      required this.userId,
      required this.title,
      required this.description,
      required this.state,
      required this.creationDate,
      required this.dateForTheTask,
      required this.hourForTheTask,
      required this.listOfUsersPhoto})
      : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  void initState() {
    super.initState();
    /*getBoardInformation();
    getCreatorOfThisTaskInformation(widget.id_user);*/
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListUserInABoard(listOfUsersPhoto: widget.listOfUsersPhoto),
                  Container(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        getTimeOfTasks(widget.hourForTheTask),
                      ),
                      Container(
                        width: 10,
                      ),
                      (!(widget.state))
                          ? Container(
                              decoration: const BoxDecoration(
                                  color: Colors.blueGrey,
                                  shape: BoxShape.circle),
                              child: const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.done),
                                color: Color.fromRGBO(
                                  5,
                                  4,
                                  43,
                                  1,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  )
                ],
              ),
              Container(
                height: 10,
              ),
              Text(
                widget.description,
                style: const TextStyle(color: Color.fromRGBO(5, 4, 43, 1)),
              ),
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(5, 4, 43, 1)),
                  ),
                  (widget.state)
                      ? Row(
                          children: [
                            const Text('Done'),
                            Container(width: 5),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(5, 4, 43, 1),
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
              Container(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TaskDetails(id: widget.id, boardName: "boardName", listOfUsersPhoto: widget.listOfUsersPhoto, title: widget.title, description: widget.description, state: widget.state, creationDate: widget.creationDate, dateForTheTask: widget.dateForTheTask, hourForTheTask: widget.hourForTheTask)));
      },
    );
  }

  /*Future<void> getBoardInformation() async {
    listPhotos.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.id)
        .collection("boards")
        .where("titre", isEqualTo: widget.id_board)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> boardFound = doc.data() as Map<String, dynamic>;
        setState(() {
          getProfilesPictures(List<String>.from(boardFound["listOfAssignee"]));
          boardName = boardFound["titre"];
        });
      }
    } else {
      print('board not found');
    }
  }

  Future<void> getProfilesPictures(List<String> l) async {
    listPhotos.clear();
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
    for (var user in l) {
      QuerySnapshot querySnapshot =
      await userCollection.where("id", isEqualTo: user).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> userFound = doc.data() as Map<String, dynamic>;
          setState(() {
            listPhotos.add(userFound['photo']);
          });
        }
      } else {
        print('username not found');
      }
    }
  }*/

  String getTimeOfTasks(String time) {
    List<String> heureParts = time.split(':');
    TimeOfDay heure = TimeOfDay(
        hour: int.parse(heureParts[0]), minute: int.parse(heureParts[1]));

    return (DateFormat.Hm().format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            heure.hour,
            heure.minute)))
        .replaceAll(":", "h");
  }
/*
  Future<void> getCreatorOfThisTaskInformation(String id_creator) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: id_creator)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> userFound = doc.data() as Map<String, dynamic>;
        setState(() {
          userName = userFound['username'];
          userPicture = userFound['photo'];
        });
      }
    } else {
      print('Creator Of This TaskInformation not found');
    }
  }

  void setAsDone() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.id)
        .collection('tasks')
        .doc(widget.id)
        .update({'etat': 'done'}).onError((error, stackTrace) => print(
        'Error updating state of this tasks Boards document: $error'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Set As Done')),
    );
  }*/
}
