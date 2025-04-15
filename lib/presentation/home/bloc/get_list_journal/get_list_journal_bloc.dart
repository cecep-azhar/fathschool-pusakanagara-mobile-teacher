import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/journal_remote_datasource.dart';
import 'package:fath_school/data/models/response/journal_response_model.dart';
import 'package:equatable/equatable.dart';


part 'get_list_journal_event.dart';
part 'get_list_journal_state.dart';

class GetListJournalBloc extends Bloc<GetListJournalEvent, GetListJournalState> {
  final JournalRemoteDatasource remoteDatasource;

  GetListJournalBloc(this.remoteDatasource) : super(GetListJournalInitial()) {
    on<FetchListJournal>((event, emit) async {
      emit(GetListJournalLoading());
      try {
        final listJournal = await remoteDatasource.getListJournal();
          if (listJournal.isEmpty) {
          emit(GetListJournalEmpty());
        } else {
          emit(GetListJournalLoaded(listJournal));
        }
      } catch (e) {
        emit(GetListJournalError(e.toString()));
      }
    });
  }
}
