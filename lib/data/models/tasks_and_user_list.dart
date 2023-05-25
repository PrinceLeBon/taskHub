import 'package:task_manager/data/models/task.dart';

class TaskAndUsers {
  final TaskModel taskModel;
  final List<String> listOfUsersPhoto;

  const TaskAndUsers(
      {required this.taskModel, required this.listOfUsersPhoto});
}
