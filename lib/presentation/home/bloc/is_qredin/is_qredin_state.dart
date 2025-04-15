part of 'is_qredin_bloc.dart';

@freezed
class IsQredinState with _$IsQredinState {
  const factory IsQredinState.initial() = _Initial;
  const factory IsQredinState.loading() = _Loading;
  const factory IsQredinState.success(AbsentStatus data) = _Success;
  const factory IsQredinState.error(String message) = _Error;
}
