import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fath_school/data/datasources/class_info_remote_datasource.dart';
import 'package:fath_school/data/models/response/class_info_response_model.dart';

part 'class_info_event.dart';
part 'class_info_state.dart';

class ClassInfoBloc extends Bloc<ClassInfoEvent, ClassInfoState> {
  final ClassInfoRemoteDatasource remoteDatasource;

  ClassInfoBloc(this.remoteDatasource) : super(ClassInfoInitial()) {
    on<FetchClassInfo>((event, emit) async {
      emit(ClassInfoLoading());
      try {
        final classinfo = await remoteDatasource.getClassInfo();
        emit(ClassInfoLoaded(classinfo));
      } catch (e) {
        emit(ClassInfoError(e.toString()));
      }
    });
  }
}

