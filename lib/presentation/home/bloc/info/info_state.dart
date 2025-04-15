part of 'info_bloc.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState.initial() = _Initial;
  const factory InfoState.loading() = _Loading;
  const factory InfoState.loaded(List<InfoResponseModel> info) = _Loaded;
  const factory InfoState.error(String message) = _Error;
}
