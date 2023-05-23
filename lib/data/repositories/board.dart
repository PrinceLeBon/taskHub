import 'package:logger/logger.dart';
import 'package:task_manager/data/providers/board.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import '../models/board.dart';
import '../models/boards_users.dart';

class BoardRepository {
  final BoardAPI boardAPI = BoardAPI();

  Future<void> addBoard(Appwrite.Client client, BoardModel boardModel) async {
    try {
      await boardAPI.addBoard(client, boardModel);
      addToBoardUsersCollection(client, boardModel.userId, boardModel.id);
    } on Appwrite.AppwriteException catch (e) {
      Logger()
          .e("BOARD REPOSITORY || Error while adding board to database: $e");
    }
  }

  Future<void> addToBoardUsersCollection(
      Appwrite.Client client, String userId, String boardId) async {
    try {
      await boardAPI.addToBoardUsersCollection(client, userId, boardId);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while addToBoardUsersCollection board to database: $e");
    }
  }

  Future<void> updateBoard(
      Appwrite.Client client, BoardModel boardModel) async {
    try {
      await boardAPI.updateBoard(client, boardModel);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD REPOSITORY || Error while updating board in the database: $e");
    }
  }

  Future<void> deleteBoard(Appwrite.Client client, String boardId) async {
    try {
      await boardAPI.deleteBoard(client, boardId);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD REPOSITORY || Error while deleting board in the database: $e");
    }
  }

  Future<List<String>> getBoardIdFromBoardsUsersCollection(
      Appwrite.Client client, String userId) async {
    List<String> boardIdFromBoardsUsersCollectionList = [];
    try {
      final AppwriteModels.DocumentList documentsListFromBoardsUsers =
          await boardAPI.getBoardIdFromBoardsUsersCollection(client, userId);
      final List<BoardsUsers> boardsUsersList = documentsListFromBoardsUsers
          .documents
          .map((document) => BoardsUsers.fromMap(document.data))
          .toList();
      boardIdFromBoardsUsersCollectionList = boardsUsersList
          .expand((boardsUsers) => [boardsUsers.boardId])
          .toList();
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "BOARD REPOSITORY || Error while getBoardIdFromBoardsUsersCollection: $e");
    }
    return boardIdFromBoardsUsersCollectionList;
  }

  Future<List<BoardModel>> getBoard(
      Appwrite.Client client, String userId) async {
    List<BoardModel> boardModelList = [];
    try {
      List<String> boardIdList =
          await getBoardIdFromBoardsUsersCollection(client, userId);
      final AppwriteModels.DocumentList documentsListFromBoard =
          await boardAPI.getBoard(client, boardIdList);
      boardModelList = documentsListFromBoard.documents
          .map((document) => BoardModel.fromMap(document.data))
          .toList();
      List<String> boardDocumentIdToListen = boardModelList
          .expand((boardModel) => [
                "databases.TaskHub.collections.boards.documents.${boardModel.id}"
              ])
          .toList();
      subscribeRealTimeForBoards(
          client, boardDocumentIdToListen, boardModelList);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("BOARD REPOSITORY || Error while getTaskOfTheDay: $e");
    }
    return boardModelList;
  }

  void subscribeRealTimeForBoards(Appwrite.Client client,
      List<String> boardDocumentIdToListen, List<BoardModel> boardModelList) {
    try {
      boardAPI.subscribeRealTimeForBoards(
          client, boardDocumentIdToListen, boardModelList);
    } on Appwrite.AppwriteException catch (e) {
      Logger()
          .e("BOARD REPOSITORY || Error while subscribeRealTimeForTasks: $e");
    }
  }
}
