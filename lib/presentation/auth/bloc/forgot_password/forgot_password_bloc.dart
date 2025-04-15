import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fath_school/data/datasources/auth_remote_datasource.dart';
import 'package:fath_school/data/models/response/forgot_password_response_model.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRemoteDatasource authRemoteDatasource;

  ForgotPasswordBloc({required this.authRemoteDatasource}) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    final failureOrSuccess = await authRemoteDatasource.forgotPassword(event.phone);
    emit(failureOrSuccess.fold(
      (failure) => ForgotPasswordFailure(error: failure),
      (response) => ForgotPasswordSuccess(response: response),
    ));
  }
}
