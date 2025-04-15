import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';
import 'package:fath_school/data/models/request/qrinout_request_model.dart';
import 'package:fath_school/data/models/response/qrinout_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qrout_attendance_event.dart';
part 'qrout_attendance_state.dart';
part 'qrout_attendance_bloc.freezed.dart';

class QroutAttendanceBloc
    extends Bloc<QroutAttendanceEvent, QroutAttendanceState> {
  final AttendanceRemoteDatasource datasource;
  QroutAttendanceBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Qrout>((event, emit) async {
      emit(const _Loading());
      final requestModel = QrInOutRequestModel(
        qrCodeId: event.classListsId,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      final result = await datasource.qrout(requestModel);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
