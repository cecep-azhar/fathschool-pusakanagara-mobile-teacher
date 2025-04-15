import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fath_school/data/datasources/permisson_remote_datasource.dart';

part 'add_permission_bloc.freezed.dart';
part 'add_permission_event.dart';
part 'add_permission_state.dart';

class AddPermissionBloc extends Bloc<AddPermissionEvent, AddPermissionState> {
  final PermissonRemoteDatasource datasource;
  AddPermissionBloc(
    this.datasource,
  ) : super(const AddPermissionState.initial()) {
    on<_AddPermission>((event, emit) async {
      emit(const AddPermissionState.loading());
      final result = await datasource.addPermission(
         event.leaveTypeId, event.start, event.end, event.title, event.description, event.image);
      result.fold(
        (l) => emit(AddPermissionState.error(l)),
        (r) => emit(const AddPermissionState.success()),
      );
    });
  }
}
