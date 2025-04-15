import 'dart:convert';

class AuthResponseModel {
    final User? user;
    final String? token;

    AuthResponseModel({
        this.user,
        this.token,
    });

    AuthResponseModel copyWith({
        User? user,
        String? token,
    }) => 
        AuthResponseModel(
            user: user ?? this.user,
            token: token ?? this.token,
        );

    factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "token": token,
    };
}

class User {
    final int? id;
    final String? name;
    final String? username;
    final String? email;
    final String? role;
    final DateTime? emailVerifiedAt;
    final dynamic twoFactorConfirmedAt;
    final dynamic rememberToken;
    final dynamic fcmToken;
    final dynamic currentTeamId;
    final dynamic profilePhotoPath;
    final int? status;
    final String? phone;
    final String? address;
    final dynamic departmentId;
    final DateTime? dateOfBirth;
    final String? gender;
    final int? accountHold;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? tourCompleted;
    final dynamic faceEmbedding;
    final dynamic idReference;
    final dynamic department;
    final String? profilePhotoUrl;
    final String? joinDate;

    User({
        this.id,
        this.name,
        this.username,
        this.email,
        this.role,
        this.emailVerifiedAt,
        this.twoFactorConfirmedAt,
        this.rememberToken,
        this.fcmToken,
        this.currentTeamId,
        this.profilePhotoPath,
        this.status,
        this.phone,
        this.address,
        this.departmentId,
        this.dateOfBirth,
        this.gender,
        this.accountHold,
        this.createdAt,
        this.updatedAt,
        this.tourCompleted,
        this.faceEmbedding,
        this.idReference,
        this.department,
        this.profilePhotoUrl,
        this.joinDate,
    });

    User copyWith({
        int? id,
        String? name,
        String? username,
        String? email,
        String? role,
        DateTime? emailVerifiedAt,
        dynamic twoFactorConfirmedAt,
        dynamic rememberToken,
        dynamic fcmToken,
        dynamic currentTeamId,
        dynamic profilePhotoPath,
        int? status,
        String? phone,
        String? address,
        dynamic departmentId,
        DateTime? dateOfBirth,
        String? gender,
        int? accountHold,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? tourCompleted,
        dynamic faceEmbedding,
        dynamic idReference,
        dynamic department,
        String? profilePhotoUrl,
        String? joinDate,
    }) => 
        User(
            id: id ?? this.id,
            name: name ?? this.name,
            username: username ?? this.username,
            email: email ?? this.email,
            role: role ?? this.role,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            twoFactorConfirmedAt: twoFactorConfirmedAt ?? this.twoFactorConfirmedAt,
            rememberToken: rememberToken ?? this.rememberToken,
            fcmToken: fcmToken ?? this.fcmToken,
            currentTeamId: currentTeamId ?? this.currentTeamId,
            profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
            status: status ?? this.status,
            phone: phone ?? this.phone,
            address: address ?? this.address,
            departmentId: departmentId ?? this.departmentId,
            dateOfBirth: dateOfBirth ?? this.dateOfBirth,
            gender: gender ?? this.gender,
            accountHold: accountHold ?? this.accountHold,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            tourCompleted: tourCompleted ?? this.tourCompleted,
            faceEmbedding: faceEmbedding ?? this.faceEmbedding,
            idReference: idReference ?? this.idReference,
            department: department ?? this.department,
            profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
            joinDate: joinDate ?? this.joinDate,
        );

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        rememberToken: json["remember_token"],
        fcmToken: json["fcm_token"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        status: json["status"],
        phone: json["phone"],
        address: json["address"],
        departmentId: json["department_id"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        accountHold: json["account_hold"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        tourCompleted: json["tour_completed"],
        faceEmbedding: json["face_embedding"],
        idReference: json["id_reference"],
        department: json["department"],
        profilePhotoUrl: json["profile_photo_url"],
        joinDate: json["join_date"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "role": role,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "remember_token": rememberToken,
        "fcm_token": fcmToken,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "status": status,
        "phone": phone,
        "address": address,
        "department_id": departmentId,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "account_hold": accountHold,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "tour_completed": tourCompleted,
        "face_embedding": faceEmbedding,
        "id_reference": idReference,
        "department": department,
        "profile_photo_url": profilePhotoUrl,
        "join_date": joinDate,
    };
}
