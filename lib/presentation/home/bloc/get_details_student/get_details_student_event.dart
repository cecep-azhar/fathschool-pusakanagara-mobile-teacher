part of 'get_details_student_bloc.dart';

abstract class GetDetailsStudentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserDetailsById extends GetDetailsStudentEvent {
  final int userId;

  LoadUserDetailsById(this.userId);

  @override
  List<Object?> get props => [userId];
}