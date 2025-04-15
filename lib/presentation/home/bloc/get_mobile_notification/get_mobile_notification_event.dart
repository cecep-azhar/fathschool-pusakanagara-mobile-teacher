part of 'get_mobile_notification_bloc.dart';

@freezed
class GetMobileNotificationEvent with _$GetMobileNotificationEvent {
  const factory GetMobileNotificationEvent.started() = _Started;
  const factory GetMobileNotificationEvent.getMobileNotification() = _GetMobileNotification;
}