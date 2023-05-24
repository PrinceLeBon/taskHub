import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/board.dart';
import '../models/boards_users.dart';

class BoardAPI {
  Future<void> addBoard(Appwrite.Client client, BoardModel boardModel) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      final String id = DateTime.now().millisecondsSinceEpoch.toString();
      boardModel.id = id;
      //TODO View how to get color and idd
      /*

    board.idd = _docBoards.docs.length;
       */
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: id,
          data: boardModel.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("BOARD PROVIDER || Error while adding board to database: $e");
    }
  }

  Future<void> addToBoardUsersCollection(Appwrite.Client client, String userId, String boardId) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      final String id = Appwrite.ID.unique();
      BoardsUsers boardsUsers = BoardsUsers(id: id, boardId: boardId, userId: userId);
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: boardsUsersCollectionId,
          documentId: id,
          data: boardsUsers.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("BOARD PROVIDER || Error while adding board to database: $e");
    }
  }

  Future<void> updateBoard(
      Appwrite.Client client, BoardModel boardModel) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      await databases.updateDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: boardModel.id,
          data: boardModel.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while updating board in the database: $e");
    }
  }

  Future<void> deleteBoard(Appwrite.Client client, String boardId) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      await databases.deleteDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: boardId);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while deleting board in the database: $e");
    }
  }

  Future<AppwriteModels.DocumentList> getBoard(
      Appwrite.Client client, List<String> boardIdList) async {
    final databases = Appwrite.Databases(client);

    final AppwriteModels.DocumentList documentsListFromTasks = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: boardCollectionId,
            queries: [
          Appwrite.Query.equal('id', boardIdList),
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

  void subscribeRealTimeForBoards(Appwrite.Client client,
      List<String> boardsDocumentIdToListen, List<BoardModel> boardModelList) {
    final realtime = Appwrite.Realtime(client);
    final subscription = realtime.subscribe(boardsDocumentIdToListen);
    Map<String, dynamic> item;

    subscription.stream.listen((response) {
      if (response.payload.isNotEmpty) {
        Logger().e(response);
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
  }
}
