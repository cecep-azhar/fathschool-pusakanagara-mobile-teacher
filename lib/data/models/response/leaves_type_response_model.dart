class LeavesTypeResponseModel {
  final int id;
  final String roleType;
  final String name;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;

  LeavesTypeResponseModel({
    required this.id,
    required this.roleType,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LeavesTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return LeavesTypeResponseModel(
      id: json['id'] ?? 0,
      roleType: json['role_type'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
    );
  }
}
