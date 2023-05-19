import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/board.dart';
import 'package:task_manager/presentation/widgets/custom_drawer.dart';
import 'package:task_manager/presentation/widgets/homePage/great.dart';
import 'package:task_manager/presentation/widgets/homePage/todayDate.dart';
import 'package:task_manager/presentation/widgets/profile_picture.dart';
import 'package:task_manager/presentation/widgets/task.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tasksOrBoards = 1;
  int days = 1;
  int numberOfTasksToday = 0;
  int numberOfBoards = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              expandedHeight: 270,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  child: const ProfilePicture(
                    radius: 50,
                    image: "currentUser.photo",
                  ),
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),
              actions: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF5E6472), shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                    color: Colors.white,
                  ),
                ),
                Container(width: 3),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF5E6472), shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                  ),
                ),
                Container(width: 20),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 40),
                          const Great(),
                          Container(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TodayDate(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'number% done',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  Container(
                                    height: 5,
                                  ),
                                  const Text('Completed Tasks',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              elevation: 0,
              leadingWidth: 0,
              expandedHeight: (tasksOrBoards == 1) ? 170 : 80,
              titleTextStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: (tasksOrBoards == 1)
                                      ? const Color(0xFFB8F2E6)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: (tasksOrBoards == 1)
                                          ? Colors.white
                                          : const Color(0xFFB8F2E6),
                                      width: (tasksOrBoards == 1) ? 0 : 1)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 10, right: 10),
                                child: Text(
                                  numberOfTasksToday.toString(),
                                  style: TextStyle(
                                      color: (tasksOrBoards == 1)
                                          ? Colors.white
                                          : const Color(0xFFB8F2E6),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(width: 10),
                            const Text(
                              'Tasks',
                              style: TextStyle(
                                  letterSpacing: 2, color: Color(0xFF5E6472)),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            tasksOrBoards = 1;
                          });
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 2,
                        color: (tasksOrBoards == 1)
                            ? const Color(0xFFB8F2E6)
                            : Colors.grey,
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: (tasksOrBoards == 1)
                                      ? Colors.white
                                      : const Color(0xFFB8F2E6),
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: (tasksOrBoards == 1)
                                          ? const Color(0xFFB8F2E6)
                                          : Colors.transparent,
                                      width: (tasksOrBoards == 1) ? 1 : 0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 10, right: 10),
                                child: Text(
                                  numberOfBoards.toString(),
                                  style: TextStyle(
                                      color: (tasksOrBoards == 1)
                                          ? const Color(0xFFB8F2E6)
                                          : Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(width: 10),
                            const Text(
                              'Boards',
                              style: TextStyle(
                                  letterSpacing: 2, color: Color(0xFF5E6472)),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            tasksOrBoards = 2;
                          });
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 2,
                        color: (tasksOrBoards != 1)
                            ? const Color(0xFFB8F2E6)
                            : Colors.grey,
                      )
                    ],
                  )),
                ],
              ),
              flexibleSpace: (tasksOrBoards == 1)
                  ? FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.only(
                            top: 100, right: 20, left: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Container(
                                    height: 35,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Colors.blueAccent,
                                            width: 1)),
                                    child: const Center(
                                      child: Text(
                                        'Boards',
                                        style:
                                            TextStyle(color: Color(0xFF5E6472)),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Active',
                                            style: TextStyle(
                                                color: Color(0xFF5E6472)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border: Border.all(
                                                color: Colors.blueAccent,
                                                width: 1)),
                                        child: const Center(
                                          child: Text(
                                            'Done',
                                            style: TextStyle(
                                                color: Color(0xFF5E6472)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Center(
                                      child: Text(
                                        'Mon',
                                        style: TextStyle(
                                            color: (days == 1)
                                                ? kPrimaryColor
                                                : Colors.grey),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        days = 1;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Tue',
                                          style: TextStyle(
                                              color: (days == 2)
                                                  ? kPrimaryColor
                                                  : Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          days = 2;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Wed',
                                          style: TextStyle(
                                              color: (days == 3)
                                                  ? kPrimaryColor
                                                  : Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          days = 3;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Thu',
                                          style: TextStyle(
                                              color: (days == 4)
                                                  ? kPrimaryColor
                                                  : Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          days = 4;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Fri',
                                          style: TextStyle(
                                              color: (days == 5)
                                                  ? kPrimaryColor
                                                  : Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          days = 5;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Sat',
                                          style: TextStyle(
                                              color: (days == 6)
                                                  ? kPrimaryColor
                                                  : Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          days = 6;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Sun',
                                          style: TextStyle(
                                              color: (days == 7)
                                                  ? kPrimaryColor
                                                  : Colors.grey),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          days = 7;
                                        });
                                      }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
            (tasksOrBoards == 1)
                ? SliverAnimatedList(
                    itemBuilder: (_, index, __) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: TaskWidget(
                            id: "0",
                            id_board: "listTasks[index].id_board",
                            id_user: "listTasks[index].id_user",
                            titre: "listTasks[index].titre",
                            description: "listTasks[index].description",
                            etat: "listTasks[index].etat",
                            date_de_creation: DateTime.now(),
                            date_pour_la_tache: DateTime.now(),
                            heure_pour_la_tache: "15h50"),
                      );
                    },
                    initialItemCount: 10,
                  )
                : SliverAnimatedList(
                    itemBuilder: (_, index, __) {
                      return const Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: BoardsWidget(
                          boardName: "listBoards[index].titre",
                          listUsers: ["listBoards[index].listOfAssignee"],
                          numberOfTask: 14,
                          color: "0xFFB8F2E6",
                          idBoard: "listBoards[index].id",
                        ),
                      );
                    },
                    initialItemCount: 5,
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          /*Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTasksBoardsPage()));*/
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
