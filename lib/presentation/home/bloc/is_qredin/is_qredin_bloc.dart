import 'package:bloc/bloc.dart';
import 'package:fath_school/presentation/home/models/absent_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';

part 'is_qredin_bloc.freezed.dart';
part 'is_qredin_event.dart';
part 'is_qredin_state.dart';

class IsQredinBloc extends Bloc<IsQredinEvent, IsQredinState> {
  final AttendanceRemoteDatasource datasource;
  IsQredinBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_IsQredin>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.isQredin();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(AbsentStatus(
          isCheckedin: r.$1,
          isCheckedout: r.$2,
        ))),
      );
    });
  }
}
