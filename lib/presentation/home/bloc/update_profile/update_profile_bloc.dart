import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/auth_remote_datasource.dart';
import 'package:fath_school/data/models/response/user_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';
part 'update_profile_bloc.freezed.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final AuthRemoteDatasource repository;

  UpdateProfileBloc(this.repository) : super(const _Initial()) {
    on<UpdateProfileEvent>((event, emit) async {
      await event.map(
        updateProfile: (e) async {
          emit(const UpdateProfileState.loading());

          final result = await repository.updateProfile(e.image);

          result.fold(
            (failure) => emit(UpdateProfileState.error(failure)),
            (success) => emit(UpdateProfileState.success(success)),
          );
        },
      );
    });
  }
}
