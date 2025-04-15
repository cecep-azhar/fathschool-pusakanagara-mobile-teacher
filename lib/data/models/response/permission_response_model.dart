class PermissionResponseModel {
  final int id;
  final int userId;
  final int leaveTypeId;
  final String title;
  final DateTime start;
  final DateTime end;
  final String status;
  final String description;
  final String rejectedCause;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String days;

  PermissionResponseModel({
    required this.id,
    required this.userId,
    required this.leaveTypeId,
    required this.title,
    required this.start,
    required this.end,
    required this.status,
    required this.description,
    required this.rejectedCause,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.days,
  });

  factory PermissionResponseModel.fromJson(Map<String, dynamic> json) {
    return PermissionResponseModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      leaveTypeId: json['leave_type_id'] ?? 0,
      title: json['title'] ?? '',
      start: DateTime.parse(json['start'] ?? ''),
      end: DateTime.parse(json['end'] ?? ''),
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      rejectedCause: json['rejected_cause'] ?? '',
      image: json['image'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
      days: json['days'] ?? '',
    );
  }
}
