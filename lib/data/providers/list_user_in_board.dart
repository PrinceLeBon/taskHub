import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import '../../utils/constants.dart';

class ListUserInBoardAPI {
  Future<appwrite_models.DocumentList> getListUserIdInUserBoardCollection(
      appwrite.Client client, String boardId) async {
    final databases = appwrite.Databases(client);
    final appwrite_models.DocumentList documentsListUserIdInUserBoardCollection =
        await databases.listDocuments(
            databaseId: databaseId,
            collectionId: boardsUsersCollectionId,
            queries: [
          appwrite.Query.equal('boardId', boardId),
        ]);
    return documentsListUserIdInUserBoardCollection;
  }

  Future<appwrite_models.DocumentList> getListUser(
      appwrite.Client client, List<String> userIdList) async {
    final databases = appwrite.Databases(client);
    final appwrite_models.DocumentList documentsListUser = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: userCollectionId,
            queries: [
          appwrite.Query.equal('id', userIdList),
        ]);
    return documentsListUser;
  }
}
