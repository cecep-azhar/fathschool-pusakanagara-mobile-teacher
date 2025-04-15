import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';
import 'package:fath_school/data/models/response/school_response_model.dart';

part 'get_school_bloc.freezed.dart';
part 'get_school_event.dart';
part 'get_school_state.dart';

class GetSchoolBloc extends Bloc<GetSchoolEvent, GetSchoolState> {
  final AttendanceRemoteDatasource datasource;
  GetSchoolBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetSchool>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getSchoolProfile();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.setting!)),
      );
    });
  }
}
