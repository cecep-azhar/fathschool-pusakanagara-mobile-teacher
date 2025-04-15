part of 'get_details_student_bloc.dart';

abstract class GetDetailsStudentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailsStudentInitial extends GetDetailsStudentState {}

class GetDetailsStudentLoading extends GetDetailsStudentState {}

class GetDetailsStudentLoaded extends GetDetailsStudentState {
  final StudentDetailsResponseModel userdetails;

  GetDetailsStudentLoaded(this.userdetails);

  @override
  List<Object?> get props => [userdetails];
}

class GetDetailsStudentError extends GetDetailsStudentState {
  final String message;

  GetDetailsStudentError(this.message);

  @override
  List<Object?> get props => [message];
}