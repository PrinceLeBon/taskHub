import 'package:logger/logger.dart';
import 'package:task_manager/data/providers/board.dart';
import 'package:appwrite/appwrite.dart' as Appwrite;
import 'package:appwrite/models.dart' as AppwriteModels;
import '../models/board.dart';

class BoardRepository {
  final BoardAPI boardAPI = BoardAPI();

  Future<void> addBoard(
      Appwrite.Client client, BoardModel boardModel) async {
    try {
      await boardAPI.addBoard(client, boardModel);
    } on Appwrite.AppwriteException catch (e) {
      Logger().e("REPOSITORY || Error while adding board to database: $e");
    }
  }

  Future<void> updateBoard(
      Appwrite.Client client, BoardModel boardModel) async {
    try {
      await boardAPI.updateBoard(client, boardModel);
    } on Appwrite.AppwriteException catch (e) {
      Logger()
          .e("REPOSITORY || Error while updating board in the database: $e");
    }
  }

  Future<void> deleteBoard(Appwrite.Client client, String boardId) async {
    try {
      await boardAPI.deleteBoard(client, boardId);
    } on Appwrite.AppwriteException catch (e) {
      Logger()
          .e("REPOSITORY || Error while deleting board in the database: $e");
    }
  }
}
