import 'package:task_manager/data/models/board.dart';

class BoardAndUsers {
  final BoardModel boardModel;
  final List<String> listOfUsersPhoto;

  const BoardAndUsers(
      {required this.boardModel, required this.listOfUsersPhoto});
}
