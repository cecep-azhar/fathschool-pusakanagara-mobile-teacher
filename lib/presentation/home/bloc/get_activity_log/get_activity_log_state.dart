part of 'get_activity_log_bloc.dart';

abstract class GetActivityLogState extends Equatable {
  const GetActivityLogState();

  @override
  List<Object> get props => [];
}

class ActivityLogInitial extends GetActivityLogState {}

class ActivityLogLoading extends GetActivityLogState {}

class ActivityLogLoaded extends GetActivityLogState {
  final List<ActivityLogResponseModel> activityLogs;

  const ActivityLogLoaded(this.activityLogs);

  @override
  List<Object> get props => [activityLogs];
}

class ActivityLogError extends GetActivityLogState {
  final String message;

  const ActivityLogError(this.message);

  @override
  List<Object> get props => [message];
}

class ActivityLogEmpty extends GetActivityLogState {}
