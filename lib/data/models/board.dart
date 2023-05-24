class BoardModel {
  late String id;
  late String userId;
  late String title;
  late String color;

  BoardModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.color,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'color': color,
      };

  static BoardModel fromMap(Map<String, dynamic> json) => BoardModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        color: json['color'],
      );
}
