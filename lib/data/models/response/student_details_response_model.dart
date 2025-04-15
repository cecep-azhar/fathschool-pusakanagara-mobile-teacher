class StudentDetailsResponseModel {
  final int id;
  final String name;
  final String idReference;
  final String userName;
  final String email;
  final String role;
  final String phone;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String profilePhotoUrl;
  final String joinDate;

  StudentDetailsResponseModel({
    required this.id,
    required this.name,
    required this.idReference,
    required this.userName,
    required this.email,
    required this.role,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.profilePhotoUrl,
    required this.joinDate,
  });

  factory StudentDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentDetailsResponseModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '-',
      idReference: json['id_reference'] ?? '-',
      userName: json['username'] ?? '-',
      email: json['email'] ?? '-',
      role: json['role'] ?? '-',
      phone: json['phone'] ?? '-',
      address: json['address'] ?? '-',
      dateOfBirth: json['date_of_birth'] ?? '-',
      gender: json['gender'] ?? '-',
      profilePhotoUrl: json['profile_photo_url'] ?? '-',
      joinDate: json['join_date'] ?? '-',
    );
  }
}
