import 'dart:convert';

class SettingMobileResponse {
    final int? id;
    final String? logoFathschool;
    final String? descriptionApps;
    final String? featuresApps;
    final String? advantagesApps;
    final String? conclusionApps;
    final String? fathforcePhoneNumber;
    final String? fathforceBrowserLink;
    final String? fathforceEmail;
    final String? logoFathforce;
    final String? logoSchool;
    final String? googlePlayLinkStudent;
    final String? googlePlayLinkTeacher;
    final String? productionVersionStudent;
    final String? productionVersionTeacher;
    final String? appVersionStudent;
    final String? appVersionTeacher;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    SettingMobileResponse({
        this.id,
        this.logoFathschool,
        this.descriptionApps,
        this.featuresApps,
        this.advantagesApps,
        this.conclusionApps,
        this.fathforcePhoneNumber,
        this.fathforceBrowserLink,
        this.fathforceEmail,
        this.logoFathforce,
        this.logoSchool,
        this.googlePlayLinkStudent,
        this.googlePlayLinkTeacher,
        this.productionVersionStudent,
        this.productionVersionTeacher,
        this.appVersionStudent,
        this.appVersionTeacher,
        this.createdAt,
        this.updatedAt,
    });

    factory SettingMobileResponse.fromJson(String str) => SettingMobileResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SettingMobileResponse.fromMap(Map<String, dynamic> json) => SettingMobileResponse(
        id: json["id"],
        logoFathschool: json["logo_fathschool"],
        descriptionApps: json["description_apps"],
        featuresApps: json["features_apps"],
        advantagesApps: json["advantages_apps"],
        conclusionApps: json["conclusion_apps"],
        fathforcePhoneNumber: json["fathforce_phone_number"],
        fathforceBrowserLink: json["fathforce_browser_link"],
        fathforceEmail: json["fathforce_email"],
        logoFathforce: json["logo_fathforce"],
        logoSchool: json["logo_school"],
        googlePlayLinkStudent: json["google_play_link_student"],
        googlePlayLinkTeacher: json["google_play_link_teacher"],
        productionVersionStudent: json["production_version_student"],
        productionVersionTeacher: json["production_version_teacher"],
        appVersionStudent: json["app_version_student"],
        appVersionTeacher: json["app_version_teacher"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "logo_fathschool": logoFathschool,
        "description_apps": descriptionApps,
        "features_apps": featuresApps,
        "advantages_apps": advantagesApps,
        "conclusion_apps": conclusionApps,
        "fathforce_phone_number": fathforcePhoneNumber,
        "fathforce_browser_link": fathforceBrowserLink,
        "fathforce_email": fathforceEmail,
        "logo_fathforce": logoFathforce,
        "logo_school": logoSchool,
        "google_play_link_student": googlePlayLinkStudent,
        "google_play_link_teacher": googlePlayLinkTeacher,
        "production_version_student": productionVersionStudent,
        "production_version_teacher": productionVersionTeacher,
        "app_version_student": appVersionStudent,
        "app_version_teacher": appVersionTeacher,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
