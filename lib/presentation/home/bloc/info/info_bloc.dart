import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/info_remote_datasource.dart';
import 'package:fath_school/data/models/response/info_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_event.dart';
part 'info_state.dart';
part 'info_bloc.freezed.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final InfoRemoteDatasource _infoRemoteDatasource;

  InfoBloc(this._infoRemoteDatasource) : super(const InfoState.initial()) {
    on<InfoEvent>(_onEvent);
  }

  Future<void> _onEvent(InfoEvent event, Emitter<InfoState> emit) async {
    await event.map(
      fetchInfo: (e) async {
        emit(const InfoState.loading());
        try {
          final info = await _infoRemoteDatasource.getInfo();
          emit(InfoState.loaded(info));
        } catch (e) {
          emit(InfoState.error(e.toString()));
        }
      },
    );
  }
}
