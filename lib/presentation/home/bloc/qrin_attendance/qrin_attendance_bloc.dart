import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fath_school/data/models/request/qrinout_request_model.dart';
import 'package:fath_school/data/models/response/qrinout_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';

part 'qrin_attendance_bloc.freezed.dart';
part 'qrin_attendance_event.dart';
part 'qrin_attendance_state.dart';

class QrinAttendanceBloc
    extends Bloc<QrinAttendanceEvent, QrinAttendanceState> {
  final AttendanceRemoteDatasource datasource;
  QrinAttendanceBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Qrin>((event, emit) async {
      emit(const _Loading());
      final requestModel = QrInOutRequestModel(
          qrCodeId: event.classListsId,
          latitude: event.latitude,
          longitude: event.longitude);
      final result = await datasource.qrin(requestModel);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
