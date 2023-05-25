import 'package:flutter/material.dart';

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
  final myController1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    //getProfilePicture();
  }

  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
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
                          onPressed: () {
                            _showMyDialog(widget.boardName);
                          },
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

  /*Future<void> getProfilePicture() async {
    listPhotos.clear();
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
    for (var user in widget.listUsers) {
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
        print('username non trouvé');
      }
    }
  }*/

  Future<void> _showMyDialog(String _boardName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text('Add users to $_boardName Board',
                  style: const TextStyle(color: Colors.white))),
          content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      controller: myController1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter user's username";
                        }
                        return null;
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
                          hintText: "Enter user's username",
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
                //AddUserToBoard(myController1.text.trim());
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: const Color.fromRGBO(5, 4, 43, 1),
        );
      },
    );
  }

/*Future<void> AddUserToBoard(String _username) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: _username)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> userFound = doc.data() as Map<String, dynamic>;
        List<dynamic> newId = [userFound['id']];
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.id)
            .collection('boards')
            .doc(widget.boardId)
            .set({
          "listOfAssignee": FieldValue.arrayUnion(newId)
        }, SetOptions(merge: true)).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully added user')),
            ),
            onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("This user doesn't exist")),
            ));
      }
    }
  }*/
}
