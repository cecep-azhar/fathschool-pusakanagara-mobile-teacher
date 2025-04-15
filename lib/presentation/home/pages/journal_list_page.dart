
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fath_school/data/datasources/journal_remote_datasource.dart';
import 'package:fath_school/presentation/home/bloc/get_list_journal/get_list_journal_bloc.dart';
import 'package:fath_school/presentation/home/pages/journal_detail_page.dart';
import 'package:intl/intl.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  State<JournalListPage> createState() => _JournalListPageState();
}

class _JournalListPageState extends State<JournalListPage> {
  final getListJournalBloc = GetListJournalBloc(JournalRemoteDatasource());

  @override
  void initState() {
    super.initState();
    getListJournalBloc.add(const FetchListJournal());
  }

  Future<void> _refresh() async {
    getListJournalBloc.add(const FetchListJournal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Jurnal"),
      ),
      body: BlocBuilder<GetListJournalBloc, GetListJournalState>(
        bloc: getListJournalBloc,
        builder: (context, state) {
          if (state is GetListJournalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetListJournalLoaded) {
            return ListView.builder(
              itemCount: state.journal.length,
              itemBuilder: (context, index) {
                final journal = state.journal[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 7.0, horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JournalDetailPage(id: journal.id)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                journal.courseName,
                                style: const TextStyle(
                                  fontFamily: 'roboto',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                journal.time,
                                style: const TextStyle(
                                  fontFamily: 'roboto',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff6A7D94),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                    .format(journal.date),
                                style: const TextStyle(
                                  fontFamily: 'roboto',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff6A7D94),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is GetListJournalError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Koneksi Terputus"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          } else if (state is GetListJournalEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tidak ada jurnal yang tersedia"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text("Tidak ada jurnal yang tersedia"));
        },
      ),
    );
  }

  @override
  void dispose() {
    getListJournalBloc.close();
    super.dispose();
  }
}
