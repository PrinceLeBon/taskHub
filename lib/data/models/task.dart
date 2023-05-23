class TaskModel {
  late String id;
  late String boardId;
  late String userId;
  late String title;
  late String description;
  late bool state;
  late DateTime creationDate;
  late DateTime dateForTheTask;
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
        'creationDate': creationDate,
        'dateForTheTask': dateForTheTask,
        'hourForTheTask': hourForTheTask,
      };

  static TaskModel fromMap(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        boardId: json['boardId'],
        userId: json['userId'],
        title: json['title'],
        description: json['description'],
        state: json['state'],
        creationDate: json['creationDate'],
        dateForTheTask: json['dateForTheTask'],
        hourForTheTask: json['hourForTheTask'],
      );
}
