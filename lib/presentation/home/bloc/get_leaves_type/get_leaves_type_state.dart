part of 'get_leaves_type_bloc.dart';

@freezed
class LeavesState with _$LeavesState {
  const factory LeavesState.initial() = _Initial;
  const factory LeavesState.loading() = _Loading;
  const factory LeavesState.loaded(List<LeavesTypeResponseModel> leaves) = _Loaded;
  const factory LeavesState.error(String message) = _Error;
}