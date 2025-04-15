class ActivityLogResponseModel {
  final int id;
  final int causerId;
  final String description;
  final DateTime createdAt;
  final String time;

  ActivityLogResponseModel({
    required this.id,
    required this.causerId,
    required this.description,
    required this.createdAt,
    required this.time,
  });

  factory ActivityLogResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogResponseModel(
      id: json['id'],
      causerId: json['causer_id'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      time: json['properties']['time'],
    );
  }
}
