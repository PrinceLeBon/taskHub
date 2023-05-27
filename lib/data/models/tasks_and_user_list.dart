import 'package:task_manager/data/models/task.dart';
import 'package:hive/hive.dart';

part 'hive_adapters/tasks_and_user_list.g.dart';

@HiveType(typeId: 4)
class TaskAndUsers {
  @HiveField(0)
  final TaskModel taskModel;
  @HiveField(1)
  final List<String> listOfUsersPhoto;

  const TaskAndUsers({required this.taskModel, required this.listOfUsersPhoto});
}
