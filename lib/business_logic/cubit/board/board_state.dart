part of 'board_cubit.dart';

@immutable
abstract class BoardState {
  const BoardState();
}

class BoardInitial extends BoardState {}

class AddingBoard extends BoardState {}

class BoardAdded extends BoardState {}

class AddingBoardFailed extends BoardState {
  final String error;

  const AddingBoardFailed({required this.error});
}

class UpdatingBoard extends BoardState {}

class BoardUpdated extends BoardState {}

class UpdatingBoardFailed extends BoardState {
  final String error;

  const UpdatingBoardFailed({required this.error});
}

class DeletingBoard extends BoardState {}

class BoardDeleted extends BoardState {}

class DeletingBoardFailed extends BoardState {
  final String error;

  const DeletingBoardFailed({required this.error});
}

class LoadingBoard extends BoardState {}

class BoardLoaded extends BoardState {
  final List<BoardAndUsers> boardAndUsersList;

  const BoardLoaded({required this.boardAndUsersList});
}

class LoadingBoardFailed extends BoardState {
  final String error;

  const LoadingBoardFailed({required this.error});
}

class AddingMoreUser extends BoardState {}

class UserAdded extends BoardState {
  final bool userAdded;

  const UserAdded({required this.userAdded});
}

class AddingMoreUserFailed extends BoardState {
  final String error;

  const AddingMoreUserFailed({required this.error});
}
