import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/permisson_remote_datasource.dart';
import 'package:fath_school/data/models/response/leaves_type_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_leaves_type_bloc.freezed.dart';
part 'get_leaves_type_event.dart';
part 'get_leaves_type_state.dart';

class LeavesBloc extends Bloc<LeavesEvent, LeavesState> {
  final PermissonRemoteDatasource datasource;

  LeavesBloc(this.datasource) : super(const _Initial()) {
    on<_GetLeavesId>((event, emit) async {
      emit(const _Loading());
      try {
        final leaves = await datasource.getLeavesId();
        emit(LeavesState.loaded(leaves));
      } catch (e) {
        emit(LeavesState.error(e.toString()));
      }
    });
  }
}
