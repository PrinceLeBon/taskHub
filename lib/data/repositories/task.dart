import 'package:logger/logger.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:task_manager/data/models/tasks_and_user_list.dart';
import '../models/boards_users.dart';
import '../models/task.dart';
import '../providers/task.dart';
import 'list_user_in_a_board.dart';

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

  Future<List<String>> getBoardIdFromBoardsUsersCollection(
      Appwrite.Client client, String userId) async {
    List<String> boardIdFromBoardsUsersCollectionList = [];
    try {
      final AppwriteModels.DocumentList documentsListFromBoardsUsers =
          await taskAPI.getBoardIdFromBoardsUsersCollection(client, userId);
      final List<BoardsUsers> boardsUsersList = documentsListFromBoardsUsers
          .documents
          .map((document) => BoardsUsers.fromMap(document.data))
          .toList();
      boardIdFromBoardsUsersCollectionList = boardsUsersList
          .expand((boardsUsers) => [boardsUsers.boardId])
          .toList();
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "REPOSITORY || Error while getBoardIdFromBoardsUsersCollection: $e");
    }
    return boardIdFromBoardsUsersCollectionList;
  }

  Future<List<TaskAndUsers>> getTaskOfTheDay(
      Appwrite.Client client, int day, String userId) async {
    List<TaskModel> taskModelList = [];
    List<TaskAndUsers> taskAndUsersList = [];
    try {
      final ListUserInBoardRepository listUserInBoardRepository =
          ListUserInBoardRepository();
      List<String> boardIdList =
          await getBoardIdFromBoardsUsersCollection(client, userId);
      final AppwriteModels.DocumentList documentsListFromTask =
          await taskAPI.getTaskOfTheDay(client, day, boardIdList);
      taskModelList = documentsListFromTask.documents
          .map((document) => TaskModel.fromMap(document.data))
          .toList()
          .reversed
          .toList();
      for (TaskModel taskModel in taskModelList) {
        final List<String> listOfUserOfTheBoard =
            await listUserInBoardRepository.getListUser(
                client, taskModel.boardId);
        taskAndUsersList.add(TaskAndUsers(
            taskModel: taskModel, listOfUsersPhoto: listOfUserOfTheBoard));
      }
      /*List<String> tasksDocumentIdToListen = taskModelList
          .expand((taskModel) =>
              ["databases.TaskHub.collections.tasks.documents.${taskModel.id}"])
          .toList();
      subscribeRealTimeForTasks(client, tasksDocumentIdToListen, taskModelList);*/
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while getTaskOfTheDay: $e");
    }
    return taskAndUsersList;
  }

/*void subscribeRealTimeForTasks(Appwrite.Client client,
      List<String> tasksDocumentIdToListen, List<TaskModel> taskModelList) {
    try {
      taskAPI.subscribeRealTimeForTasks(
          client, tasksDocumentIdToListen, taskModelList);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while subscribeRealTimeForTasks: $e");
    }
  }*/
}
