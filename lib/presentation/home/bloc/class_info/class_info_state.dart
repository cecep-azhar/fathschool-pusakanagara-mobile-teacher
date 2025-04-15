part of 'class_info_bloc.dart';

abstract class ClassInfoState extends Equatable {
  const ClassInfoState();

  @override
  List<Object> get props => [];
}

class ClassInfoInitial extends ClassInfoState {}

class ClassInfoLoading extends ClassInfoState {}

class ClassInfoLoaded extends ClassInfoState {
  final List<ClassInfoResponseModel> classinfo;

  const ClassInfoLoaded(this.classinfo);

  @override
  List<Object> get props => [classinfo];
}

class ClassInfoError extends ClassInfoState {
  final String message;

  const ClassInfoError(this.message);

  @override
  List<Object> get props => [message];
}
