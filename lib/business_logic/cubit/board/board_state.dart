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
