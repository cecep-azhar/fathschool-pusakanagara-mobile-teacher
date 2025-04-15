import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/permisson_remote_datasource.dart';
import 'package:fath_school/data/models/response/permission_response_model.dart';
import 'package:equatable/equatable.dart';

part 'get_permission_list_event.dart';
part 'get_permission_list_state.dart';

class GetPermissionListBloc
    extends Bloc<GetPermissionListEvent, GetPermissionListState> {
  final PermissonRemoteDatasource remoteDatasource;

  GetPermissionListBloc(this.remoteDatasource)
      : super(GetPermissionListInitial()) {
    on<FetchGetPermissionList>((event, emit) async {
      emit(GetPermissionListLoading());
      try {
        final listPermission = await remoteDatasource.getListPermission();
        if (listPermission.isEmpty) {
          emit(GetPermissionListEmpty());
        } else {
          emit(GetPermissionListLoaded(listPermission));
        }
      } catch (e) {
        emit(GetPermissionListError(e.toString()));
      }
    });
  }
}
