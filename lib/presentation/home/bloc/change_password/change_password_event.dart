part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ChangePasswordRequested extends ChangePasswordEvent {
  final String password;
  final String passwordConfirmation;

  const ChangePasswordRequested({
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props => [password, passwordConfirmation];
}
