part of 'class_info_details_bloc.dart';

abstract class ClassInfoDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClassInfoDetailsInitial extends ClassInfoDetailsState {}

class ClassInfoDetailsLoading extends ClassInfoDetailsState {}

class ClassInfoDetailsLoaded extends ClassInfoDetailsState {
  final ClassInfoDetailsResponseModel classInfo;

  ClassInfoDetailsLoaded(this.classInfo);

  @override
  List<Object?> get props => [classInfo];
}

class ClassInfoDetailsError extends ClassInfoDetailsState {
  final String message;

  ClassInfoDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}