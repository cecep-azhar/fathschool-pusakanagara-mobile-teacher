import 'package:flutter/material.dart';
import 'package:fath_school/presentation/home/bloc/get_attendance_by_date/get_attendance_by_date_bloc.dart';
import 'package:fath_school/presentation/home/widgets/history_attendace.dart';
import 'package:fath_school/presentation/home/widgets/history_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/core.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late CalendarFormat _formattedCalendar;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _getAttendanceForCurrentDate();
    initializeDateFormatting();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _formattedCalendar = CalendarFormat.month;
  }

  Future<void> _getAttendanceForCurrentDate() async {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context
        .read<GetAttendanceByDateBloc>()
        .add(GetAttendanceByDateEvent.getAttendanceByDate(currentDate));
  }

  Future<void> _refreshData() async {
    await _getAttendanceForCurrentDate();
  }

  // String _convertToGmt7(String time) {
  //   final utcTime = DateFormat('HH:mm:ss').parseUtc(time);
  //   final gmt7 = tz.getLocation('Asia/Jakarta');
  //   final gmt7Time = tz.TZDateTime.from(utcTime, gmt7);
  //   return DateFormat('HH:mm:ss').format(gmt7Time);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/bg_color.png"),
            fit: BoxFit.fill,
          )),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Riwayat Guru'),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView(
              padding: const EdgeInsets.all(18.0),
              children: [
                TableCalendar(
                  locale: 'id',
                  calendarFormat: _formattedCalendar,
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2019, 1, 15),
                  lastDay: DateTime.now().add(const Duration(days: 7)),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    final selectedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDay);
                    context.read<GetAttendanceByDateBloc>().add(
                          GetAttendanceByDateEvent.getAttendanceByDate(
                              selectedDate),
                        );
                  },
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Bulanan',
                    CalendarFormat.twoWeeks: '2 Pekan',
                    CalendarFormat.week: 'Pekan',
                  },
                  onFormatChanged: (format) => {
                    setState(() {
                      _formattedCalendar = format;
                    })
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: Color(0xff060165), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Colors.blueAccent, shape: BoxShape.circle),
                    weekendTextStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                // CalendarTimeline(
                //   initialDate: DateTime.now(),
                //   firstDate: DateTime(2019, 1, 15),
                //   lastDate: DateTime.now().add(const Duration(days: 7)),
                //   onDateSelected: (date) {
                //     final selectedDate = DateFormat('yyyy-MM-dd').format(date);
                //     context.read<GetAttendanceByDateBloc>().add(
                //       GetAttendanceByDateEvent.getAttendanceByDate(selectedDate),
                //     );
                //   },
                //   leftMargin: 20,
                //   monthColor: AppColors.grey,
                //   dayColor: AppColors.black,
                //   activeDayColor: Colors.white,
                //   activeBackgroundDayColor: AppColors.primary,
                //   showYears: true,
                // ),
                const SpaceHeight(45.0),
                BlocBuilder<GetAttendanceByDateBloc, GetAttendanceByDateState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      error: (message) {
                        return Center(
                          child: Text(message),
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      empty: () {
                        return const Center(
                            child: Text(
                                'Tidak ada absensi yang anda lakukan pada hari ini.'));
                      },
                      loaded: (attendance) {
                        final latlonIn = attendance.latlonIn;
                        final latlonOut = attendance.latlonOut;

                        final latlongInParts =
                            latlonIn?.split(',') ?? ['0.0', '0.0'];
                        final latitudeIn = double.parse(latlongInParts.first);
                        final longitudeIn = double.parse(latlongInParts.last);

                        final latlongOutParts =
                            latlonOut?.split(',') ?? ['0.0', '0.0'];
                        final latitudeOut = double.parse(latlongOutParts.first);
                        final longitudeOut = double.parse(latlongOutParts.last);

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            HistoryAttendance(
                              statusAbsen: 'Datang',
                              // time: attendance.timeIn != null ? _convertToGmt7(attendance.timeIn!) : 'N/A',
                              time: attendance.timeIn != null
                                  ? attendance.timeIn!
                                  : 'N/A',
                              date: attendance.date.toString(),
                            ),
                            const SpaceHeight(10.0),
                            latlonIn != null
                                ? HistoryLocation(
                                    latitude: latitudeIn,
                                    longitude: longitudeIn,
                                  )
                                : const Center(
                                    child: Text(
                                        'Anda tidak melakukan absensi datang.')),
                            const SpaceHeight(25),
                            HistoryAttendance(
                              statusAbsen: 'Pulang',
                              isAttendanceIn: false,
                              // time: attendance.timeOut != null ? _convertToGmt7(attendance.timeOut!) : 'N/A',
                              time: attendance.timeOut != null
                                  ? attendance.timeOut!
                                  : 'N/A',
                              date: attendance.date.toString(),
                            ),
                            const SpaceHeight(10.0),
                            latlonOut != null
                                ? HistoryLocation(
                                    isAttendance: false,
                                    latitude: latitudeOut,
                                    longitude: longitudeOut,
                                  )
                                : const Center(
                                    child: Text(
                                        'Anda belum melakukan absensi pulang.')),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
