import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/auth_remote_datasource.dart';
import 'package:fath_school/data/models/response/setting_mobile_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_mobile_event.dart';
part 'setting_mobile_state.dart';
part 'setting_mobile_bloc.freezed.dart';

class SettingMobileBloc extends Bloc<SettingMobileEvent, SettingMobileState> {
  final AuthRemoteDatasource _datasource;

  SettingMobileBloc(this._datasource) : super(const SettingMobileState.initial()) {
    on<SettingMobileEvent>((event, emit) async {
      await event.map(
        getSettingMobile: (e) async {
          emit(const SettingMobileState.loading());
          final result = await _datasource.getSettingMobile();
          result.fold(
            (failure) => emit(SettingMobileState.error(failure)),
            (response) => emit(SettingMobileState.loaded(response)),
          );
        },
      );
    });
  }
}
