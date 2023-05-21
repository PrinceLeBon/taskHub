import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import '../../../data/models/board.dart';
import '../../../utils/constants.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardInitial());

  Future addBoard(Client client, BoardModel board) async {
    emit(AddingBoard());
    try {
      final Databases databases = Databases(client);
      final String documentId = ID.unique();
      board.id = documentId;

      await databases.createDocument(
          databaseId: databaseId,
          collectionId: boardCollectionId,
          documentId: documentId,
          data: board.toMap());

      emit(BoardAdded());
    } on AppwriteException catch (e) {
      Logger().e("Error while adding board to database: $e");
      emit(
          AddingBoardFailed(error: "Error while adding board to database: $e"));
    }
  }
}
