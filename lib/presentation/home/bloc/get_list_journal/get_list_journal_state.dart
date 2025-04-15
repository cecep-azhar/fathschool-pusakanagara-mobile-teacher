part of 'get_list_journal_bloc.dart';


abstract class GetListJournalState extends Equatable {
  const GetListJournalState();
  @override
  List<Object?> get props => [];
}

class GetListJournalInitial extends GetListJournalState {}
class GetListJournalLoading extends GetListJournalState {}
class GetListJournalLoaded extends GetListJournalState {
  final List<JournalResponseModel> journal;

  const GetListJournalLoaded(this.journal);

  @override
  List<Object?> get props => [journal];
}

class GetListJournalError extends GetListJournalState {
  final String message;

  const GetListJournalError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetListJournalEmpty extends GetListJournalState {}
