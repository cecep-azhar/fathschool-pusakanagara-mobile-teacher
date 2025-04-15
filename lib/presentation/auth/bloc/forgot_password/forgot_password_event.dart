part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String phone;

  const ForgotPasswordRequested(this.phone);

  @override
  List<Object> get props => [phone];
}
