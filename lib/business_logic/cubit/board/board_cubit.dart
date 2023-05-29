import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import '../../../data/models/board.dart';
import '../../../data/models/board_and_user_list.dart';
import '../../../data/repositories/board.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepository boardRepository;

  BoardCubit({required this.boardRepository}) : super(BoardInitial());

  Future addBoard(Client client, BoardModel boardModel) async {
    emit(AddingBoard());
    try {
      await boardRepository.addBoard(client, boardModel);
      emit(BoardAdded());
    } catch (e) {
      Logger().e("CUBIT || Error while adding board to database: $e");
      emit(AddingBoardFailed(
          error: "CUBIT || Error while adding board to database: $e"));
    }
  }

  Future updateBoard(Client client, BoardModel boardModel) async {
    emit(UpdatingBoard());
    try {
      await boardRepository.updateBoard(client, boardModel);
      emit(BoardUpdated());
    } catch (e) {
      Logger().e("CUBIT || Error while updating board in the database: $e");
      emit(UpdatingBoardFailed(
          error: "CUBIT || Error while updating board in the database: $e"));
    }
  }

  Future deleteBoard(Client client, String boardId) async {
    emit(DeletingBoard());
    try {
      await boardRepository.deleteBoard(client, boardId);
      emit(BoardDeleted());
    } catch (e) {
      Logger().e("CUBIT || Error while deleting board in the database: $e");
      emit(DeletingBoardFailed(
          error: "CUBIT || Error while deleting board in the database: $e"));
    }
  }

  Future getBoard(Client client, String userId) async {
    emit(LoadingBoard());
    try {
      final List<BoardAndUsers> boardAndUsersList =
          await boardRepository.getBoard(client, userId);
      emit(BoardLoaded(boardAndUsersList: boardAndUsersList));
    } catch (e) {
      Logger().e("CUBIT || Error while reading board in the database: $e");
      emit(LoadingBoardFailed(
          error: "CUBIT || Error while reading board in the database: $e"));
    }
  }

  Future addMoreUsersToBoard(String email, String boardId) async {
    emit(AddingMoreUser());
    try {
      final bool added =
          await boardRepository.addMoreUsersToBoard(email, boardId);
      emit(UserAdded(userAdded: added));
    } catch (e) {
      Logger().e("CUBIT || Error while addMoreUsersToBoard: $e");
      emit(AddingMoreUserFailed(
          error: "CUBIT || Error while addMoreUsersToBoard: $e"));
    }
  }
}
