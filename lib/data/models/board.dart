class BoardModel {
  late String id;
  late String userId;
  late String title;
  late String color;
  late int idd;

  BoardModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.color,
    required this.idd,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'color': color,
        'idd': idd,
      };

  static BoardModel fromMap(Map<String, dynamic> json) => BoardModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        color: json['color'],
        idd: json['idd'],
      );
}
