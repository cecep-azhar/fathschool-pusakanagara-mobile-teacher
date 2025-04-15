part of 'get_list_journal_bloc.dart';

abstract class GetListJournalEvent extends Equatable {
  const GetListJournalEvent();

  @override
  List<Object?> get props => [];
}

class FetchListJournal extends GetListJournalEvent {

  const FetchListJournal();

  @override
  List<Object?> get props => [];
}
