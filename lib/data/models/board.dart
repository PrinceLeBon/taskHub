import 'package:hive/hive.dart';

part 'hive_adapters/board.g.dart';

@HiveType(typeId: 1)
class BoardModel {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String userId;
  @HiveField(2)
  late String title;
  @HiveField(3)
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
