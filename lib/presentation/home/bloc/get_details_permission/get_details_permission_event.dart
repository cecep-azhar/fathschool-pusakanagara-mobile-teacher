part of 'get_details_permission_bloc.dart';

abstract class GetDetailsPermissionEvent extends Equatable {
  const GetDetailsPermissionEvent();

  @override
  List<Object?> get props => [];
}

class FetchListPermission extends GetDetailsPermissionEvent {
  final int id;

  const FetchListPermission(this.id);

  @override
  List<Object?> get props => [id];
}
