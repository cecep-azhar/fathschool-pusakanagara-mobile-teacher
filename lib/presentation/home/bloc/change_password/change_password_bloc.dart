import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/auth_remote_datasource.dart';
import 'package:fath_school/data/models/response/forgot_password_response_model.dart';
import 'package:equatable/equatable.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRemoteDatasource datasource;

  ChangePasswordBloc({required this.datasource}) : super(ChangePasswordInitial()) {
    on<ChangePasswordRequested>(_onChangePasswordRequested);
  }

  void _onChangePasswordRequested(ChangePasswordRequested event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    try {
      final result = await datasource.forgetPassword(event.password, event.passwordConfirmation);
      emit(ChangePasswordSuccess(result.getOrElse(() => ForgotPasswordResponseModel())));
    } catch (e) {
      emit(ChangePasswordFailure('Failed to change password: $e'));
    }
  }
}
