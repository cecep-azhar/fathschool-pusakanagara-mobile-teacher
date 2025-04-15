part of 'add_journal_bloc.dart';

@freezed
class AddJournalEvent with _$AddJournalEvent {
  const factory AddJournalEvent.started() = _Started;
  const factory AddJournalEvent.addJournal({
    required String date,
    required String time,
    required String description,
    required String image,
    required String classLists,
  }) = _AddJournal;
}