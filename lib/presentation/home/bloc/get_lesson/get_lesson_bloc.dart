import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';
import 'package:fath_school/data/models/response/lesson_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_lesson_event.dart';
part 'get_lesson_state.dart';
part 'get_lesson_bloc.freezed.dart';

class GetLessonBloc extends Bloc<GetLessonEvent, GetLessonState> {
  final AttendanceRemoteDatasource datasource;
  GetLessonBloc(this.datasource) : super(const _Initial()) {
    on<_GetLesson>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getLesson();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.lessons ?? [])),
      );
    });
  }
}

