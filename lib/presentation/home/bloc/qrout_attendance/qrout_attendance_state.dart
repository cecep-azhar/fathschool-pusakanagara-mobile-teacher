part of 'qrout_attendance_bloc.dart';

@freezed
class QroutAttendanceState with _$QroutAttendanceState {
  const factory QroutAttendanceState.initial() = _Initial;
  const factory QroutAttendanceState.loading() = _Loading;
  const factory QroutAttendanceState.loaded(QrInOutResponseModel responseModel) = _Loaded;
  const factory QroutAttendanceState.error(String message) = _Error;
}
