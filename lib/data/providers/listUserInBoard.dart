import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import '../../utils/constants.dart';

class ListUserInBoardAPI {
  Future<AppwriteModels.DocumentList> getListUserIdInUserBoardCollection(
      Appwrite.Client client, String boardId) async {
    final databases = Appwrite.Databases(client);
    final AppwriteModels.DocumentList documentsListUserIdInUserBoardCollection =
        await databases.listDocuments(
            databaseId: databaseId,
            collectionId: boardsUsersCollectionId,
            queries: [
          Appwrite.Query.equal('boardId', boardId),
        ]);
    return documentsListUserIdInUserBoardCollection;
  }

  Future<AppwriteModels.DocumentList> getListUser(
      Appwrite.Client client, List<String> userIdList) async {
    final databases = Appwrite.Databases(client);
    final AppwriteModels.DocumentList documentsListUser = await databases
        .listDocuments(
            databaseId: databaseId,
            collectionId: userCollectionId,
            queries: [
          Appwrite.Query.equal('id', userIdList),
        ]);
    return documentsListUser;
  }
}
