part of 'get_details_permission_bloc.dart';

abstract class GetDetailsPermissionState extends Equatable {
  const GetDetailsPermissionState();
  @override
  List<Object?> get props => [];
}

class GetDetailsPermissionInitial extends GetDetailsPermissionState {}
class GetDetailsPermissionLoading extends GetDetailsPermissionState {}
class GetDetailsPermissionLoaded extends GetDetailsPermissionState {
  final PermissionResponseModel permission;

  const GetDetailsPermissionLoaded(this.permission);

  @override
  List<Object?> get props => [permission];
}

class GetDetailsPermissionError extends GetDetailsPermissionState {
  final String message;

  const GetDetailsPermissionError(this.message);

  @override
  List<Object?> get props => [message];
}