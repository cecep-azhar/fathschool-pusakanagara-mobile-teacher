part of 'add_permission_bloc.dart';

@freezed
class AddPermissionEvent with _$AddPermissionEvent {
  const factory AddPermissionEvent.started() = _Started;
  const factory AddPermissionEvent.addPermission({
    required String leaveTypeId,
    required String start,
    required String end,
    required String title,
    required String description,
    required XFile? image,
  }) = _AddPermission;
}
