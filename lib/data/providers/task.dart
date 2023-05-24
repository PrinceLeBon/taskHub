import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/task.dart';

class TaskAPI {
  Future<void> addTask(Appwrite.Client client, TaskModel taskModel) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      final String id = DateTime.now().millisecondsSinceEpoch.toString();
      taskModel.id = id;
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: taskCollectionId,
          documentId: id,
          data: taskModel.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("PROVIDER || Error while adding Task to database: $e");
    }
  }

  Future<void> updateTask(Appwrite.Client client, TaskModel taskModel) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      await databases.updateDocument(
          databaseId: databaseId,
          collectionId: taskCollectionId,
          documentId: taskModel.id,
          data: taskModel.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("PROVIDER || Error while updating Task in the database: $e");
    }
  }

  Future<void> deleteTask(Appwrite.Client client, String taskId) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      await databases.deleteDocument(
          databaseId: databaseId,
          collectionId: taskCollectionId,
          documentId: taskId);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("PROVIDER || Error while deleting Task in the database: $e");
    }
  }

  Future<AppwriteModels.DocumentList> getTaskOfTheDay(
      Appwrite.Client client, int day, List<String> boardIdList) async {
    int initialNumberOfTasks = 0;

    DateTime dateOfToday = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);

    DateTime dateOfTargetDay =
        dateOfToday.add(Duration(days: day - dateOfToday.weekday));

    DateTime dateOfTargetDayLimit = dateOfToday
        .add(Duration(days: day - dateOfToday.weekday))
        .add(const Duration(days: 1));

    final databases = Appwrite.Databases(client);

    final AppwriteModels.DocumentList documentsListFromTasks = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: taskCollectionId,
            queries: [
          Appwrite.Query.equal('boardId', boardIdList),
          Appwrite.Query.equal("dateForTheTask", dateOfTargetDay.millisecondsSinceEpoch),
        ]);
    return documentsListFromTasks;
  }

  Future<AppwriteModels.DocumentList> getBoardIdFromBoardsUsersCollection(
      Appwrite.Client client, String userId) async {
    final databases = Appwrite.Databases(client);
    final AppwriteModels.DocumentList documentsListFromBoard = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: boardsUsersCollectionId,
            queries: [
          Appwrite.Query.equal('userId', userId),
        ]);
    return documentsListFromBoard;
  }

  /*void subscribeRealTimeForTasks(Appwrite.Client client,
      List<String> tasksDocumentIdToListen, List<TaskModel> taskModelList) {
    final realtime = Appwrite.Realtime(client);
    final subscription = realtime.subscribe(tasksDocumentIdToListen);
    Map<String, dynamic> item;

    subscription.stream.listen((response) {
      if (response.payload.isNotEmpty) {
        Logger().e(response);
        for (String event in response.events) {
          switch (event) {
            case "databases.TaskHub.collections.tasks.documents.*.create":
              //add
              item = response.payload;
              TaskModel taskModel = TaskModel.fromMap(item);
              taskModelList.add(taskModel);
              break;
            case "databases.TaskHub.collections.tasks.documents.*.delete":
              //delete
              Map<String, dynamic> item = response.payload;
              item = response.payload;
              TaskModel taskModel = TaskModel.fromMap(item);
              taskModelList
                  .removeWhere((element) => taskModel.id == element.id);
              break;
            default:
              //update
              item = response.payload;
              TaskModel taskModel = TaskModel.fromMap(item);
              int index = taskModelList
                  .indexWhere((element) => element.id == taskModel.id);
              taskModelList.removeAt(index);
              taskModelList.insert(index, taskModel);
              break;
          }
        }
      }
    });
  }*/
}
