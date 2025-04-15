import 'package:fath_school/data/models/response/student_attendance_response_model.dart';
import 'package:fath_school/presentation/home/bloc/student_attendance/student_attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/presentation/home/pages/student_info_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentHistoryPage extends StatefulWidget {
  const StudentHistoryPage({super.key});

  @override
  State<StudentHistoryPage> createState() => _StudentHistoryPageState();
}

class _StudentHistoryPageState extends State<StudentHistoryPage> {
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
        .read<StudentAttendanceBloc>()
        .add(StudentAttendanceEvent.getStudentAttendance(currentDate));
  }

  Future<void> _refreshData() async {
    await _getAttendanceForCurrentDate();
  }

  String _convertToGmt7(String time) {
    final utcTime = DateFormat('HH:mm:ss').parseUtc(time);
    final gmt7 = tz.getLocation('Asia/Jakarta');
    final gmt7Time = tz.TZDateTime.from(utcTime, gmt7);
    return DateFormat('HH:mm:ss').format(gmt7Time);
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
            backgroundColor: Colors.transparent,
            title: const Text('Riwayat Siswa'),
          ),
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(18.0),
                  children: [
                    TableCalendar(
                      locale: 'id',
                      calendarFormat: _formattedCalendar,
                      focusedDay: _focusedDay,
                      firstDay: DateTime(2019, 1, 15),
                      lastDay: DateTime.now().add(const Duration(days: 7)),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        final selectedDate =
                            DateFormat('yyyy-MM-dd').format(selectedDay);
                        context.read<StudentAttendanceBloc>().add(
                              StudentAttendanceEvent.getStudentAttendance(
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
                          color: Color(0xff060165),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    BlocBuilder<StudentAttendanceBloc, StudentAttendanceState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          initial: () =>
                              const Center(child: Text('Initial state')),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          empty: () {
                            return const Center(
                                child: Text(
                                    'Tidak ada absensi siswa yang dilakukan pada hari ini.'));
                          },
                          loaded: (data) => Column(
                            children: data
                                .map((datum) => _buildClassTile(
                                      datum.courseName ?? '',
                                      datum.total!.present.toString(),
                                      datum.total!.permission.toString(),
                                      datum.total!.absent.toString(),
                                      datum,
                                    ))
                                .toList(),
                          ),
                          error: (message) {
                            return Center(
                              child: Text(message),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassTile(String className, String hadir, String izin,
      String tanpaKet, loadedData) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6.0),
              ),
              width: 50.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('dd').format(DateTime.now()),
                      style:
                          const TextStyle(fontSize: 24, color: Colors.white)),
                  Text(DateFormat('EEE').format(DateTime.now()),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(className,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text("Hadir: $hadir Izin: $izin Tanpa Ket: $tanpaKet",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
        children: <Widget>[
          _buildCategoryDetails("Hadir", loadedData.students.present),
          _buildCategoryDetails("Izin", loadedData.students.permission),
          _buildCategoryDetails("Tanpa Ket", loadedData.students.absent),
        ],
      ),
    );
  }

  Widget _buildCategoryDetails(String category, List<Absent> students) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(category,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        ...students.map(
            (datum) => _buildStudentDetails(datum.name ?? '', datum.id ?? 0)),
      ],
    );
  }

  Widget _buildStudentDetails(String name, int id) {
    return InkWell(
      onTap: () {
        if (id != -1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentInfoPage(
                        userId: id,
                        absenNo: 0,
                      )));
        }
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(name, style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
