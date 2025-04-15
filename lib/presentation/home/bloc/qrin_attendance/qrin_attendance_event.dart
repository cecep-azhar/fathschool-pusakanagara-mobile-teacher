part of 'qrin_attendance_bloc.dart';

@freezed
class QrinAttendanceEvent with _$QrinAttendanceEvent {
  const factory QrinAttendanceEvent.started() = _Started;
  const factory QrinAttendanceEvent.qrin(
      String classListsId, String latitude, String longitude) = _Qrin;
}
