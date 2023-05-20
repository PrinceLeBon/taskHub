class TaskModel {
  late String id;
  late String idBoard;
  late String idUser;
  late String title;
  late String description;
  late bool state;
  late DateTime creationDate;
  late DateTime dateForTheTask;
  late String hourForTheTask;

  TaskModel({
    required this.id,
    required this.idBoard,
    required this.idUser,
    required this.title,
    required this.description,
    required this.state,
    required this.creationDate,
    required this.dateForTheTask,
    required this.hourForTheTask,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idBoard': idBoard,
        'idUser': idUser,
        'title': title,
        'description': description,
        'state': state,
        'creationDate': creationDate,
        'dateForTheTask': dateForTheTask,
        'hourForTheTask': hourForTheTask,
      };

  static TaskModel fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        idBoard: json['idBoard'],
        idUser: json['idUser'],
        title: json['title'],
        description: json['description'],
        state: json['state'],
        creationDate: json['creationDate'],
        dateForTheTask: json['dateForTheTask'],
        hourForTheTask: json['hourForTheTask'],
      );
}
