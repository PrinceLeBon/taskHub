import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/business_logic/cubit/board/board_cubit.dart';
import 'package:task_manager/business_logic/cubit/task/task_cubit.dart';
import 'package:task_manager/presentation/widgets/board.dart';
import 'package:task_manager/presentation/widgets/custom_drawer.dart';
import 'package:task_manager/presentation/widgets/homePage/great.dart';
import 'package:task_manager/presentation/widgets/profile_picture.dart';
import 'package:task_manager/presentation/widgets/task.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/homePage/today_date.dart';
import 'add_tasks_boards_pages.dart';
import 'package:appwrite/appwrite.dart';

class MyHomePage extends StatefulWidget {
  final Client client;

  const MyHomePage({super.key, required this.client});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tasksOrBoards = 1;
  int days = 1;
  int numberOfTasksToday = 0;
  int numberOfBoards = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String userId = Hive.box("TaskHub").get("userId");

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
                    imageId: "currentUser.photo",
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
                                      context
                                          .read<TaskCubit>()
                                          .getTask(widget.client, days, userId);
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
                                        context.read<TaskCubit>().getTask(
                                            widget.client, days, userId);
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
                                        context.read<TaskCubit>().getTask(
                                            widget.client, days, userId);
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
                                        context.read<TaskCubit>().getTask(
                                            widget.client, days, userId);
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
                                        context.read<TaskCubit>().getTask(
                                            widget.client, days, userId);
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
                                        context.read<TaskCubit>().getTask(
                                            widget.client, days, userId);
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
                                        context.read<TaskCubit>().getTask(
                                            widget.client, days, userId);
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
                ? BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
                    if (state is TaskLoaded) {
                      if (state.taskAndUsersList.isNotEmpty) {
                        return SliverAnimatedList(
                          itemBuilder: (_, index, __) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: TaskWidget(
                                  id: state
                                      .taskAndUsersList[index].taskModel.id,
                                  boardId: state.taskAndUsersList[index]
                                      .taskModel.boardId,
                                  userId: state
                                      .taskAndUsersList[index].taskModel.userId,
                                  title: state
                                      .taskAndUsersList[index].taskModel.title,
                                  description: state.taskAndUsersList[index]
                                      .taskModel.description,
                                  state: state
                                      .taskAndUsersList[index].taskModel.state,
                                  creationDate: state.taskAndUsersList[index]
                                      .taskModel.creationDate,
                                  dateForTheTask: state.taskAndUsersList[index]
                                      .taskModel.dateForTheTask,
                                  hourForTheTask: state.taskAndUsersList[index]
                                      .taskModel.hourForTheTask,
                                  listOfUsersPhoto: state
                                      .taskAndUsersList[index]
                                      .listOfUsersPhoto),
                            );
                          },
                          initialItemCount: state.taskAndUsersList.length,
                        );
                      } else {
                        return const SliverToBoxAdapter(
                            child:
                                Center(child: Text("No tasks for this day")));
                      }
                    } else if (state is LoadingTask) {
                      return const SliverToBoxAdapter(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: kPrimaryColor)));
                    } else if (state is LoadingTaskFailed) {
                      return const SliverToBoxAdapter(
                          child: Center(
                              child: Text(
                                  "We are currently experiencing a problem please try again later")));
                    } else {
                      return const SliverToBoxAdapter(
                          child: Center(child: Text("Please try later")));
                    }
                  })
                : BlocConsumer<BoardCubit, BoardState>(
                    builder: (context, state) {
                    if (state is BoardLoaded) {
                      if (state.boardAndUsersList.isNotEmpty) {
                        return SliverAnimatedList(
                          itemBuilder: (_, index, __) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: BoardsWidget(
                                boardName: state
                                    .boardAndUsersList[index].boardModel.title,
                                listOfUsersPhoto: state
                                    .boardAndUsersList[index].listOfUsersPhoto,
                                numberOfTask: 14,
                                color: state
                                    .boardAndUsersList[index].boardModel.color,
                                boardId: state
                                    .boardAndUsersList[index].boardModel.id,
                              ),
                            );
                          },
                          initialItemCount: state.boardAndUsersList.length,
                        );
                      } else {
                        return const SliverToBoxAdapter(
                            child: Center(child: Text("No Boards")));
                      }
                    } else if (state is LoadingBoard) {
                      return const SliverToBoxAdapter(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: kPrimaryColor)));
                    } else if (state is LoadingBoardFailed) {
                      return const SliverToBoxAdapter(
                          child: Center(
                              child: Text(
                                  "We are currently experiencing a problem please try again later")));
                    } else {
                      return const SliverToBoxAdapter(
                          child: Center(child: Text("Please try later")));
                    }
                  }, listener: (context, state) {
                      Logger().i(state);
                    if (state is UserAdded && state.userAdded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('User added successfully')),
                        );
                        context.read<BoardCubit>().getBoard(client, userId);
                    } else if (state is AddingMoreUserFailed){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("This user doesn't exist")),
                      );
                    }
                  })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTasksBoardsPage(client: widget.client)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
