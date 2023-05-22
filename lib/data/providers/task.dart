import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/task.dart';

class TaskAPI {
  Future<void> addTask(Appwrite.Client client, TaskModel taskModel) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      final String id = Appwrite.ID.unique();
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
}
