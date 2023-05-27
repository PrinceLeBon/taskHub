import 'package:hive/hive.dart';

part 'hive_adapters/task.g.dart';

@HiveType(typeId: 2)
class TaskModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String boardId;
  @HiveField(2)
  late String userId;
  @HiveField(3)
  late String title;
  @HiveField(4)
  late String description;
  @HiveField(5)
  late bool state;
  @HiveField(6)
  late DateTime creationDate;
  @HiveField(7)
  late DateTime dateForTheTask;
  @HiveField(8)
  late String hourForTheTask;

  TaskModel({
    required this.id,
    required this.boardId,
    required this.userId,
    required this.title,
    required this.description,
    required this.state,
    required this.creationDate,
    required this.dateForTheTask,
    required this.hourForTheTask,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'boardId': boardId,
        'userId': userId,
        'title': title,
        'description': description,
        'state': state,
        'creationDate': creationDate.millisecondsSinceEpoch,
        'dateForTheTask': dateForTheTask.millisecondsSinceEpoch,
        'hourForTheTask': hourForTheTask,
      };

  static TaskModel fromMap(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        boardId: json['boardId'],
        userId: json['userId'],
        title: json['title'],
        description: json['description'],
        state: json['state'],
        creationDate: DateTime.fromMillisecondsSinceEpoch(json['creationDate']),
        dateForTheTask:
            DateTime.fromMillisecondsSinceEpoch(json['dateForTheTask']),
        hourForTheTask: json['hourForTheTask'],
      );
}
