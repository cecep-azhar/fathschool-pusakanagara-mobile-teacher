import 'dart:convert';

class MobileNotificationResponseModel {
    final String? status;
    final List<Datum>? data;

    MobileNotificationResponseModel({
        this.status,
        this.data,
    });

    factory MobileNotificationResponseModel.fromJson(String str) => MobileNotificationResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MobileNotificationResponseModel.fromMap(Map<String, dynamic> json) => MobileNotificationResponseModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    final int? id;
    final String? title;
    final String? message;
    final String? token;
    final String? status;
    final String? sendAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Datum({
        this.id,
        this.title,
        this.message,
        this.token,
        this.status,
        this.sendAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        token: json["token"],
        status: json["status"],
        sendAt: json["send_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "message": message,
        "token": token,
        "status": status,
        "send_at": sendAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
