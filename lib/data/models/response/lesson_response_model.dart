import 'dart:convert';

class LessonResponseModel {
  final List<Lesson>? lessons;

  LessonResponseModel({
    this.lessons,
  });

  LessonResponseModel copyWith({
    List<Lesson>? lessons,
  }) =>
      LessonResponseModel(
        lessons: lessons ?? this.lessons,
      );

  factory LessonResponseModel.fromJson(String str) =>
      LessonResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LessonResponseModel.fromMap(Map<String, dynamic> json) =>
      LessonResponseModel(
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(json["lessons"]!.map((x) => Lesson.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toMap())),
      };
}

class Lesson {
  final int? teacherId;
  final String? teacherName;
  final int? subjectId;
  final String? subjectName;
  final int? classId;
  final String? className;
  final String? qrCodeId;
  final String? timeIn;
  final String? timeOut;

  Lesson({
    this.teacherId,
    this.teacherName,
    this.subjectId,
    this.subjectName,
    this.classId,
    this.className,
    this.qrCodeId,
    this.timeIn,
    this.timeOut,
  });

  Lesson copyWith({
    int? teacherId,
    String? teacherName,
    int? subjectId,
    String? subjectName,
    int? classId,
    String? className,
    String? qrCodeId,
    String? timeIn,
    String? timeOut,
  }) =>
      Lesson(
        teacherId: teacherId ?? this.teacherId,
        teacherName: teacherName ?? this.teacherName,
        subjectId: subjectId ?? this.subjectId,
        subjectName: subjectName ?? this.subjectName,
        classId: classId ?? this.classId,
        className: className ?? this.className,
        qrCodeId: qrCodeId ?? this.qrCodeId,
        timeIn: timeIn ?? this.timeIn,
        timeOut: timeOut ?? this.timeOut,
      );

  factory Lesson.fromJson(String str) => Lesson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lesson.fromMap(Map<String, dynamic> json) => Lesson(
        teacherId: json["teacher_id"],
        teacherName: json["teacher_name"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        classId: json["class_id"],
        className: json["class_name"],
        qrCodeId: json["qr_code_id"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
      );

  Map<String, dynamic> toMap() => {
        "teacher_id": teacherId,
        "teacher_name": teacherName,
        "subject_id": subjectId,
        "subject_name": subjectName,
        "class_id": classId,
        "class_name": className,
        "qr_code_id": qrCodeId,
        "time_in": timeIn,
        "time_out": timeOut,
      };
}
