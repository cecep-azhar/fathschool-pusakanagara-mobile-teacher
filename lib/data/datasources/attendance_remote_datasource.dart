import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/data/models/request/checkinout_request_model.dart';
import 'package:fath_school/data/models/request/qrinout_request_model.dart';
import 'package:fath_school/data/models/response/attendance_response_model.dart';
import 'package:fath_school/data/models/response/checkinout_response_model.dart';
import 'package:fath_school/data/models/response/lesson_response_model.dart';
import 'package:fath_school/data/models/response/qrinout_response_model.dart';
import 'package:fath_school/data/models/response/school_response_model.dart';
import 'package:fath_school/data/models/response/student_attendance_response_model.dart';
import 'package:http/http.dart' as http;

class AttendanceRemoteDatasource {
  Future<Either<String, SchoolResponseModel>> getSchoolProfile() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/school');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(SchoolResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get school profile');
    }
  }

  Future<Either<String, (bool, bool)>> isCheckedin() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/is-checkin');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Right((
        responseData['checkedin'] as bool,
        responseData['checkedout'] as bool
      ));
    } else {
      return const Left('Failed to get checkedin status');
    }
  }

  Future<Either<String, CheckInOutResponseModel>> checkin(
      CheckInOutRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/checkin');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(CheckInOutResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to checkin');
    }
  }

  Future<Either<String, CheckInOutResponseModel>> checkout(
      CheckInOutRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/checkout');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(CheckInOutResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to checkout');
    }
  }

  Future<Either<String, AttendanceResponseModel>> getAttendance(
      String date) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/api-attendances?date=$date');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(AttendanceResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get attendance');
    }
  }

  Future<Either<String, QrInOutResponseModel>> qrin(
      QrInOutRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/qrin');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(QrInOutResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to QR in');
    }
  }

  Future<Either<String, QrInOutResponseModel>> qrout(
      QrInOutRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/qrout');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(QrInOutResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to QR Out');
    }
  }

  Future<Either<String, LessonResponseModel>> getLesson() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/learning-lessons');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(LessonResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get lesson schedule');
    }
  }

  Future<Either<String, (bool, bool)>> isQredin() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/is-qrin');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Right((
        responseData['checkedin'] as bool,
        responseData['checkedout'] as bool
      ));
    } else {
      return const Left('Failed to get checkedin status');
    }
  }

  Future<Either<String, StudentAttendanceResponseModel>> getStudentAttendance(
      String date) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url =
        Uri.parse('${Variables.baseUrl}/api/student-attendances?date=$date');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(StudentAttendanceResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get student attendance');
    }
    // return Right(StudentAttendanceResponseModel(
    //   data: [
    //     Datum(
    //       courseName: "Matematika",
    //       students: Students(
    //         present: [
    //           Absent(
    //             id: 1,
    //             name: "John Doe",
    //             email: "john@mail.com",
    //             absenNumber: 1,
    //           ),
    //           Absent(
    //             id: 5,
    //             name: "Jenny Doe",
    //             email: "jenny@mail.com",
    //             absenNumber: 5,
    //           )
    //         ],
    //         absent: [
    //           Absent(
    //             id: 2,
    //             name: "Jane Doe",
    //             email: "jane@mail.com",
    //             absenNumber: 2,
    //           ),
    //           Absent(
    //             id: 6,
    //             name: "Jim Doe",
    //             email: "jim@mail.com",
    //             absenNumber: 6,
    //           )
    //         ],
    //         permission: [
    //           Absent(
    //             id: 3,
    //             name: "Jack Doe",
    //             email: "jack@mail.com",
    //             absenNumber: 3,
    //           ),
    //           Absent(
    //             id: 7,
    //             name: "Jude Doe",
    //             email: "jude@mail.com",
    //             absenNumber: 7,
    //           )
    //         ],
    //         sick: [
    //           Absent(
    //             id: 4,
    //             name: "Jill Doe",
    //             email: "jill@mail.com",
    //             absenNumber: 4,
    //           ),
    //           Absent(
    //             id: 8,
    //             name: "Jade Doe",
    //             email: "jade@mail.com",
    //             absenNumber: 8,
    //           )
    //         ]
    //       ),
    //       total: Total(
    //         present: 2,
    //         absent: 2,
    //         permission: 2,
    //         sick: 2,
    //       ),
    //     ),
    //     Datum(
    //       courseName: "Bahasa Indonesia",
    //       students: Students(
    //         present: [
    //           Absent(
    //             id: 9,
    //             name: "John Doe",
    //             email: "john@mail.com",
    //             absenNumber: 1,
    //           ),
    //           Absent(
    //             id: 13,
    //             name: "Jenny Doe",
    //             email: "jenny@mail.com",
    //             absenNumber: 5,
    //           ),
    //           Absent(
    //             id: 11,
    //             name: "Jenny Doe",
    //             email: "jenny@mail.com",
    //             absenNumber: 5,
    //           ),
    //           Absent(
    //             id: 12,
    //             name: "Jenny Doe",
    //             email: "jenny@mail.com",
    //             absenNumber: 5,
    //           )
    //         ],
    //         absent: [],
    //         permission: [
    //           Absent(
    //             id: 10,
    //             name: "Jack Doe",
    //             email: "jack@mail.com",
    //             absenNumber: 3,
    //           ),
    //           Absent(
    //             id: 14,
    //             name: "Jude Doe",
    //             email: "jude@mail.com",
    //             absenNumber: 7,
    //           ),
    //           Absent(
    //             id: 15,
    //             name: "Jude Doe",
    //             email: "jude@mail.com",
    //             absenNumber: 7,
    //           ),
    //           Absent(
    //             id: 16,
    //             name: "Jude Doe",
    //             email: "jude@mail.com",
    //             absenNumber: 7,
    //           )
    //         ],
    //         sick: []
    //       ),
    //       total: Total(
    //         present: 4,
    //         absent: 0,
    //         permission: 4,
    //         sick: 0,
    //       ),
    //     )
    //   ],
    //   message: 'Success',
    // ));
  }
}
