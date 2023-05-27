import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/board.dart';
import '../models/boards_users.dart';

class BoardAPI {
  Future<void> addBoard(appwrite.Client client, BoardModel boardModel) async {
    try {
      final String id = DateTime.now().millisecondsSinceEpoch.toString();
      boardModel.id = id;
      final appwrite.Databases databases = appwrite.Databases(client);
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: boardModel.id,
          data: boardModel.toMap());
    } on appwrite.AppwriteException catch (e) {
      Logger().e("BOARD PROVIDER || Error while adding board to database: $e");
    }
  }

  Future<void> addToBoardUsersCollection(
      appwrite.Client client, String userId, String boardId) async {
    try {
      final appwrite.Databases databases = appwrite.Databases(client);
      final String id = DateTime.now().millisecondsSinceEpoch.toString();
      BoardsUsers boardsUsers =
          BoardsUsers(id: id, boardId: boardId, userId: userId);
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: boardsUsersCollectionId,
          documentId: id,
          data: boardsUsers.toMap());
    } on appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while adding addToBoardUsersCollection to database: $e");
    }
  }

  Future<void> updateBoard(
      appwrite.Client client, BoardModel boardModel) async {
    try {
      final appwrite.Databases databases = appwrite.Databases(client);
      await databases.updateDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: boardModel.id,
          data: boardModel.toMap());
    } on appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while updating board in the database: $e");
    }
  }

  Future<void> deleteBoard(appwrite.Client client, String boardId) async {
    try {
      final appwrite.Databases databases = appwrite.Databases(client);
      await databases.deleteDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: boardId);
    } on appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while deleting board in the database: $e");
    }
  }

  Future<appwrite_models.DocumentList> getBoard(
      appwrite.Client client, List<String> boardIdList) async {
    final databases = appwrite.Databases(client);

    final appwrite_models.DocumentList documentsListFromTasks = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: boardCollectionId,
            queries: [
          appwrite.Query.equal('id', boardIdList),
        ]);
    return documentsListFromTasks;
  }

  Future<appwrite_models.DocumentList> getBoardIdFromBoardsUsersCollection(
      appwrite.Client client, String userId) async {
    final databases = appwrite.Databases(client);
    final appwrite_models.DocumentList documentsListFromBoard = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: boardsUsersCollectionId,
            queries: [
          appwrite.Query.equal('userId', userId),
        ]);
    return documentsListFromBoard;
  }

  /*void subscribeRealTimeForBoards(appwrite.Client client,
      List<String> boardsDocumentIdToListen, List<BoardModel> boardModelList) {
    final realtime = appwrite.Realtime(client);
    final subscription = realtime.subscribe(boardsDocumentIdToListen);
    Map<String, dynamic> item;

    subscription.stream.listen((response) {
      Logger().e(response.events);
      if (response.payload.isNotEmpty) {
        for (String event in response.events) {
          switch (event) {
            case "databases.TaskHub.collections.boards.documents.*.create":
              //add
              item = response.payload;
              BoardModel boardModel = BoardModel.fromMap(item);
              boardModelList.add(boardModel);
              break;
            case "databases.TaskHub.collections.boards.documents.*.delete":
              //delete
              Map<String, dynamic> item = response.payload;
              item = response.payload;
              BoardModel boardModel = BoardModel.fromMap(item);
              boardModelList
                  .removeWhere((element) => boardModel.id == element.id);
              break;
            default:
              //update
              item = response.payload;
              BoardModel boardModel = BoardModel.fromMap(item);
              int index = boardModelList
                  .indexWhere((element) => element.id == boardModel.id);
              boardModelList.removeAt(index);
              boardModelList.insert(index, boardModel);
              break;
          }
        }
      }
    });
  }*/
}
