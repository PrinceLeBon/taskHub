import 'package:logger/logger.dart';
import 'package:task_manager/data/providers/listUserInBoard.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import '../models/boards_users.dart';
import '../models/user.dart';

class ListUserInBoardRepository {
  final ListUserInBoardAPI listUserInBoardAPI = ListUserInBoardAPI();

  Future<List<String>> getListUser(
      Appwrite.Client client, String boardId) async {
    List<String> userIdList = [];
    try {
      final List<String> listUserIdInUserBoardCollection =
          await getListUserIdInUserBoardCollection(client, boardId);
      final AppwriteModels.DocumentList documentUserList =
          await listUserInBoardAPI.getListUser(
              client, listUserIdInUserBoardCollection);
      final List<User> usersList = documentUserList.documents
          .map((document) => User.fromMap(document.data))
          .toList();
      userIdList = usersList.expand((user) => [user.photo]).toList();
    } on Appwrite.AppwriteException catch (e) {
      Logger()
          .e("LIST_USER_IN_A_BOARD REPOSITORY || Error while getListUser: $e");
    }
    return userIdList;
  }

  Future<List<String>> getListUserIdInUserBoardCollection(
      Appwrite.Client client, String boardId) async {
    List<String> boardIdFromBoardsUsersCollectionList = [];
    try {
      final AppwriteModels.DocumentList documentsListFromBoardsUsers =
          await listUserInBoardAPI.getListUserIdInUserBoardCollection(
              client, boardId);
      final List<BoardsUsers> boardsUsersList = documentsListFromBoardsUsers
          .documents
          .map((document) => BoardsUsers.fromMap(document.data))
          .toList();
      boardIdFromBoardsUsersCollectionList = boardsUsersList
          .expand((boardsUsers) => [boardsUsers.userId])
          .toList();
    } on Appwrite.AppwriteException catch (e) {
      Logger().e(
          "LIST_USER_IN_A_BOARD REPOSITORY || Error while getListUserIdInUserBoardCollection: $e");
    }
    return boardIdFromBoardsUsersCollectionList;
  }
}
