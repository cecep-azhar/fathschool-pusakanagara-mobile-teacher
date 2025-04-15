part of 'student_attendance_bloc.dart';

@freezed
class StudentAttendanceEvent with _$StudentAttendanceEvent {
  const factory StudentAttendanceEvent.getStudentAttendance(String date) = _StudentAttendance;
}