part of 'get_mobile_notification_bloc.dart';

@freezed
class GetMobileNotificationState with _$GetMobileNotificationState {
  const factory GetMobileNotificationState.initial() = _Initial;
  const factory GetMobileNotificationState.loading() = _Loading;
  const factory GetMobileNotificationState.loaded(List<Datum> data) = _Loaded;
  const factory GetMobileNotificationState.error(String message) = _Error;
  const factory GetMobileNotificationState.empty() = _Empty;
}
