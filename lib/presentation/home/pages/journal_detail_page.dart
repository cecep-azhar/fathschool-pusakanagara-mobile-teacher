import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/models/response/journal_response_model.dart';
import 'package:fath_school/presentation/home/bloc/get_detail_journal/get_detail_journal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class JournalDetailPage extends StatefulWidget {
  final int id;

  const JournalDetailPage({super.key, required this.id});

  @override
  State<JournalDetailPage> createState() => _JournalDetailPageState();
}

class _JournalDetailPageState extends State<JournalDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetDetailJournalBloc>().add(FetchListJournal(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_color.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text("Detail Jurnal"),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<GetDetailJournalBloc, GetDetailJournalState>(
                    builder: (context, state) {
                      if (state is GetDetailJournalLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GetDetailJournalLoaded) {
                        return _buildDetailJournal(state.journal);
                      } else if (state is GetDetailJournalError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const Center(child: Text("Unknown state"));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailJournal(JournalResponseModel journal) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
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
                ),
              ],
            ),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 20.0, horizontal: 15.0),
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
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat("EEEE, d MMMM yyyy", "id_ID")
                          .format(journal.date),
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff6A7D94),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 0.0, horizontal: 15.0),
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
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      journal.description,
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 19.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Image.network(
                  "${Variables.baseUrl}/storage/${journal.img}",
                  width: 450.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Jika terjadi error saat memuat gambar, tampilkan gambar default
                    return Image.asset(
                      'assets/images/logo.png',
                      width: 450.0,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                const SizedBox(height: 130),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Security Code: ${journal.securityCode}",
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
