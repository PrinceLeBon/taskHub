class BoardsUsers {
  late String id;
  late String boardId;
  late String userId;

  BoardsUsers({required this.id, required this.boardId, required this.userId});

  Map<String, dynamic> toMap() => {
        'id': id,
        'boardId': boardId,
        'userId': userId,
      };

  static BoardsUsers fromMap(Map<String, dynamic> json) => BoardsUsers(
        id: json['id'],
        boardId: json['boardId'],
        userId: json['userId'],
      );
}
