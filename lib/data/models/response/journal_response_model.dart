class JournalResponseModel {
  final int id;
  final String courseId;
  final String courseName;
  final int userId;
  final String description;
  final DateTime date;
  final String time;
  final String img;
  final String securityCode;
  final DateTime securityCodeExpiration;

  JournalResponseModel({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.userId,
    required this.description,
    required this.date,
    required this.time,
    required this.img,
    required this.securityCode,
    required this.securityCodeExpiration,
  });

  factory JournalResponseModel.fromJson(Map<String, dynamic> json) {
    return JournalResponseModel(
      id: json['id'] ?? '0',
      courseId: json['course_id'] ?? '0',
      courseName: json['course_name'] ?? '',
      userId: json['user_id'] ?? '0',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date'] ?? ''),
      time: json['time'] ?? '',
      img: json['img'] ?? '',
      securityCode: json['security_code'] ?? '',
      securityCodeExpiration:
          DateTime.parse(json['security_code_expiration'] ?? ''),
    );
  }
}
