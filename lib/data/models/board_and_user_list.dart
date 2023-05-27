import 'package:task_manager/data/models/board.dart';
import 'package:hive/hive.dart';

part 'hive_adapters/board_and_user_list.g.dart';

@HiveType(typeId: 3)
class BoardAndUsers {
  @HiveField(0)
  final BoardModel boardModel;
  @HiveField(1)
  final List<String> listOfUsersPhoto;

  const BoardAndUsers(
      {required this.boardModel, required this.listOfUsersPhoto});
}
