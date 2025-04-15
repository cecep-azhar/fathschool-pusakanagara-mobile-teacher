import 'dart:convert';

class SchoolResponseModel {
  final Setting? setting;

  SchoolResponseModel({
    this.setting,
  });

  SchoolResponseModel copyWith({
    Setting? setting,
  }) =>
      SchoolResponseModel(
        setting: setting ?? this.setting,
      );

  factory SchoolResponseModel.fromJson(String str) =>
      SchoolResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SchoolResponseModel.fromMap(Map<String, dynamic> json) =>
      SchoolResponseModel(
        setting:
            json["setting"] == null ? null : Setting.fromMap(json["setting"]),
      );

  Map<String, dynamic> toMap() => {
        "setting": setting?.toMap(),
      };
}

class Setting {
  final int? id;
  final String? appLogoType;
  final String? textLogoName;
  final String? appName;
  final String? schoolCode;
  final String? darkLogo;
  final String? lightLogo;
  final String? faviconIcon;
  final String? productionStatus;
  final String? appDescription;
  final String? principalName;
  final String? appAddress;
  final String? appEmail;
  final String? appPhone;
  final String? appCurrency;
  final String? keyToGrades;
  final String? gradeSummary;
  final int? overDueDays;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? radius;
  final String? latitude;
  final String? longtitude;
  final dynamic timeIn;
  final dynamic timeOut;
  final String? darkLogoUrl;
  final String? lightLogoUrl;
  final String? faviconIconUrl;
  final String? linkGooglePlay;

  Setting({
    this.id,
    this.appLogoType,
    this.textLogoName,
    this.appName,
    this.schoolCode,
    this.darkLogo,
    this.lightLogo,
    this.faviconIcon,
    this.productionStatus,
    this.appDescription,
    this.principalName,
    this.appAddress,
    this.appEmail,
    this.appPhone,
    this.appCurrency,
    this.keyToGrades,
    this.gradeSummary,
    this.overDueDays,
    this.createdAt,
    this.updatedAt,
    this.radius,
    this.latitude,
    this.longtitude,
    this.timeIn,
    this.timeOut,
    this.darkLogoUrl,
    this.lightLogoUrl,
    this.faviconIconUrl,
    this.linkGooglePlay,
  });

  Setting copyWith({
    int? id,
    String? appLogoType,
    String? textLogoName,
    String? appName,
    String? schoolCode,
    String? darkLogo,
    String? lightLogo,
    String? faviconIcon,
    String? productionStatus,
    String? appDescription,
    String? principalName,
    String? appAddress,
    String? appEmail,
    String? appPhone,
    String? appCurrency,
    String? keyToGrades,
    String? gradeSummary,
    int? overDueDays,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? radius,
    String? latitude,
    String? longtitude,
    dynamic timeIn,
    dynamic timeOut,
    String? darkLogoUrl,
    String? lightLogoUrl,
    String? faviconIconUrl,
    String? linkGooglePlay,
  }) =>
      Setting(
        id: id ?? this.id,
        appLogoType: appLogoType ?? this.appLogoType,
        textLogoName: textLogoName ?? this.textLogoName,
        appName: appName ?? this.appName,
        schoolCode: schoolCode ?? this.schoolCode,
        darkLogo: darkLogo ?? this.darkLogo,
        lightLogo: lightLogo ?? this.lightLogo,
        faviconIcon: faviconIcon ?? this.faviconIcon,
        productionStatus: productionStatus ?? this.productionStatus,
        appDescription: appDescription ?? this.appDescription,
        principalName: principalName ?? this.principalName,
        appAddress: appAddress ?? this.appAddress,
        appEmail: appEmail ?? this.appEmail,
        appPhone: appPhone ?? this.appPhone,
        appCurrency: appCurrency ?? this.appCurrency,
        keyToGrades: keyToGrades ?? this.keyToGrades,
        gradeSummary: gradeSummary ?? this.gradeSummary,
        overDueDays: overDueDays ?? this.overDueDays,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        radius: radius ?? this.radius,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude,
        timeIn: timeIn ?? this.timeIn,
        timeOut: timeOut ?? this.timeOut,
        darkLogoUrl: darkLogoUrl ?? this.darkLogoUrl,
        lightLogoUrl: lightLogoUrl ?? this.lightLogoUrl,
        faviconIconUrl: faviconIconUrl ?? this.faviconIconUrl,
        linkGooglePlay: linkGooglePlay ?? this.linkGooglePlay,
      );

  factory Setting.fromJson(String str) => Setting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        id: json["id"],
        appLogoType: json["app_logo_type"],
        textLogoName: json["text_logo_name"],
        appName: json["app_name"],
        schoolCode: json["school_code"],
        darkLogo: json["dark_logo"],
        lightLogo: json["light_logo"],
        faviconIcon: json["favicon_icon"],
        productionStatus: json["production_status"],
        appDescription: json["app_description"],
        principalName: json["principal_name"],
        appAddress: json["app_address"],
        appEmail: json["app_email"],
        appPhone: json["app_phone"],
        appCurrency: json["app_currency"],
        keyToGrades: json["key_to_grades"],
        gradeSummary: json["grade_summary"],
        overDueDays: json["over_due_days"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        radius: json["radius"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        darkLogoUrl: json["dark_logo_url"],
        lightLogoUrl: json["light_logo_url"],
        faviconIconUrl: json["favicon_icon_url"],
        linkGooglePlay: json["link_google_play"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "app_logo_type": appLogoType,
        "text_logo_name": textLogoName,
        "app_name": appName,
        "school_code": schoolCode,
        "dark_logo": darkLogo,
        "light_logo": lightLogo,
        "favicon_icon": faviconIcon,
        "production_status": productionStatus,
        "app_description": appDescription,
        "principal_name": principalName,
        "app_address": appAddress,
        "app_email": appEmail,
        "app_phone": appPhone,
        "app_currency": appCurrency,
        "key_to_grades": keyToGrades,
        "grade_summary": gradeSummary,
        "over_due_days": overDueDays,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "radius": radius,
        "latitude": latitude,
        "longtitude": longtitude,
        "time_in": timeIn,
        "time_out": timeOut,
        "dark_logo_url": darkLogoUrl,
        "light_logo_url": lightLogoUrl,
        "favicon_icon_url": faviconIconUrl,
        "link_google_play": linkGooglePlay,
      };
}
