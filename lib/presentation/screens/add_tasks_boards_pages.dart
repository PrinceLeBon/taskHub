import 'package:color_parser/color_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/business_logic/cubit/board/board_cubit.dart';
import 'package:task_manager/business_logic/cubit/task/task_cubit.dart';
import 'package:task_manager/data/models/board.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import '../../data/models/board_and_user_list.dart';
import '../../data/models/task.dart';
import '../../utils/constants.dart';

class AddTasksBoardsPage extends StatefulWidget {
  final Client client;

  const AddTasksBoardsPage({Key? key, required this.client}) : super(key: key);

  @override
  State<AddTasksBoardsPage> createState() => _AddTasksBoardsPageState();
}

class _AddTasksBoardsPageState extends State<AddTasksBoardsPage> {
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();
  final myController7 = TextEditingController();
  DateTime _date = DateTime.now();
  int tasksOrBoards = 1;
  Color pickerColor = Colors.blue;
  Color currentColor = Colors.blue;

  final String userId = Hive.box("TaskHub").get("userId");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();
    myController7.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (tasksOrBoards == 1) ? Colors.yellow : Colors.blueAccent,
      appBar: AppBar(
          backgroundColor:
              (tasksOrBoards == 1) ? Colors.yellow : Colors.blueAccent,
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
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Tasks',
                                  style: TextStyle(letterSpacing: 2),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 2,
                                  color: (tasksOrBoards == 1)
                                      ? const Color.fromRGBO(5, 4, 43, 1)
                                      : Colors.white,
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                tasksOrBoards = 1;
                              });
                            })),
                    Expanded(
                        child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Boards',
                                  style: TextStyle(letterSpacing: 2),
                                ),
                                Container(
                                  height: 10,
                                ),
                                Container(
                                  height: 2,
                                  color: (tasksOrBoards != 1)
                                      ? const Color.fromRGBO(5, 4, 43, 1)
                                      : Colors.white,
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                tasksOrBoards = 2;
                              });
                            }))
                  ],
                ),
                Container(
                  height: 20,
                ),
                (tasksOrBoards == 1)
                    ? BlocConsumer<TaskCubit, TaskState>(
                        builder: (context, taskState) {
                        return Form(
                            key: _formKey,
                            child: Column(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Task : ',
                                      style: TextStyle(
                                          color: Color.fromRGBO(5, 4, 43, 1))),
                                  Container(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(5, 4, 43, 1)),
                                    controller: myController1,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your task name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.task,
                                          color: Color.fromRGBO(5, 4, 43, 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Color.fromRGBO(5, 4, 43, 1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Color.fromRGBO(5, 4, 43, 1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        )),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  const Text('Additional Description : ',
                                      style: TextStyle(
                                          color: Color.fromRGBO(5, 4, 43, 1))),
                                  Container(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(5, 4, 43, 1)),
                                    controller: myController2,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter additional description';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.description_outlined,
                                          color: Color.fromRGBO(5, 4, 43, 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Color.fromRGBO(5, 4, 43, 1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Color.fromRGBO(5, 4, 43, 1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        )),
                                  ),
                                  Container(
                                    height: 20,
                                  ),

                                  ///
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Date : ',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    5, 4, 43, 1)),
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color.fromRGBO(
                                                      5, 4, 43, 1)),
                                              readOnly: true,
                                              controller: myController3,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please choose a date';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  prefixIcon: IconButton(
                                                      onPressed: () {
                                                        showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime
                                                                        .now(),
                                                                builder:
                                                                    (context,
                                                                        child) {
                                                                  return Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        colorScheme:
                                                                            const ColorScheme.light(
                                                                          primary: Color.fromRGBO(
                                                                              5,
                                                                              4,
                                                                              43,
                                                                              1),
                                                                          // <-- SEE HERE
                                                                          onPrimary:
                                                                              Colors.white,
                                                                          // <-- SEE HERE
                                                                          onSurface:
                                                                              Colors.black, // <-- SEE HERE
                                                                        ),
                                                                        textButtonTheme:
                                                                            TextButtonThemeData(
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            foregroundColor:
                                                                                Colors.black, // button text color
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          child!);
                                                                },
                                                                lastDate:
                                                                    DateTime(
                                                                        3000),
                                                                initialEntryMode:
                                                                    DatePickerEntryMode
                                                                        .calendar)
                                                            .then((value) {
                                                          setState(() {
                                                            _date = value!;
                                                            myController3
                                                                .text = DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(_date);
                                                          });
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.date_range,
                                                          color: Color.fromRGBO(
                                                              5, 4, 43, 1))),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            5, 4, 43, 1)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            5, 4, 43, 1)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Hour : ',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    5, 4, 43, 1)),
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color.fromRGBO(
                                                      5, 4, 43, 1)),
                                              readOnly: true,
                                              controller: myController4,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please choose an hour';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  prefixIcon: IconButton(
                                                      onPressed: () {
                                                        showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            builder: (context,
                                                                child) {
                                                              return Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                    colorScheme:
                                                                        const ColorScheme
                                                                            .light(
                                                                      primary: Color
                                                                          .fromRGBO(
                                                                              5,
                                                                              4,
                                                                              43,
                                                                              1),
                                                                      onPrimary:
                                                                          Colors
                                                                              .white,
                                                                      onSurface:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                    textButtonTheme:
                                                                        TextButtonThemeData(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            Colors.black, // button text color
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      child!);
                                                            }).then((value) {
                                                          setState(() {
                                                            myController4.text =
                                                                '${value?.hour}:${value?.minute}';
                                                          });
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons
                                                              .timelapse_outlined,
                                                          color: Color.fromRGBO(
                                                              5, 4, 43, 1))),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            5, 4, 43, 1)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            5, 4, 43, 1)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                  )),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  BlocBuilder<BoardCubit, BoardState>(
                                    builder: (context, state) {
                                      if (state is BoardLoaded) {
                                        if (state
                                            .boardAndUsersList.isNotEmpty) {
                                          return DropdownButtonFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please choose a board';
                                              }
                                              return null;
                                            },
                                            hint: const Text(
                                                'Choose a board : ',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        5, 4, 43, 1))),
                                            icon: const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.black,
                                            ),
                                            items: state.boardAndUsersList.map(
                                                (BoardAndUsers boardAndUsers) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    boardAndUsers.boardModel.id,
                                                child: Text(boardAndUsers
                                                    .boardModel.title),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            onChanged: (String? value) {
                                              setState(() {
                                                myController5.text = value!;
                                              });
                                            },
                                          );
                                        } else {
                                          return DropdownButtonFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please choose a board';
                                              }
                                              return null;
                                            },
                                            hint: const Text(
                                                'Choose a Board : ',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        5, 4, 43, 1))),
                                            icon: const Icon(
                                              Icons.arrow_downward,
                                              color: Colors.black,
                                            ),
                                            items: null,
                                            value: myController5.text.trim(),
                                            isExpanded: true,
                                            onChanged: null,
                                          );
                                        }
                                      } else if (state is LoadingBoard) {
                                        return const SliverToBoxAdapter(
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: kPrimaryColor)));
                                      } else if (state is LoadingBoardFailed) {
                                        return const Center(
                                            child: Text(
                                                "We are currently experiencing a problem please try again later"));
                                      } else {
                                        return const Center(
                                            child: Text("Please try later"));
                                      }
                                    },
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Container(
                                        width: 120,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(5, 4, 43, 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: const Center(
                                          child: Text(
                                            'Add Task',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<TaskCubit>().addTasks(
                                            widget.client,
                                            TaskModel(
                                                id: "id",
                                                boardId:
                                                    myController5.text.trim(),
                                                userId: userId,
                                                title:
                                                    myController1.text.trim(),
                                                description:
                                                    myController2.text.trim(),
                                                state: false,
                                                creationDate: DateTime.now(),
                                                dateForTheTask: _date,
                                                hourForTheTask:
                                                    myController4.text.trim()));
                                        /*addTasksToFirebase();*/
                                      }
                                    },
                                  )
                                ],
                              )
                            ]));
                      }, listener: (context, taskState) {
                        if (taskState is TaskAdded) {
                          setState(() {
                            myController1.text = '';
                            myController2.text = '';
                            myController3.text = '';
                            myController4.text = '';
                            myController5.text = '';
                          });
                          context.read<TaskCubit>().getTask(
                              widget.client, DateTime.now().day, userId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Task added successfully')),
                          );
                        }
                      })
                    : BlocConsumer<BoardCubit, BoardState>(
                        builder: (context, boardState) {
                        return Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Board : ',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(5, 4, 43, 1))),
                                    Container(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Color.fromRGBO(5, 4, 43, 1)),
                                      controller: myController6,
                                      cursorColor:
                                          const Color.fromRGBO(5, 4, 43, 1),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your board name';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.category,
                                            color: Color.fromRGBO(5, 4, 43, 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    5, 4, 43, 1)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    5, 4, 43, 1)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          )),
                                    ),
                                    Container(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Color : ',
                                      style: TextStyle(
                                          color: Color.fromRGBO(5, 4, 43, 1)),
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      controller: myController7,
                                      cursorColor:
                                          const Color.fromRGBO(5, 4, 43, 1),
                                      decoration: InputDecoration(
                                          prefixIcon: IconButton(
                                              onPressed: () =>
                                                  pickColor(context),
                                              icon: const Icon(Icons.color_lens,
                                                  color: Color.fromRGBO(
                                                      5, 4, 43, 1))),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    5, 4, 43, 1)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    5, 4, 43, 1)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          hintText: pickerColor.toString(),
                                          hintStyle:
                                              TextStyle(color: pickerColor)),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 20,
                                ),
                                InkWell(
                                  child: Container(
                                      width: 120,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(5, 4, 43, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Center(
                                        child: Text(
                                          'Add Board',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      final String color =
                                          ColorParser.color(pickerColor)
                                              .toHex();
                                      context.read<BoardCubit>().addBoard(
                                          widget.client,
                                          BoardModel(
                                              id: "id",
                                              userId: userId,
                                              title: myController6.text.trim(),
                                              color: color));
                                    }
                                  },
                                )
                              ],
                            ));
                      }, listener: (context, boardState) {
                        if (boardState is BoardAdded) {
                          setState(() {
                            myController6.text = '';
                            myController7.text = '';
                            pickerColor = Colors.transparent;
                          });
                          context
                              .read<BoardCubit>()
                              .getBoard(widget.client, userId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Board added successfully')),
                          );
                        }
                      })
              ],
            )),
      ),
    );
  }

/*
  Stream<List<Board_Model>> readBoards() => FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.id)
      .collection('boards')
      .orderBy("titre")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Board_Model.fromJson(doc.data()))
          .toList());
*/
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future pickColor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              /*child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              ),*/
              // Use Material color picker:
              //
              /*child: MaterialPicker(
                 pickerColor: pickerColor,
                 onColorChanged: changeColor,
                 //showLabel: true, // only on portrait mode
               ),*/
              //
              // Use Block color picker:
              //
              child: BlockPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
              ),
              //
              /*child: MultipleChoiceBlockPicker(
                 pickerColors: currentColors,
                 onColorsChanged: changeColors,
               ),*/
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  setState(() => currentColor = pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
