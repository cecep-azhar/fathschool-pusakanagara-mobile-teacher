part of 'get_permission_list_bloc.dart';

abstract class GetPermissionListEvent extends Equatable {
  const GetPermissionListEvent();

  @override
  List<Object?> get props => [];
}

class FetchGetPermissionList extends GetPermissionListEvent {
  const FetchGetPermissionList();

  @override
  List<Object?> get props => [];
}
