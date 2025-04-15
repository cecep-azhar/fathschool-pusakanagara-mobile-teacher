part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;
  const factory UpdateProfileState.loading() = _Loading;
  const factory UpdateProfileState.success(UserResponseModel response) = _Success;
  const factory UpdateProfileState.error(String error) = _Error;
}
