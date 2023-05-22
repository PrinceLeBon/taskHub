import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:logger/logger.dart';
import '../../utils/constants.dart';
import '../models/board.dart';

class BoardAPI {
  Future<void> addBoard(Appwrite.Client client, BoardModel boardModel) async {
    try {
      final Appwrite.Databases databases = Appwrite.Databases(client);
      final String id = Appwrite.ID.unique();
      boardModel.id = id;
      //TODO View how to get color and idd
      /*
    board.couleur = ColorParser.color(pickerColor).toHex();
    board.idd = _docBoards.docs.length;
       */
      await databases.createDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: id,
          data: boardModel.toMap());
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("PROVIDER || Error while adding board to database: $e");
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
      Logger().e("PROVIDER || Error while updating board in the database: $e");
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
      Logger().e("PROVIDER || Error while deleting board in the database: $e");
    }
  }
}
