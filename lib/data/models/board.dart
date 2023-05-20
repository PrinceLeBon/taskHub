class BoardModel {
  late String id;
  late String idUser;
  late String title;
  late String color;
  late List<String> listOfAssignee;
  late int idd;

  BoardModel({
    required this.id,
    required this.idUser,
    required this.title,
    required this.color,
    required this.listOfAssignee,
    required this.idd,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idUser': idUser,
        'title': title,
        'color': color,
        'listOfAssignee': listOfAssignee,
        'idd': idd,
      };

  static BoardModel fromJson(Map<String, dynamic> json) => BoardModel(
        id: json['id'],
        idUser: json['idUser'],
        title: json['title'],
        color: json['color'],
        listOfAssignee: List<String>.from(json['listOfAssignee']),
        idd: json['idd'],
      );
}
