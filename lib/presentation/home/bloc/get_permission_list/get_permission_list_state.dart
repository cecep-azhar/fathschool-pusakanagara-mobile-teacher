part of 'get_permission_list_bloc.dart';

abstract class GetPermissionListState extends Equatable {
  const GetPermissionListState();
  @override
  List<Object?> get props => [];
}

class GetPermissionListInitial extends GetPermissionListState {}

class GetPermissionListLoading extends GetPermissionListState {}

class GetPermissionListLoaded extends GetPermissionListState {
  final List<PermissionResponseModel> permissions;

  const GetPermissionListLoaded(this.permissions);

  @override
  List<Object?> get props => [permissions];
}

class GetPermissionListError extends GetPermissionListState {
  final String message;

  const GetPermissionListError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPermissionListEmpty extends GetPermissionListState {}
