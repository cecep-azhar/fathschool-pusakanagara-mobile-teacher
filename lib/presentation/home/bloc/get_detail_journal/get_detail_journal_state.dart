part of 'get_detail_journal_bloc.dart';

abstract class GetDetailJournalState extends Equatable {
  const GetDetailJournalState();
  @override
  List<Object?> get props => [];
}

class GetDetailJournalInitial extends GetDetailJournalState {}
class GetDetailJournalLoading extends GetDetailJournalState {}
class GetDetailJournalLoaded extends GetDetailJournalState {
  final JournalResponseModel journal;

  const GetDetailJournalLoaded(this.journal);

  @override
  List<Object?> get props => [journal];
}

class GetDetailJournalError extends GetDetailJournalState {
  final String message;

  const GetDetailJournalError(this.message);

  @override
  List<Object?> get props => [message];
}