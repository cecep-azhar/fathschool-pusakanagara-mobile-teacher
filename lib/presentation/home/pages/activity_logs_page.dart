import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/presentation/home/bloc/get_activity_log/get_activity_log_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ActivityLogsPage extends StatefulWidget {
  const ActivityLogsPage({super.key});

  @override
  State<ActivityLogsPage> createState() => _ActivityLogsPageState();
}

class _ActivityLogsPageState extends State<ActivityLogsPage> {
  late GetActivityLogBloc _activityLogBloc;

  @override
  void initState() {
    super.initState();
    _activityLogBloc = context.read<GetActivityLogBloc>();
    _initialize();
  }

  Future<void> _initialize() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final userId = authData?.user?.id ?? 0; // Ensure userId is an int

    // Fetch the activity logs with the userId
    _activityLogBloc.add(FetchActivityLog(userId));
  }

  Future<void> _refresh() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final userId = authData?.user?.id ?? 0;
    _activityLogBloc.add(FetchActivityLog(userId));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddingHorizontal =
        screenSize.width * 0.03; // 5% of screen width
    final double paddingVertical =
        screenSize.height * 0.01; // 1% of screen height

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
            title: const Text('Aktifitas'),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: BlocBuilder<GetActivityLogBloc, GetActivityLogState>(
              builder: (context, state) {
                if (state is ActivityLogLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ActivityLogLoaded) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                        vertical: paddingVertical,
                      ),
                      child: Column(
                        children: state.activityLogs.map((log) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: paddingVertical),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
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
                                  child: Padding(
                                    padding: EdgeInsets.all(paddingHorizontal),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${log.time} WIB',
                                          style: const TextStyle(
                                            fontFamily: 'roboto',
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: paddingVertical),
                                        Text(
                                          DateFormat(
                                                  "EEEE, d MMMM yyyy", "id_ID")
                                              .format(log.createdAt),
                                          style: const TextStyle(
                                            fontFamily: 'roboto',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff6A7D94),
                                          ),
                                        ),
                                        SizedBox(height: paddingVertical * 1),
                                        Text(
                                          log.description,
                                          style: const TextStyle(
                                            fontFamily: 'roboto',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff6A7D94),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                } else if (state is ActivityLogError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Koneksi Terputus'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _refresh,
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                } else if (state is ActivityLogEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Tidak ada aktifitas'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _refresh,
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('Tidak ada aktifitas'));
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
