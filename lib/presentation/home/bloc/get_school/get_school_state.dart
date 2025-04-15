part of 'get_school_bloc.dart';

@freezed
class GetSchoolState with _$GetSchoolState {
  const factory GetSchoolState.initial() = _Initial;
  const factory GetSchoolState.loading() = _Loading;
  const factory GetSchoolState.success(Setting data) = _Success;
  const factory GetSchoolState.error(String message) = _Error;
}
