part of 'get_detail_journal_bloc.dart';

abstract class GetDetailJournalEvent extends Equatable {
  const GetDetailJournalEvent();

  @override
  List<Object?> get props => [];
}

class FetchListJournal extends GetDetailJournalEvent {
  final int id;

  const FetchListJournal(this.id);

  @override
  List<Object?> get props => [id];
}