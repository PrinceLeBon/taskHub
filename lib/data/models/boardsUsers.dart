class BoardsUsers {
  late String id;
  late String boardId;
  late String userId;

  BoardsUsers({required this.id, required this.boardId, required this.userId});

  static BoardsUsers fromMap(Map<String, dynamic> json) => BoardsUsers(
        id: json['id'],
        boardId: json['idBoard'],
        userId: json['idUser'],
      );
}
