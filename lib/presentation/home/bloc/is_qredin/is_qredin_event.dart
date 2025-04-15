part of 'is_qredin_bloc.dart';

@freezed
class IsQredinEvent with _$IsQredinEvent {
  const factory IsQredinEvent.started() = _Started;
  const factory IsQredinEvent.isQredin() = _IsQredin;
}