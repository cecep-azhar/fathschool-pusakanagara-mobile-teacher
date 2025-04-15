import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';
import 'package:fath_school/data/models/response/student_attendance_response_model.dart';

part 'student_attendance_bloc.freezed.dart';
part 'student_attendance_event.dart';
part 'student_attendance_state.dart';

class StudentAttendanceBloc extends Bloc<StudentAttendanceEvent, StudentAttendanceState> {
  final AttendanceRemoteDatasource datasource;

  StudentAttendanceBloc(this.datasource) : super(const _Initial()) {
    on<_StudentAttendance>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getStudentAttendance(event.date);
      result.fold(
        (message) => emit(_Error(message)),
        (student) {
          if (student.data == null || student.data!.isEmpty) {
            emit(const _Empty());
          } else {
            emit(_Loaded(student.data!));
          }
        },
      );
    });
  }
}
