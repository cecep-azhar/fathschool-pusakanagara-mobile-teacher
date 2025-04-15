import 'package:fath_school/data/datasources/activity_log_remote_datasource.dart';
import 'package:fath_school/data/datasources/firebase_messanging_remote_datasource.dart';
import 'package:fath_school/data/datasources/info_remote_datasource.dart';
import 'package:fath_school/data/datasources/journal_remote_datasource.dart';
import 'package:fath_school/data/datasources/class_info_remote_datasource.dart';
import 'package:fath_school/data/datasources/mobile_notification_remote_datasource.dart';
import 'package:fath_school/presentation/auth/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fath_school/presentation/home/bloc/add_journal/add_journal_bloc.dart';
import 'package:fath_school/presentation/home/bloc/change_password/change_password_bloc.dart';
import 'package:fath_school/presentation/home/bloc/class_info_details/class_info_details_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_activity_log/get_activity_log_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_detail_journal/get_detail_journal_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_details_permission/get_details_permission_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_details_student/get_details_student_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_leaves_type/get_leaves_type_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_lesson/get_lesson_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_list_journal/get_list_journal_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_mobile_notification/get_mobile_notification_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_permission_list/get_permission_list_bloc.dart';
import 'package:fath_school/presentation/home/bloc/info/info_bloc.dart';
import 'package:fath_school/presentation/home/bloc/is_qredin/is_qredin_bloc.dart';
import 'package:fath_school/presentation/home/bloc/qrin_attendance/qrin_attendance_bloc.dart';
import 'package:fath_school/presentation/home/bloc/qrout_attendance/qrout_attendance_bloc.dart';
import 'package:fath_school/presentation/home/bloc/setting_mobile/setting_mobile_bloc.dart';
import 'package:fath_school/presentation/home/bloc/student_attendance/student_attendance_bloc.dart';
import 'package:fath_school/presentation/home/bloc/class_info/class_info_bloc.dart';
import 'package:fath_school/presentation/home/bloc/update_profile/update_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/data/datasources/attendance_remote_datasource.dart';
import 'package:fath_school/data/datasources/auth_remote_datasource.dart';
import 'package:fath_school/data/datasources/permisson_remote_datasource.dart';
import 'package:fath_school/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:fath_school/presentation/home/bloc/add_permission/add_permission_bloc.dart';
import 'package:fath_school/presentation/home/bloc/checkin_attendance/checkin_attendance_bloc.dart';
import 'package:fath_school/presentation/home/bloc/checkout_attendance/checkout_attendance_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_attendance_by_date/get_attendance_by_date_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_school/get_school_bloc.dart';
import 'package:fath_school/presentation/home/bloc/is_checkedin/is_checkedin_bloc.dart';
import 'package:fath_school/presentation/home/bloc/update_user_register_face/update_user_register_face_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/core.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessangingRemoteDatasource().initialize();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              UpdateUserRegisterFaceBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetSchoolBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => IsCheckedinBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              CheckinAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              CheckoutAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddPermissionBloc(PermissonRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetAttendanceByDateBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetLessonBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => QrinAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              QroutAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => IsQredinBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              StudentAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddJournalBloc(JournalRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetActivityLogBloc(ActivityLogRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ClassInfoBloc(ClassInfoRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              ClassInfoDetailsBloc(ClassInfoRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetDetailsStudentBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetListJournalBloc(JournalRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetDetailJournalBloc(JournalRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetPermissionListBloc(PermissonRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LeavesBloc(PermissonRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetDetailsPermissionBloc(PermissonRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => InfoBloc(InfoRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(authRemoteDatasource: AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              ChangePasswordBloc(datasource: AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              GetMobileNotificationBloc(MobileNotificationRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SettingMobileBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'FathSchool GTK',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme:
              DividerThemeData(color: AppColors.light.withOpacity(0.5)),
          dialogTheme: const DialogTheme(elevation: 0),
          textTheme: GoogleFonts.kumbhSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.kumbhSans(
              color: AppColors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
