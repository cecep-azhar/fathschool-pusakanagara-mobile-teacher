import 'package:fath_school/presentation/home/bloc/get_school/get_school_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/presentation/home/pages/activity_logs_page.dart';
import 'package:fath_school/presentation/home/pages/home_page.dart';
import 'package:fath_school/presentation/home/pages/notification_page.dart';
import 'package:fath_school/presentation/home/pages/setting_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _widgets = [
    // const HomePage(),
    const HomePage(),
    const ActivityLogsPage(),
    const Center(child: Text('ini halaman wa')),
    const NotificationPage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<GetSchoolBloc>().add(const GetSchoolEvent.getSchool());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgets,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 16.0,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BlocBuilder<GetSchoolBloc, GetSchoolState>(
            builder: (context, state) {
              final phoneNumber = state.maybeWhen(
                success: (data) => data.appPhone,
                orElse: () => '',
              );

              return BottomNavigationBar(
                useLegacyColorScheme: false,
                currentIndex: _selectedIndex,
                onTap: (value) async {
                  if (value == 2) {
                    if (phoneNumber!.isNotEmpty) {
                      await launchUrl(Uri.parse('https://wa.me/$phoneNumber'));
                    } else {
                      // Handle case where phone number is not available
                    }
                  } else {
                    setState(() => _selectedIndex = value);
                  }
                },
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: const TextStyle(color: AppColors.primary),
                selectedIconTheme:
                    const IconThemeData(color: AppColors.primary),
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Assets.icons.nav.home.svg(
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 0
                            ? AppColors.primary
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.nav.history.svg(
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 1
                            ? AppColors.primary
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Aktifitas',
                  ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.nav.phoneMenu.svg(
                      width: 25.0,
                      height: 25.0,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 2
                            ? AppColors.primary
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.notif.svg(
                      width: 30.0,
                      height: 30.0,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 3
                            ? AppColors.primary
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Notifikasi',
                  ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.nav.profile.svg(
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 4
                            ? AppColors.primary
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
