import 'package:logger/logger.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import '../models/task.dart';
import '../providers/task.dart';

class TaskRepository {
  final TaskAPI taskAPI = TaskAPI();

  Future<void> addTask(Appwrite.Client client, TaskModel taskModel) async {
    try {
      await taskAPI.addTask(client, taskModel);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while adding task to database: $e");
    }
  }

  Future<void> updateTask(Appwrite.Client client, TaskModel taskModel) async {
    try {
      await taskAPI.updateTask(client, taskModel);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while updating task in the database: $e");
    }
  }

  Future<void> deleteTask(Appwrite.Client client, String taskId) async {
    try {
      await taskAPI.deleteTask(client, taskId);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while deleting task in the database: $e");
    }
  }
}
