import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/permisson_remote_datasource.dart';
import 'package:fath_school/data/models/response/permission_response_model.dart';
import 'package:equatable/equatable.dart';

part 'get_details_permission_event.dart';
part 'get_details_permission_state.dart';

class GetDetailsPermissionBloc extends Bloc<GetDetailsPermissionEvent, GetDetailsPermissionState> {
  final PermissonRemoteDatasource remoteDatasource;

  GetDetailsPermissionBloc(this.remoteDatasource)
      : super(GetDetailsPermissionInitial()) {
    on<FetchListPermission>((event, emit) async {
      emit(GetDetailsPermissionLoading());
      try {
        final PermissionResponseModel permission =
            await remoteDatasource.getDetailPermissionId(event.id);
        emit(GetDetailsPermissionLoaded(permission));
      } catch (e) {
        emit(GetDetailsPermissionError('Failed to load permission detail: $e'));
      }
    });
  }
}
