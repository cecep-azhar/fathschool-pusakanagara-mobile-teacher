import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fath_school/data/datasources/activity_log_remote_datasource.dart';
import 'package:fath_school/data/models/response/activitylog_response_model.dart';

part 'get_activity_log_event.dart';
part 'get_activity_log_state.dart';

class GetActivityLogBloc extends Bloc<GetActivityLogEvent, GetActivityLogState> {
  final ActivityLogRemoteDatasource remoteDatasource;

  GetActivityLogBloc(this.remoteDatasource) : super(ActivityLogInitial()) {
    on<FetchActivityLog>((event, emit) async {
      emit(ActivityLogLoading());
      try {
        final activityLogs = await remoteDatasource.getActivityLogs(event.userId);
        if (activityLogs.isEmpty) {
          emit(ActivityLogEmpty());
        } else {
          emit(ActivityLogLoaded(activityLogs));
        }
      } catch (e) {
        emit(ActivityLogError(e.toString()));
      }
    });
  }
}
