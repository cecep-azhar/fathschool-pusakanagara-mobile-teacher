import 'package:bloc/bloc.dart';
import 'package:fath_school/data/datasources/journal_remote_datasource.dart';
import 'package:fath_school/data/models/response/journal_response_model.dart';
import 'package:equatable/equatable.dart';

part 'get_detail_journal_event.dart';
part 'get_detail_journal_state.dart';

class GetDetailJournalBloc extends Bloc<GetDetailJournalEvent, GetDetailJournalState> {
  final JournalRemoteDatasource remoteDatasource;

  GetDetailJournalBloc(this.remoteDatasource) : super(GetDetailJournalInitial()) {
    on<FetchListJournal>((event, emit) async {
      emit(GetDetailJournalLoading());
      try {
        final JournalResponseModel journal = await remoteDatasource.getDetailJournalId(event.id);
        emit(GetDetailJournalLoaded(journal));
      } catch (e) {
        emit(GetDetailJournalError('Failed to load journal detail: $e'));
      }
    });
  }
}