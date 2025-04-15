part of 'qrin_attendance_bloc.dart';

@freezed
class QrinAttendanceState with _$QrinAttendanceState {
  const factory QrinAttendanceState.initial() = _Initial;
  const factory QrinAttendanceState.loading() = _Loading;
  const factory QrinAttendanceState.loaded(QrInOutResponseModel responseModel) = _Loaded;
  const factory QrinAttendanceState.error(String message) = _Error;
}
