import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fath_school/data/datasources/class_info_remote_datasource.dart';
import 'package:fath_school/data/models/response/class_info_details_response_model.dart';

part 'class_info_details_event.dart';
part 'class_info_details_state.dart';

class ClassInfoDetailsBloc extends Bloc<ClassInfoDetailsEvent, ClassInfoDetailsState> {
  final ClassInfoRemoteDatasource remoteDatasource;

  ClassInfoDetailsBloc(this.remoteDatasource) : super(ClassInfoDetailsInitial()) {
    on<LoadClassInfoDetailsById>((event, emit) async {
      emit(ClassInfoDetailsLoading());
      try {
        final ClassInfoDetailsResponseModel classInfo =
            await remoteDatasource.getClassInfoById(event.classId);
        emit(ClassInfoDetailsLoaded(classInfo));
      } catch (e) {
        emit(ClassInfoDetailsError('Failed to load class info: $e'));
      }
    });
  }
}
