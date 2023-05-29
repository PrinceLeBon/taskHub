import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import 'package:task_manager/data/models/tasks_and_user_list.dart';
import 'package:task_manager/data/models/user.dart';
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
      Logger().e("CUBIT || Error while updating Task in the database: $e");
      emit(UpdatingTaskFailed(
          error: "CUBIT || Error while updating Task in the database: $e"));
    }
  }

  Future deleteTask(Client client, String taskId) async {
    emit(DeletingTask());
    try {
      await taskRepository.deleteTask(client, taskId);
      emit(TaskDeleted());
    } on AppwriteException catch (e) {
      Logger().e("CUBIT || Error while deleting Task in the database: $e");
      emit(DeletingTaskFailed(
          error: "CUBIT || Error while deleting Task in the database: $e"));
    }
  }

  Future getTask(Client client, int day, String userId) async {
    emit(LoadingTask());
    try {
      final List<TaskAndUsers> taskAndUsersList =
          await taskRepository.getTaskOfTheDay(client, day, userId);
      emit(TaskLoaded(taskAndUsersList: taskAndUsersList));
    } on AppwriteException catch (e) {
      Logger().e("CUBIT || Error while reading Task in the database: $e");
      emit(LoadingTaskFailed(
          error: "CUBIT || Error while reading Task in the database: $e"));
    }
  }

  Future getCreatorOfATaskInfos(String userId) async {
    emit(CreatorGetting());
    try {
      final User user = await taskRepository.getCreatorOfATaskInfos(userId);
      emit(CreatorGotten(user: user));
    } on AppwriteException catch (e) {
      Logger().e("CUBIT || Error while getting creator of a task: $e");
      emit(CreatorGettingFailed(
          error: "CUBIT || Error while getting creator of a task: $e"));
    }
  }
}
