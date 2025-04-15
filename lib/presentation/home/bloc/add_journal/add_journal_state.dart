part of 'add_journal_bloc.dart';

@freezed
class AddJournalState with _$AddJournalState {
  const factory AddJournalState.initial() = _Initial;
  const factory AddJournalState.loading() = _Loading;
  const factory AddJournalState.success() = _Success;
  const factory AddJournalState.error(String message) = _Error;
}
