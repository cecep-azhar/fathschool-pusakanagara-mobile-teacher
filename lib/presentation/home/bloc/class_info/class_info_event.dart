part of 'class_info_bloc.dart';

abstract class ClassInfoEvent extends Equatable {
  const ClassInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchClassInfo extends ClassInfoEvent {

  const FetchClassInfo();

  @override
  List<Object> get props => [];
}
