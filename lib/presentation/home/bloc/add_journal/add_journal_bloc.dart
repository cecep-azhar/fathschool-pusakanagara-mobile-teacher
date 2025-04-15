import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/journal_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_journal_event.dart';
part 'add_journal_state.dart';
part 'add_journal_bloc.freezed.dart';

class AddJournalBloc extends Bloc<AddJournalEvent, AddJournalState> {
  final JournalRemoteDatasource datasource;

  AddJournalBloc(this.datasource) : super(const _Initial()) {
    on<_AddJournal>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.addJournal(
        event.date, 
        event.time, 
        event.description, 
        event.image, 
        event.classLists
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
