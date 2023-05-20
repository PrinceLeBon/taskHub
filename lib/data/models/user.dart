class User {
  late String id;
  late String name;
  late String surname;
  late String photo;
  late String email;
  late String birthday;
  late String username;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.photo,
    required this.email,
    required this.birthday,
    required this.username,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'surname': surname,
        'photo': photo,
        'email': email,
        'birthday': birthday,
        'username': username
      };

  static User fromMap(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      photo: json['photo'],
      email: json['email'],
      birthday: json['birthday'],
      username: json['username']);
}
