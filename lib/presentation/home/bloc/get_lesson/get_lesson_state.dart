part of 'get_lesson_bloc.dart';

@freezed
class GetLessonState with _$GetLessonState {
  const factory GetLessonState.initial() = _Initial;
  const factory GetLessonState.loading() = _Loading;
  const factory GetLessonState.success(List<Lesson> lessons) = _Success;
  const factory GetLessonState.error(String message) = _Error;
}
