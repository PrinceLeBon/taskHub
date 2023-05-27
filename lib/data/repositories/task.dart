import 'package:logger/logger.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:task_manager/data/models/tasks_and_user_list.dart';
import '../models/boards_users.dart';
import '../models/task.dart';
import '../providers/task.dart';
import 'list_user_in_a_board.dart';

class TaskRepository {
  final TaskAPI taskAPI = TaskAPI();

  Future<void> addTask(appwrite.Client client, TaskModel taskModel) async {
    try {
      await taskAPI.addTask(client, taskModel);
    } on appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while adding task to database: $e");
    }
  }

  Future<void> updateTask(appwrite.Client client, TaskModel taskModel) async {
    try {
      await taskAPI.updateTask(client, taskModel);
    } on appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while updating task in the database: $e");
    }
  }

  Future<void> deleteTask(appwrite.Client client, String taskId) async {
    try {
      await taskAPI.deleteTask(client, taskId);
    } on appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while deleting task in the database: $e");
    }
  }

  Future<List<String>> getBoardIdFromBoardsUsersCollection(
      appwrite.Client client, String userId) async {
    List<String> boardIdFromBoardsUsersCollectionList = [];
    try {
      final appwrite_models.DocumentList documentsListFromBoardsUsers =
          await taskAPI.getBoardIdFromBoardsUsersCollection(client, userId);
      final List<BoardsUsers> boardsUsersList = documentsListFromBoardsUsers
          .documents
          .map((document) => BoardsUsers.fromMap(document.data))
          .toList();
      boardIdFromBoardsUsersCollectionList = boardsUsersList
          .expand((boardsUsers) => [boardsUsers.boardId])
          .toList();
    } on appwrite.AppwriteException catch (e) {
      Logger().e(
          "REPOSITORY || Error while getBoardIdFromBoardsUsersCollection: $e");
    }
    return boardIdFromBoardsUsersCollectionList;
  }

  Future<List<TaskAndUsers>> getTaskOfTheDay(
      appwrite.Client client, int day, String userId) async {
    List<TaskModel> taskModelList = [];
    List<TaskAndUsers> taskAndUsersList = [];
    try {
      final ListUserInBoardRepository listUserInBoardRepository =
          ListUserInBoardRepository();
      List<String> boardIdList =
          await getBoardIdFromBoardsUsersCollection(client, userId);
      final appwrite_models.DocumentList documentsListFromTask =
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
    } on appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while getTaskOfTheDay: $e");
    }
    return taskAndUsersList;
  }

/*void subscribeRealTimeForTasks(appwrite.Client client,
      List<String> tasksDocumentIdToListen, List<TaskModel> taskModelList) {
    try {
      taskAPI.subscribeRealTimeForTasks(
          client, tasksDocumentIdToListen, taskModelList);
    } on appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while subscribeRealTimeForTasks: $e");
    }
  }*/
}
