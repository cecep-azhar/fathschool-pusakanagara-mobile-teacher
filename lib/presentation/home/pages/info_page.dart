import 'package:fath_school/presentation/home/bloc/info/info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fath_school/data/datasources/info_remote_datasource.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfoBloc(InfoRemoteDatasource())..add(const InfoEvent.fetchInfo()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List Info"),
        ),
        body: BlocBuilder<InfoBloc, InfoState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const Center(child: Text("Loading...")),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              loaded: (loadedState) {
                final infoList = loadedState.info;
                if (infoList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Tidak ada data yang tersedia"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => context
                              .read<InfoBloc>()
                              .add(const InfoEvent.fetchInfo()),
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: infoList.length,
                  itemBuilder: (context, index) {
                    final info = infoList[index];
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
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 100.0,
                        child: InkWell(
                          onTap: () {
                            // Handle on tap
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    info.title,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    info.description,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                        .format(info.createdAt),
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
              },
              error: (errorState) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(errorState.message),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context
                          .read<InfoBloc>()
                          .add(const InfoEvent.fetchInfo()),
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
