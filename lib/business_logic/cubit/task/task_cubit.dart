import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository taskRepository;

  TaskCubit({required this.taskRepository}) : super(TaskInitial());

  Future addTasks(Client client, TaskModel taskModel) async {
    emit(AddingTask());
    try {
      await taskRepository.addTask(client, taskModel);
      emit(TaskAdded());
    } on AppwriteException catch (e) {
      Logger().e("Error while adding task to database: $e");
      emit(AddingTaskFailed(error: "Error while adding task to database: $e"));
    }
  }

  Future updateTask(Client client, TaskModel taskModel) async {
    emit(UpdatingTask());
    try {
      await taskRepository.updateTask(client, taskModel);
      emit(TaskUpdated());
    } on AppwriteException catch (e) {
      Logger().e("CUBBIT || Error while updating Task in the database: $e");
      emit(UpdatingTaskFailed(
          error: "CUBBIT || Error while updating Task in the database: $e"));
    }
  }

  Future deleteTask(Client client, String taskId) async {
    emit(DeletingTask());
    try {
      await taskRepository.deleteTask(client, taskId);
      emit(TaskDeleted());
    } on AppwriteException catch (e) {
      Logger().e("CUBBIT || Error while deleting Task in the database: $e");
      emit(DeletingTaskFailed(
          error: "CUBBIT || Error while deleting Task in the database: $e"));
    }
  }

  Future getTask(Client client, int day, String userId) async {
    emit(LoadingTask());
    try {
      await taskRepository.getTaskOfTheDay(client, day, userId);
      emit(TaskLoaded());
    } on AppwriteException catch (e) {
      Logger().e("CUBBIT || Error while reading Task in the database: $e");
      emit(LoadingTaskFailed(
          error: "CUBBIT || Error while reading Task in the database: $e"));
    }
  }
}
