import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/data/models/board_and_user_list.dart';
import 'package:task_manager/data/providers/board.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:task_manager/data/repositories/list_user_in_a_board.dart';
import '../../utils/constants.dart';
import '../models/board.dart';
import '../models/boards_users.dart';
import '../models/user.dart';

class BoardRepository {
  final BoardAPI boardAPI = BoardAPI();

  Future<void> addBoard(appwrite.Client client, BoardModel boardModel) async {
    try {
      await boardAPI.addBoard(client, boardModel);
      addToBoardUsersCollection(client, boardModel.userId, boardModel.id);
    } catch (e) {
      Logger()
          .e("BOARD REPOSITORY || Error while adding board to database: $e");
      rethrow;
    }
  }

  Future<void> addToBoardUsersCollection(
      appwrite.Client client, String userId, String boardId) async {
    try {
      await boardAPI.addToBoardUsersCollection(client, userId, boardId);
    } catch (e) {
      Logger().e(
          "BOARD PROVIDER || Error while addToBoardUsersCollection board to database: $e");
      rethrow;
    }
  }

  Future<void> updateBoard(
      appwrite.Client client, BoardModel boardModel) async {
    try {
      await boardAPI.updateBoard(client, boardModel);
    } catch (e) {
      Logger().e(
          "BOARD REPOSITORY || Error while updating board in the database: $e");
      rethrow;
    }
  }

  Future<void> deleteBoard(appwrite.Client client, String boardId) async {
    try {
      await boardAPI.deleteBoard(client, boardId);
    } catch (e) {
      Logger().e(
          "BOARD REPOSITORY || Error while deleting board in the database: $e");
      rethrow;
    }
  }

  Future<List<String>> getBoardIdFromBoardsUsersCollection(
      appwrite.Client client, String userId) async {
    List<String> boardIdFromBoardsUsersCollectionList = [];
    try {
      final appwrite_models.DocumentList documentsListFromBoardsUsers =
          await boardAPI.getBoardIdFromBoardsUsersCollection(client, userId);
      final List<BoardsUsers> boardsUsersList = documentsListFromBoardsUsers
          .documents
          .map((document) => BoardsUsers.fromMap(document.data))
          .toList();
      boardIdFromBoardsUsersCollectionList = boardsUsersList
          .expand((boardsUsers) => [boardsUsers.boardId])
          .toList();
    } catch (e) {
      Logger().e(
          "BOARD REPOSITORY || Error while getBoardIdFromBoardsUsersCollection: $e");
      rethrow;
    }
    return boardIdFromBoardsUsersCollectionList;
  }

  Future<List<BoardAndUsers>> getBoard(
      appwrite.Client client, String userId) async {
    List<BoardModel> boardModelList = [];
    List<BoardAndUsers> boardAndUsersList = [];
    try {
      final ListUserInBoardRepository listUserInBoardRepository =
          ListUserInBoardRepository();
      List<String> boardIdList =
          await getBoardIdFromBoardsUsersCollection(client, userId);
      final appwrite_models.DocumentList documentsListFromBoard =
          await boardAPI.getBoard(client, boardIdList);
      boardModelList = documentsListFromBoard.documents
          .map((document) => BoardModel.fromMap(document.data))
          .toList()
          .reversed
          .toList();
      for (BoardModel boardModel in boardModelList) {
        final List<String> listOfUserOfTheBoard =
            await listUserInBoardRepository.getListUser(client, boardModel.id);
        boardAndUsersList.add(BoardAndUsers(
            boardModel: boardModel, listOfUsersPhoto: listOfUserOfTheBoard));
      }
      final Box boardAndUsersListBox = Hive.box("TaskHub");
      boardAndUsersListBox.put("boardAndUsersList", boardAndUsersList);
      /*List<String> boardDocumentIdToListen = boardModelList
          .expand((boardModel) => [
                "databases.TaskHub.collections.boards.documents.${boardModel.id}"
              ])
          .toList();
      subscribeRealTimeForBoards(
          client, boardDocumentIdToListen, boardModelList);*/
    } catch (e) {
      Logger().e("BOARD REPOSITORY || Error while getBoard: $e");
      rethrow;
    }
    return boardAndUsersList;
  }

  Future<String> verifyIfUserExists(String email) async {
    String userId = "id";
    try {
      final appwrite_models.DocumentList documentsListFromUser =
          await boardAPI.verifyIfUserExists(email);
      userId = User.fromMap(documentsListFromUser.documents.first.data).id;
    } catch (e) {
      Logger().e("BOARD REPOSITORY || Error while verifyIfUserExists: $e");
      rethrow;
    }
    return userId;
  }

  Future<bool> addMoreUsersToBoard(String email, String boardId) async {
    bool result = false;
    try {
      final String userId = await verifyIfUserExists(email);
      if (userId == "id") {
        throw Exception();
      }
      addToBoardUsersCollection(client, userId, boardId);
      result = true;
    } catch (e) {
      Logger().e("BOARD REPOSITORY || Error while addMoreUsersToBoard: $e");
      rethrow;
    }
    return result;
  }

/*void subscribeRealTimeForBoards(appwrite.Client client,
      List<String> boardDocumentIdToListen, List<BoardModel> boardModelList) {
    try {
      boardAPI.subscribeRealTimeForBoards(
          client, boardDocumentIdToListen, boardModelList);
    } catch (e) {
      Logger()
          .e("BOARD REPOSITORY || Error while subscribeRealTimeForTasks: $e");
                rethrow;
    }
  }*/
}
