import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fath_school/data/datasources/auth_remote_datasource.dart';
import 'package:fath_school/data/models/response/student_details_response_model.dart';

part 'get_details_student_event.dart';
part 'get_details_student_state.dart';

class GetDetailsStudentBloc extends Bloc<GetDetailsStudentEvent, GetDetailsStudentState> {
  final AuthRemoteDatasource remoteDatasource;

  GetDetailsStudentBloc(this.remoteDatasource) : super(GetDetailsStudentInitial()) {
    on<LoadUserDetailsById>((event, emit) async {
      emit(GetDetailsStudentLoading());
      try {
        final StudentDetailsResponseModel userdetails =
            await remoteDatasource.getUserById(event.userId);
        emit(GetDetailsStudentLoaded(userdetails));
      } catch (e) {
        emit(GetDetailsStudentError('Failed to load class info: $e'));
      }
    });
  }
}
