class InfoResponseModel {
  final int id;
  final int userId;
  final String title;
  final String slug;
  final String description;
  final String attachment;
  final String status;
  final String roles;
  final int pinned;
  final String time;
  final String publishAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  InfoResponseModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.slug,
    required this.description,
    required this.attachment,
    required this.status,
    required this.roles,
    required this.pinned,
    required this.time,
    required this.publishAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoResponseModel.fromJson(Map<String, dynamic> json) {
    return InfoResponseModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      attachment: json['attachment'] ?? '',
      status: json['status'] ?? '',
      roles: json['roles'] ?? '',
      pinned: json['pinned'] ?? 0,
      time: json['time'] ?? '',
      publishAt: json['publish_at'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
    );
  }
}
