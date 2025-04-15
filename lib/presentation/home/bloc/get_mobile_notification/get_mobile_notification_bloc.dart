import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fath_school/data/models/response/mobile_notification_response_model.dart';
import 'package:fath_school/data/datasources/mobile_notification_remote_datasource.dart';

part 'get_mobile_notification_event.dart';
part 'get_mobile_notification_state.dart';
part 'get_mobile_notification_bloc.freezed.dart';

class GetMobileNotificationBloc extends Bloc<GetMobileNotificationEvent, GetMobileNotificationState> {
  final MobileNotificationRemoteDatasource datasource;

  GetMobileNotificationBloc(this.datasource) : super(const _Initial()) {
    on<_GetMobileNotification>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getMobileNotification();
      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data!.isEmpty) {
            emit(const _Empty());
          } else {
            emit(_Loaded(r.data!));
          }
        });
    });
  }
}
