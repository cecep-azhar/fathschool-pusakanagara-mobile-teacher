part of 'setting_mobile_bloc.dart';

@freezed
class SettingMobileState with _$SettingMobileState {
  const factory SettingMobileState.initial() = _Initial;
  const factory SettingMobileState.loading() = _Loading;
  const factory SettingMobileState.loaded(SettingMobileResponse response) = _Loaded;
  const factory SettingMobileState.error(String message) = _Error;
}
