import 'package:logger/logger.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import '../models/boards_users.dart';
import '../models/user.dart';
import '../providers/list_user_in_board.dart';

class ListUserInBoardRepository {
  final ListUserInBoardAPI listUserInBoardAPI = ListUserInBoardAPI();

  Future<List<String>> getListUser(
      appwrite.Client client, String boardId) async {
    List<String> userIdList = [];
    try {
      final List<String> listUserIdInUserBoardCollection =
          await getListUserIdInUserBoardCollection(client, boardId);
      final appwrite_models.DocumentList documentUserList =
          await listUserInBoardAPI.getListUser(
              client, listUserIdInUserBoardCollection);
      final List<User> usersList = documentUserList.documents
          .map((document) => User.fromMap(document.data))
          .toList();
      userIdList = usersList.expand((user) => [user.photo]).toList();
    } on appwrite.AppwriteException catch (e) {
      Logger()
          .e("LIST_USER_IN_A_BOARD REPOSITORY || Error while getListUser: $e");
    }
    return userIdList;
  }

  Future<List<String>> getListUserIdInUserBoardCollection(
      appwrite.Client client, String boardId) async {
    List<String> boardIdFromBoardsUsersCollectionList = [];
    try {
      final appwrite_models.DocumentList documentsListFromBoardsUsers =
          await listUserInBoardAPI.getListUserIdInUserBoardCollection(
              client, boardId);
      final List<BoardsUsers> boardsUsersList = documentsListFromBoardsUsers
          .documents
          .map((document) => BoardsUsers.fromMap(document.data))
          .toList();
      boardIdFromBoardsUsersCollectionList = boardsUsersList
          .expand((boardsUsers) => [boardsUsers.userId])
          .toList();
    } on appwrite.AppwriteException catch (e) {
      Logger().e(
          "LIST_USER_IN_A_BOARD REPOSITORY || Error while getListUserIdInUserBoardCollection: $e");
    }
    return boardIdFromBoardsUsersCollectionList;
  }
}
