// student_attendance_state.dart
part of 'student_attendance_bloc.dart';

@freezed
class StudentAttendanceState with _$StudentAttendanceState {
  const factory StudentAttendanceState.initial() = _Initial;
  const factory StudentAttendanceState.loading() = _Loading;
  const factory StudentAttendanceState.loaded(List<Datum> data) = _Loaded;
  const factory StudentAttendanceState.empty() = _Empty;
  const factory StudentAttendanceState.error(String message) = _Error;
}
