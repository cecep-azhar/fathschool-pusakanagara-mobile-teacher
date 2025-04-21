import 'package:fath_school/presentation/home/bloc/setting_mobile/setting_mobile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/core/assets/assets.gen.dart';
import 'package:fath_school/core/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  String? _currentAppVersion;

  @override
  void initState() {
    super.initState();
    context
        .read<SettingMobileBloc>()
        .add(const SettingMobileEvent.getSettingMobile());
    _getAppVersion();
  }

  Future<void> _refreshData() async {
    context
        .read<SettingMobileBloc>()
        .add(const SettingMobileEvent.getSettingMobile());
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _currentAppVersion = packageInfo.version;
    });
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
          )),
        ),
        Scaffold(
          appBar: AppBar(
              title: const Text("Info Aplikasi"),
              backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: BlocBuilder<SettingMobileBloc, SettingMobileState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (data) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 20.0),
                          child: Image(
                            image: AssetImage('assets/images/Frame.png'),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 20.0),
                          child: Text(
                            '''
Deskripsi Aplikasi FathSchool

${data.descriptionApps}

Fitur Utama

${data.featuresApps}

Keunggulan FathSchool 

${data.advantagesApps}

Kesimpulan

${data.conclusionApps}
                      ''',
                            style: const TextStyle(
                                fontFamily: 'roboto',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all()),
                              child: IconButton(
                                  onPressed: () async {
                                    await launchUrl(Uri.parse(
                                        'https://wa.me/${data.fathforcePhoneNumber}'));
                                  },
                                  icon: Assets.icons.menu.call.svg()),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all()),
                              child: IconButton(
                                  onPressed: () async {
                                    await launchUrl(Uri.parse(
                                        '${data.fathforceBrowserLink}'));
                                  },
                                  icon: Assets.icons.menu.web.svg()),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all()),
                              child: IconButton(
                                  onPressed: () async {
                                    await launchUrl(
                                        Uri.parse('${data.fathforceEmail}'));
                                  },
                                  icon: Assets.icons.email.svg(
                                      color: Colors.black,
                                      width: 32.0,
                                      height: 32.0)),
                            ),
                          ],
                        ),
                        const SpaceHeight(10.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/logo-round-plan-blue.png'),
                              width: 120.0,
                              height: 120.0,
                            ),
                            Image(
                              image: AssetImage('assets/images/logo.png'),
                              width: 95.0,
                              height: 95.0,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Versi Aplikasi: $_currentAppVersion',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
