part of 'get_school_bloc.dart';

@freezed
class GetSchoolEvent with _$GetSchoolEvent {
  const factory GetSchoolEvent.started() = _Started;
  const factory GetSchoolEvent.getSchool() = _GetSchool;
}