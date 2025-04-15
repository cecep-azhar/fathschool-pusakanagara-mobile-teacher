class ClassInfoResponseModel {
  final int id;
  final int classId;
  final int userId;
  final int absenNumber;
  final String name;
  final String className;
  final String userName;
  final int totalUser;

  ClassInfoResponseModel({
    required this.id,
    required this.classId,
    required this.userId,
    required this.absenNumber,
    required this.name,
    required this.className,
    required this.userName,
    required this.totalUser,
  });

  factory ClassInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return ClassInfoResponseModel(
      id: json['id'],
      classId: json['course'] != null ? json['course']['id'] : 0,
      userId: json['users'] != null ? json['users']['id'] : 0,
      absenNumber: json['users'] != null ? json['users']['absen_number'] : 0,
      name: json['name'],
      className: json['course'] != null ? json['course']['name'] : '',
      userName: json['users'] != null ? json['users']['name'] : '',
      totalUser: json['total_users'],
    );
  }
}
