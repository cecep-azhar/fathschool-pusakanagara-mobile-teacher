part of 'qrout_attendance_bloc.dart';

@freezed
class QroutAttendanceEvent with _$QroutAttendanceEvent {
  const factory QroutAttendanceEvent.started() = _Started;
  const factory QroutAttendanceEvent.qrout(
      String classListsId, String latitude, String longitude) = _Qrout;
}
