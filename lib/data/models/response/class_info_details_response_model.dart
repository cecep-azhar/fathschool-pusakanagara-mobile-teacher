class ClassInfoDetailsResponseModel {
  final int classId;
  final String className;
  final List<UserInfo> users;

  ClassInfoDetailsResponseModel({
    required this.classId,
    required this.className,
    required this.users,
  });

  factory ClassInfoDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    var usersFromJson = json['users'] as List;
    List<UserInfo> usersList = usersFromJson.map((user) => UserInfo.fromJson(user)).toList();

    return ClassInfoDetailsResponseModel(
      classId: json['course']['id'],
      className: json['course']['name'],
      users: usersList,
    );
  }
}

class UserInfo {
  final int userId;
  final int absenNumber;
  final String userName;

  UserInfo({
    required this.userId,
    required this.absenNumber,
    required this.userName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['id'],
      absenNumber: json['absen_number'],
      userName: json['name'],
    );
  }
}
