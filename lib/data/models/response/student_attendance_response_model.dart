// import 'dart:convert';

// class StudentAttendanceResponseModel {
//     final String? message;
//     final List<Datum>? data;
//     final Total? total;

//     StudentAttendanceResponseModel({
//         this.message,
//         this.data,
//         this.total,
//     });

//     StudentAttendanceResponseModel copyWith({
//         String? message,
//         List<Datum>? data,
//         Total? total,
//     }) => 
//         StudentAttendanceResponseModel(
//             message: message ?? this.message,
//             data: data ?? this.data,
//             total: total ?? this.total,
//         );

//     factory StudentAttendanceResponseModel.fromJson(String str) => StudentAttendanceResponseModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory StudentAttendanceResponseModel.fromMap(Map<String, dynamic> json) => StudentAttendanceResponseModel(
//         message: json["message"],
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
//         total: json["total"] == null ? null : Total.fromMap(json["total"]),
//     );
//     // factory StudentAttendanceResponseModel.fromMap(Map<String, dynamic> json) => StudentAttendanceResponseModel(
//     //   message: json["message"],
//     //   data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
//     //   total: json["total"] == null ? null : Total.fromMap(json["total"]),
//     // );


//     Map<String, dynamic> toMap() => {
//         "message": message,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
//         "total": total?.toMap(),
//     };
// }

// class Datum {
//     final Attendance? attendance;
//     final List<Class>? datumClass;
//     final DateTime? date;
//     final String? status;

//     Datum({
//         this.attendance,
//         this.datumClass,
//         this.date,
//         this.status,
//     });

//     Datum copyWith({
//         Attendance? attendance,
//         List<Class>? datumClass,
//         DateTime? date,
//         String? status,
//     }) => 
//         Datum(
//             attendance: attendance ?? this.attendance,
//             datumClass: datumClass ?? this.datumClass,
//             date: date ?? this.date,
//             status: status ?? this.status,
//         );

//     factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Datum.fromMap(Map<String, dynamic> json) => Datum(
//         attendance: json["attendance"] == null ? null : Attendance.fromMap(json["attendance"]),
//         datumClass: json["class"] == null ? [] : List<Class>.from(json["class"]!.map((x) => Class.fromMap(x))),
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         status: json["status"],
//     );

//     Map<String, dynamic> toMap() => {
//         "attendance": attendance?.toMap(),
//         "class": datumClass == null ? [] : List<dynamic>.from(datumClass!.map((x) => x.toMap())),
//         "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//         "status": status,
//     };
// }

// class Attendance {
//     final int? id;
//     final int? studentId;
//     final int? teacherId;
//     final int? subjectId;
//     final String? status;
//     final int? lateAmount;
//     final DateTime? date;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final String? dateTime;
//     final Student? student;
//     final Subject? subject;

//     Attendance({
//         this.id,
//         this.studentId,
//         this.teacherId,
//         this.subjectId,
//         this.status,
//         this.lateAmount,
//         this.date,
//         this.createdAt,
//         this.updatedAt,
//         this.dateTime,
//         this.student,
//         this.subject,
//     });

//     Attendance copyWith({
//         int? id,
//         int? studentId,
//         int? teacherId,
//         int? subjectId,
//         String? status,
//         int? lateAmount,
//         DateTime? date,
//         DateTime? createdAt,
//         DateTime? updatedAt,
//         String? dateTime,
//         Student? student,
//         Subject? subject,
//     }) => 
//         Attendance(
//             id: id ?? this.id,
//             studentId: studentId ?? this.studentId,
//             teacherId: teacherId ?? this.teacherId,
//             subjectId: subjectId ?? this.subjectId,
//             status: status ?? this.status,
//             lateAmount: lateAmount ?? this.lateAmount,
//             date: date ?? this.date,
//             createdAt: createdAt ?? this.createdAt,
//             updatedAt: updatedAt ?? this.updatedAt,
//             dateTime: dateTime ?? this.dateTime,
//             student: student ?? this.student,
//             subject: subject ?? this.subject,
//         );

//     factory Attendance.fromJson(String str) => Attendance.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
//         id: json["id"],
//         studentId: json["student_id"],
//         teacherId: json["teacher_id"],
//         subjectId: json["subject_id"],
//         status: json["status"],
//         lateAmount: json["late_amount"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         dateTime: json["date_time"],
//         student: json["student"] == null ? null : Student.fromMap(json["student"]),
//         subject: json["subject"] == null ? null : Subject.fromMap(json["subject"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "student_id": studentId,
//         "teacher_id": teacherId,
//         "subject_id": subjectId,
//         "status": status,
//         "late_amount": lateAmount,
//         "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "date_time": dateTime,
//         "student": student?.toMap(),
//         "subject": subject?.toMap(),
//     };
// }

// class Student {
//     final int? id;
//     final String? name;
//     final String? profilePhotoUrl;
//     final dynamic joinDate;

//     Student({
//         this.id,
//         this.name,
//         this.profilePhotoUrl,
//         this.joinDate,
//     });

//     Student copyWith({
//         int? id,
//         String? name,
//         String? profilePhotoUrl,
//         dynamic joinDate,
//     }) => 
//         Student(
//             id: id ?? this.id,
//             name: name ?? this.name,
//             profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
//             joinDate: joinDate ?? this.joinDate,
//         );

//     factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Student.fromMap(Map<String, dynamic> json) => Student(
//         id: json["id"],
//         name: json["name"],
//         profilePhotoUrl: json["profile_photo_url"],
//         joinDate: json["join_date"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "profile_photo_url": profilePhotoUrl,
//         "join_date": joinDate,
//     };
// }

// class Subject {
//     final int? id;
//     final String? name;
//     final dynamic session;

//     Subject({
//         this.id,
//         this.name,
//         this.session,
//     });

//     Subject copyWith({
//         int? id,
//         String? name,
//         dynamic session,
//     }) => 
//         Subject(
//             id: id ?? this.id,
//             name: name ?? this.name,
//             session: session ?? this.session,
//         );

//     factory Subject.fromJson(String str) => Subject.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Subject.fromMap(Map<String, dynamic> json) => Subject(
//         id: json["id"],
//         name: json["name"],
//         session: json["session"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "session": session,
//     };
// }

// class Class {
//     final int? id;
//     final String? name;
//     final String? order;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;

//     Class({
//         this.id,
//         this.name,
//         this.order,
//         this.createdAt,
//         this.updatedAt,
//     });

//     Class copyWith({
//         int? id,
//         String? name,
//         String? order,
//         DateTime? createdAt,
//         DateTime? updatedAt,
//     }) => 
//         Class(
//             id: id ?? this.id,
//             name: name ?? this.name,
//             order: order ?? this.order,
//             createdAt: createdAt ?? this.createdAt,
//             updatedAt: updatedAt ?? this.updatedAt,
//         );

//     factory Class.fromJson(String str) => Class.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Class.fromMap(Map<String, dynamic> json) => Class(
//         id: json["id"],
//         name: json["name"],
//         order: json["order"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "order": order,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }

// class Total {
//     final int? present;
//     final int? absent;
//     final int? lated;

//     Total({
//         this.present,
//         this.absent,
//         this.lated,
//     });

//     Total copyWith({
//         int? present,
//         int? absent,
//         int? lated,
//     }) => 
//         Total(
//             present: present ?? this.present,
//             absent: absent ?? this.absent,
//             lated: lated ?? this.lated,
//         );

//     factory Total.fromJson(String str) => Total.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Total.fromMap(Map<String, dynamic> json) => Total(
//         present: json["present"],
//         absent: json["absent"],
//         lated: json["late"],
//     );

//     Map<String, dynamic> toMap() => {
//         "present": present,
//         "absent": absent,
//         "late": lated,
//     };
// }

import 'dart:convert';

class StudentAttendanceResponseModel {
    final String? message;
    final List<Datum>? data;

    StudentAttendanceResponseModel({
        this.message,
        this.data,
    });

    factory StudentAttendanceResponseModel.fromJson(String str) => StudentAttendanceResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StudentAttendanceResponseModel.fromMap(Map<String, dynamic> json) => StudentAttendanceResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    final String? courseName;
    final Students? students;
    final Total? total;

    Datum({
        this.courseName,
        this.students,
        this.total,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        courseName: json["course_name"],
        students: json["students"] == null ? null : Students.fromMap(json["students"]),
        total: json["total"] == null ? null : Total.fromMap(json["total"]),
    );

    Map<String, dynamic> toMap() => {
        "course_name": courseName,
        "students": students?.toMap(),
        "total": total?.toMap(),
    };
}

class Students {
    final List<Absent>? present;
    final List<Absent>? sick;
    final List<Absent>? permission;
    final List<Absent>? absent;

    Students({
        this.present,
        this.sick,
        this.permission,
        this.absent,
    });

    factory Students.fromJson(String str) => Students.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Students.fromMap(Map<String, dynamic> json) => Students(
        present: json["present"] == null ? [] : List<Absent>.from(json["present"]!.map((x) => Absent.fromMap(x))),
        sick: json["sick"] == null ? [] : List<Absent>.from(json["sick"]!.map((x) => Absent.fromMap(x))),
        permission: json["permission"] == null ? [] : List<Absent>.from(json["permission"]!.map((x) => Absent.fromMap(x))),
        absent: json["absent"] == null ? [] : List<Absent>.from(json["absent"]!.map((x) => Absent.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "present": present == null ? [] : List<dynamic>.from(present!.map((x) => x.toMap())),
        "sick": sick == null ? [] : List<dynamic>.from(sick!.map((x) => x.toMap())),
        "permission": permission == null ? [] : List<dynamic>.from(permission!.map((x) => x.toMap())),
        "absent": absent == null ? [] : List<dynamic>.from(absent!.map((x) => x.toMap())),
    };
}

class Absent {
    final int? id;
    final String? name;
    final String? email;
    final int? absenNumber;

    Absent({
        this.id,
        this.name,
        this.email,
        this.absenNumber,
    });

    factory Absent.fromJson(String str) => Absent.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Absent.fromMap(Map<String, dynamic> json) => Absent(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        absenNumber: json["absen_number"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "absen_number": absenNumber,
    };
}

class Total {
    final int? present;
    final int? sick;
    final int? permission;
    final int? absent;

    Total({
        this.present,
        this.sick,
        this.permission,
        this.absent,
    });

    factory Total.fromJson(String str) => Total.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Total.fromMap(Map<String, dynamic> json) => Total(
        present: json["present"],
        sick: json["sick"],
        permission: json["permission"],
        absent: json["absent"],
    );

    Map<String, dynamic> toMap() => {
        "present": present,
        "sick": sick,
        "permission": permission,
        "absent": absent,
    };
}
