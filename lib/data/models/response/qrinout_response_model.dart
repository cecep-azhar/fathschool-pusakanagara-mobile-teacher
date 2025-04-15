import 'dart:convert';

class QrInOutResponseModel {
  final String? message;
  final Attendance? attendance;
  final int? attendanceId;

  QrInOutResponseModel({
    this.message,
    this.attendance,
    this.attendanceId,
  });

  QrInOutResponseModel copyWith({
    String? message,
    Attendance? attendance,
    int? attendanceId,
  }) =>
      QrInOutResponseModel(
        message: message ?? this.message,
        attendance: attendance ?? this.attendance,
        attendanceId: attendanceId ?? this.attendanceId,
      );

  factory QrInOutResponseModel.fromJson(String str) =>
      QrInOutResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QrInOutResponseModel.fromMap(Map<String, dynamic> json) =>
      QrInOutResponseModel(
        message: json["message"],
        attendance: json["attendance"] == null
            ? null
            : Attendance.fromMap(json["attendance"]),
        attendanceId: json["attendance_id"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "attendance": attendance?.toMap(),
        "attendance_id": attendanceId,
      };
}

class Attendance {
  final int? userId;
  final int? classListsId;
  final String? qrCodeId;
  final DateTime? date;
  final String? timeIn;
  final String? uuid;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? latitude;
  final String? longitude;

  Attendance({
    this.userId,
    this.classListsId,
    this.qrCodeId,
    this.date,
    this.timeIn,
    this.uuid,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.latitude,
    this.longitude,
  });

  Attendance copyWith({
    int? userId,
    int? classListsId,
    String? qrCodeId,
    DateTime? date,
    String? timeIn,
    String? uuid,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    String? latitude,
    String? longitude,
  }) =>
      Attendance(
        userId: userId ?? this.userId,
        classListsId: classListsId ?? this.classListsId,
        date: date ?? this.date,
        timeIn: timeIn ?? this.timeIn,
        uuid: uuid ?? this.uuid,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Attendance.fromJson(String str) =>
      Attendance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        userId: json["user_id"],
        classListsId: json["course_id"],
        qrCodeId: json["qr_code_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeIn: json["time_in"],
        uuid: json["uuid"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "course_id": classListsId,
        "qr_code_id": qrCodeId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time_in": timeIn,
        "uuid": uuid,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
      };
}
