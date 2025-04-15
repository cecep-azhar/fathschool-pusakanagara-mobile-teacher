import 'dart:convert';

class QrInOutRequestModel {
  final String? qrCodeId;
  final String? latitude;
  final String? longitude;

  QrInOutRequestModel({
    this.qrCodeId,
    this.latitude,
    this.longitude,
  });

  QrInOutRequestModel copyWith({
    String? qrCodeId,
    String? latitude,
    String? longitude,
  }) =>
      QrInOutRequestModel(
        qrCodeId: qrCodeId ?? this.qrCodeId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory QrInOutRequestModel.fromJson(String str) =>
      QrInOutRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QrInOutRequestModel.fromMap(Map<String, dynamic> json) =>
      QrInOutRequestModel(
        qrCodeId: json["qr_code_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "qr_code_id": qrCodeId,
        "latitude": latitude,
        "longitude": longitude,
      };
}
