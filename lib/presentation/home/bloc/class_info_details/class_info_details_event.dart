part of 'class_info_details_bloc.dart';

abstract class ClassInfoDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadClassInfoDetailsById extends ClassInfoDetailsEvent {
  final int classId;

  LoadClassInfoDetailsById(this.classId);

  @override
  List<Object?> get props => [classId];
}