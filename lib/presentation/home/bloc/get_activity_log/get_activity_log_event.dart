part of 'get_activity_log_bloc.dart';

abstract class GetActivityLogEvent extends Equatable {
  const GetActivityLogEvent();

  @override
  List<Object> get props => [];
}

class FetchActivityLog extends GetActivityLogEvent {
  final int userId;

  const FetchActivityLog(this.userId);

  @override
  List<Object> get props => [userId];
}
