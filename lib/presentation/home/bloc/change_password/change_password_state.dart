part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final ForgotPasswordResponseModel response;

  const ChangePasswordSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  const ChangePasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}
