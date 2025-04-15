import 'dart:async';

import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:fath_school/presentation/home/bloc/is_qredin/is_qredin_bloc.dart';
import 'package:fath_school/presentation/home/bloc/setting_mobile/setting_mobile_bloc.dart';
import 'package:fath_school/presentation/home/pages/info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/core/helper/radius_calculate.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/presentation/home/bloc/get_school/get_school_bloc.dart';
import 'package:fath_school/presentation/home/bloc/is_checkedin/is_checkedin_bloc.dart';
import 'package:fath_school/presentation/home/pages/attendance_checkin_page.dart';
import 'package:fath_school/presentation/home/pages/attendance_checkout_page.dart';
import 'package:fath_school/presentation/home/pages/class_info_page.dart';
import 'package:fath_school/presentation/home/pages/history_page.dart';
import 'package:fath_school/presentation/home/pages/journal_list_page.dart';
import 'package:fath_school/presentation/home/pages/journal_page.dart';
import 'package:fath_school/presentation/home/pages/permission_list_page.dart';
import 'package:fath_school/presentation/home/pages/permission_page.dart';
import 'package:fath_school/presentation/home/pages/qr_in_page.dart';
import 'package:fath_school/presentation/home/pages/qr_out_page.dart';
import 'package:fath_school/presentation/home/pages/register_face_attendance_page.dart';
import 'package:fath_school/presentation/home/pages/student_history_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../widgets/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? faceEmbedding;
  late StreamSubscription<Position> _positionStreamSubscription;
  double? _latitude;
  double? _longitude;
  String _currentTime = '';
  String? _userName = '';
  String? _role = '';
  String? _profilePhotoPath = '';
  bool _isAlertShown = false;
  String? _currentAppVersion;

  @override
  void initState() {
    super.initState();
    _initializeFaceEmbedding();
    context.read<IsCheckedinBloc>().add(const IsCheckedinEvent.isCheckedIn());
    context.read<GetSchoolBloc>().add(const GetSchoolEvent.getSchool());
    context.read<IsQredinBloc>().add(const IsQredinEvent.isQredin());
    context
        .read<SettingMobileBloc>()
        .add(const SettingMobileEvent.getSettingMobile());
    _requestPermission();
    _getAppVersion();
  }

  Future<void> _initializeFaceEmbedding() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      setState(() {
        faceEmbedding = authData?.user?.faceEmbedding;
      });
    } catch (e) {
      // Tangani error di sini jika ada masalah dalam mendapatkan authData
      if (kDebugMode) {
        print('Error fetching auth data: $e');
      }
      setState(() {
        faceEmbedding = null; // Atur faceEmbedding ke null jika ada kesalahan
      });
    }
  }

  Future<void> _requestPermission() async {
    final Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print('Location service is disabled.');
        }
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('Location permission denied.');
        return;
      }
    }

    _startListeningToPositionStream();
    _fetchUserName();
    _updateTime();
  }

  Future<void> _startListeningToPositionStream() async {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
      },
    );
  }

  void _updateTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now().toFormattedTime();
      });
    });
  }

  Future<void> _fetchUserName() async {
    final authData = await AuthLocalDatasource().getAuthData();
    setState(() {
      _userName = authData?.user?.name ?? 'Hello, Chopper Sensei';
      _profilePhotoPath =
          authData?.user?.profilePhotoPath ?? 'smkn-kawali-1.png';
      _role = authData?.user?.role ?? '';
    });
  }

  Future<void> _refreshData() async {
    _initializeFaceEmbedding();
    context.read<IsCheckedinBloc>().add(const IsCheckedinEvent.isCheckedIn());
    context.read<GetSchoolBloc>().add(const GetSchoolEvent.getSchool());
    context.read<IsQredinBloc>().add(const IsQredinEvent.isQredin());
    context
        .read<SettingMobileBloc>()
        .add(const SettingMobileEvent.getSettingMobile());
    await _startListeningToPositionStream();
    await _fetchUserName();
    await _requestPermission();
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _currentAppVersion = packageInfo.version;
    });
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/bg_color.png"),
              fit: BoxFit.cover,
            )),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.bgUpdate.provider(),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          '${Variables.baseUrl}/storage/images/${_profilePhotoPath ?? 'smkn-kawali-1.png'}',
                          width: 48.0,
                          height: 48.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Jika terjadi error saat memuat gambar dari jaringan, tampilkan gambar dari asset lokal
                            return Image.asset(
                              'assets/images/Logo-SMKN-1-Kawali.png',
                              width: 48.0,
                              height: 48.0,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SpaceWidth(12.0),
                      Expanded(
                        child: Text(
                          'Hello, ${_userName ?? 'Hello'}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: AppColors.white,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),

                  // Row Hero
                  const SpaceHeight(25.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Margin kanan dan kiri
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 214, 252, 3),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(100, 0, 0, 0), // Warna shadow
                          offset: Offset(
                              0, 4), // Posisi shadow (horizontal, vertical)
                          blurRadius: 6.0, // Jarak kabur shadow
                          spreadRadius: 1.0, // Penyebaran shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          _currentTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(DateTime.now()),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 51, 47, 47),
                            fontSize: 12.0,
                          ),
                        ),
                        const SpaceHeight(18.0),
                        const Divider(
                          color: AppColors.primary, //
                        ),
                        const SpaceHeight(18.0),
                        Text(
                          DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .format(DateTime.now()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 51, 47, 47),
                          ),
                        ),
                        const SpaceHeight(6.0),
                        BlocBuilder<GetSchoolBloc, GetSchoolState>(
                          builder: (context, state) {
                            final latitudePoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.latitude!),
                            );
                            final longitudePoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.longtitude!),
                            );

                            final radiusPoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.radius!),
                            );

                            final distanceKm =
                                RadiusCalculate.calculateDistance(
                              _latitude ?? 0.0,
                              _longitude ?? 0.0,
                              latitudePoint,
                              longitudePoint,
                            );

                            final formattedDistance =
                                distanceKm.toStringAsFixed(2);

                            if (distanceKm <= radiusPoint) {
                              return const Text(
                                'Kamu berada di jangkauan absensi',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 51, 47, 47),
                                  fontSize: 12.0,
                                ),
                              );
                            } else {
                              return Text(
                                'Kamu berada di luar jangkauan sejauh $formattedDistance KM',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12.0,
                                ),
                              );
                            }
                          },
                        ),
                        BlocBuilder<SettingMobileBloc, SettingMobileState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loaded: (data) {
                                final productionStatus =
                                    data.productionVersionTeacher ?? '';
                                final appVersion = data.appVersionTeacher ?? '';

                                if (productionStatus == 'Maintenance' &&
                                    !_isAlertShown) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showMaintenanceAlert(context);
                                    setState(() {
                                      _isAlertShown = true;
                                    });
                                  });
                                  return const SizedBox.shrink();
                                } else if (_currentAppVersion != null &&
                                    appVersion != _currentAppVersion &&
                                    !_isAlertShown) {
                                  if (kDebugMode) {
                                    print(
                                        'Current App Version: $_currentAppVersion');
                                  }
                                  if (kDebugMode) {
                                    print(
                                        'App Version from State: $appVersion');
                                  }
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showClosableAlert(
                                        context,
                                        data.googlePlayLinkTeacher!,
                                        appVersion,
                                        _currentAppVersion);
                                    setState(() {
                                      _isAlertShown = true;
                                    });
                                  });
                                  return const SizedBox.shrink();
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                              orElse: () => const SizedBox.shrink(),
                            );
                          },
                        ),
                        const SpaceHeight(6.0),
                        BlocBuilder<GetSchoolBloc, GetSchoolState>(
                          builder: (context, state) {
                            String? timeInString = state.maybeWhen(
                              orElse: () => "00:00",
                              success: (data) => data.timeIn,
                            );
                            String? timeOutString = state.maybeWhen(
                              orElse: () => "00:00",
                              success: (data) => data.timeOut,
                            );

                            return Text(
                              '${timeInString ?? 'N/A'} - ${timeOutString ?? 'N/A'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ), // Akhir Hero

                  const SpaceHeight(25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        BlocBuilder<GetSchoolBloc, GetSchoolState>(
                          builder: (context, state) {
                            final latitudePoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.latitude!),
                            );
                            final longitudePoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.longtitude!),
                            );

                            final radiusPoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.radius!),
                            );

                            // menu datang

                            return BlocConsumer<IsCheckedinBloc,
                                IsCheckedinState>(
                              listener: (context, state) {
                                //
                              },
                              builder: (context, state) {
                                final isCheckin = state.maybeWhen(
                                  orElse: () => false,
                                  success: (data) => data.isCheckedin,
                                );

                                return MenuButton(
                                  label: 'Datang',
                                  iconPath: Assets.icons.menu.datang.path,
                                  onPressed: () async {
                                    // Deteksi lokasi palsu

                                    // masuk page checkin

                                    final distanceKm =
                                        RadiusCalculate.calculateDistance(
                                            _latitude ?? 0.0,
                                            _longitude ?? 0.0,
                                            latitudePoint,
                                            longitudePoint);

                                    final position =
                                        await Geolocator.getCurrentPosition();

                                    if (position.isMocked) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Anda menggunakan lokasi palsu'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (distanceKm > radiusPoint) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Anda diluar jangkauan absen'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (isCheckin) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Anda sudah checkin'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                    } else {
                                      context
                                          .push(const AttendanceCheckinPage());
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                        BlocBuilder<GetSchoolBloc, GetSchoolState>(
                          builder: (context, state) {
                            final latitudePoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.latitude!),
                            );
                            final longitudePoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.longtitude!),
                            );

                            final radiusPoint = state.maybeWhen(
                              orElse: () => 0.0,
                              success: (data) => double.parse(data.radius!),
                            );
                            return BlocBuilder<IsCheckedinBloc,
                                IsCheckedinState>(
                              builder: (context, state) {
                                final isCheckout = state.maybeWhen(
                                  orElse: () => false,
                                  success: (data) => data.isCheckedout,
                                );
                                final isCheckIn = state.maybeWhen(
                                  orElse: () => false,
                                  success: (data) => data.isCheckedin,
                                );
                                return MenuButton(
                                  label: 'Pulang',
                                  iconPath: Assets.icons.menu.pulang.path,
                                  onPressed: () async {
                                    final distanceKm =
                                        RadiusCalculate.calculateDistance(
                                            _latitude ?? 0.0,
                                            _longitude ?? 0.0,
                                            latitudePoint,
                                            longitudePoint);
                                    final position =
                                        await Geolocator.getCurrentPosition();

                                    if (position.isMocked) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Anda menggunakan lokasi palsu'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (kDebugMode) {
                                      print('jarak radius:  $distanceKm');
                                    }

                                    if (distanceKm > radiusPoint) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Anda diluar jangkauan absen'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                      return;
                                    }
                                    if (!isCheckIn) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Anda belum checkin'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                    } else if (isCheckout) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Anda sudah checkout'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                    } else {
                                      context
                                          .push(const AttendanceCheckoutPage());
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                        MenuButton(
                          label: 'Riwayat Guru',
                          iconPath: Assets.icons.menu.riwayat.path,
                          onPressed: () {
                            context.push(const HistoryPage());
                          },
                        ),
                        BlocConsumer<IsQredinBloc, IsQredinState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            final isCheckin = state.maybeWhen(
                              orElse: () => false,
                              success: (data) => data.isCheckedin,
                            );

                            return MenuButton(
                              label: 'Masuk',
                              iconPath: Assets.icons.menu.masuk.path,
                              onPressed: () {
                                if (isCheckin) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Anda sudah melakukan QR In'),
                                      backgroundColor: AppColors.red,
                                    ),
                                  );
                                } else {
                                  context.push(const QRInPage());
                                }
                              },
                            );
                          },
                        ),
                        BlocConsumer<IsQredinBloc, IsQredinState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            final isCheckin = state.maybeWhen(
                              orElse: () => false,
                              success: (data) => data.isCheckedin,
                            );
                            final isCheckout = state.maybeWhen(
                              orElse: () => false,
                              success: (data) => data.isCheckedout,
                            );

                            return MenuButton(
                              label: 'Keluar',
                              iconPath: Assets.icons.menu.keluar.path,
                              onPressed: () {
                                if (!isCheckin) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Anda tidak bisa melakukan QR out'),
                                      backgroundColor: AppColors.red,
                                    ),
                                  );
                                } else if (isCheckout) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Anda sudah melakukan QR Out'),
                                      backgroundColor: AppColors.red,
                                    ),
                                  );
                                } else {
                                  context.push(const QROutPage());
                                }
                              },
                            );
                          },
                        ),
                        MenuButton(
                          label: 'Riwayat Siswa',
                          iconPath: Assets.icons.menu.riwayat.path,
                          onPressed: () {
                            context.push(const StudentHistoryPage());
                          },
                        ),
                        MenuButton(
                          label: 'Izin',
                          iconPath: Assets.icons.menu.izin.path,
                          onPressed: () {
                            context.push(const PermissionPage());
                          },
                        ),
                        MenuButton(
                          label: 'List Izin',
                          iconPath: Assets.icons.menu.catatan.path,
                          onPressed: () {
                            context.push(const PermissionListPage());
                          },
                        ),
                        MenuButton(
                          label: 'Jurnal',
                          iconPath: Assets.icons.menu.jurnal.path,
                          onPressed: () {
                            context.push(const JournalPage());
                          },
                        ),
                        MenuButton(
                          label: 'List Jurnal',
                          iconPath: Assets.icons.menu.catatan.path,
                          onPressed: () {
                            context.push(const JournalListPage());
                          },
                        ),
                        MenuButton(
                          label: 'Info Siswa',
                          iconPath: Assets.icons.menu.info.path,
                          onPressed: () {
                            context.push(const ClassInfoPage());
                          },
                        ),
                        MenuButton(
                          label: 'Info',
                          iconPath: Assets.icons.menu.information.path,
                          onPressed: () {
                            context.push(const InfoPage());
                          },
                        ),
                      ],
                    ),
                  ),
                  const SpaceHeight(24.0),
                  faceEmbedding != null
                      ? BlocBuilder<IsCheckedinBloc, IsCheckedinState>(
                          builder: (context, state) {
                            final isCheckout = state.maybeWhen(
                              orElse: () => false,
                              success: (data) => data.isCheckedout,
                            );
                            final isCheckIn = state.maybeWhen(
                              orElse: () => false,
                              success: (data) => data.isCheckedin,
                            );
                            return BlocBuilder<GetSchoolBloc, GetSchoolState>(
                              builder: (context, state) {
                                final latitudePoint = state.maybeWhen(
                                  orElse: () => 0.0,
                                  success: (data) =>
                                      double.parse(data.latitude!),
                                );
                                final longitudePoint = state.maybeWhen(
                                  orElse: () => 0.0,
                                  success: (data) =>
                                      double.parse(data.longtitude!),
                                );

                                final radiusPoint = state.maybeWhen(
                                  orElse: () => 0.0,
                                  success: (data) => double.parse(data.radius!),
                                );
                                return Button.filled(
                                  onPressed: () async {
                                    final distanceKm =
                                        RadiusCalculate.calculateDistance(
                                            _latitude ?? 0.0,
                                            _longitude ?? 0.0,
                                            latitudePoint,
                                            longitudePoint);

                                    final position =
                                        await Geolocator.getCurrentPosition();

                                    if (position.isMocked) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Anda menggunakan lokasi palsu'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (kDebugMode) {
                                      print('jarak radius:  $distanceKm');
                                    }

                                    if (distanceKm > radiusPoint) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Anda diluar jangkauan absen'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (!isCheckIn) {
                                      context
                                          .push(const AttendanceCheckinPage());
                                    } else if (!isCheckout) {
                                      context
                                          .push(const AttendanceCheckoutPage());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Anda sudah checkout'),
                                          backgroundColor: AppColors.red,
                                        ),
                                      );
                                    }

                                    // context.push(const SettingPage());
                                  },
                                  label: 'Kehadiran Wajah & GPS',
                                  icon: Assets.icons.attendance.svg(),
                                  color: AppColors.primary,
                                );
                              },
                            );
                          },
                        )
                      : Button.filled(
                          onPressed: () {
                            showBottomSheet(
                              backgroundColor: AppColors.white,
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 60.0,
                                      height: 8.0,
                                      child:
                                          Divider(color: AppColors.lightSheet),
                                    ),
                                    const CloseButton(),
                                    const Center(
                                      child: Text(
                                        'Oops !',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.0,
                                        ),
                                      ),
                                    ),
                                    const SpaceHeight(4.0),
                                    const Center(
                                      child: Text(
                                        'Aplikasi ingin mengakses Kamera',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    const SpaceHeight(36.0),
                                    Button.filled(
                                      onPressed: () => context.pop(),
                                      label: 'Tolak',
                                      color: AppColors.secondary,
                                    ),
                                    const SpaceHeight(16.0),
                                    Button.filled(
                                      onPressed: () {
                                        context.pop();
                                        context.push(
                                            const RegisterFaceAttendencePage());
                                      },
                                      label: 'Izinkan',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          label: 'Kehadiran dengan ID Wajah',
                          icon: Assets.icons.attendance.svg(),
                          color: AppColors.red,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $urlString');
  }
}

// Fungsi untuk menampilkan alert yang bisa ditutup
void showClosableAlert(BuildContext context, String url, String version,
    String? currentAppVersion) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Pembaruan Diperlukan'),
          content: Text(
            "Versi terbaru dari aplikasi sudah tersedia (v$version). Saat ini Anda menggunakan versi v$currentAppVersion.\n\n"
            "Untuk mendapatkan fitur terbaru dan perbaikan, silakan unduh versi terbaru dari aplikasi di Google Play Store.",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Download'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog first
                _launchURL(url); // Then launch the URL
              },
            ),
          ],
        ),
      );
    },
  );
}

void showMaintenanceAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Aplikasi Sedang Dalam Pemeliharaan'),
          content: const Text(
            "Kami sedang melakukan pemeliharaan rutin untuk meningkatkan kualitas layanan kami. Aplikasi ini akan kembali dapat diakses segera setelah pemeliharaan selesai.\n\n"
            "Kami mohon maaf atas ketidaknyamanan ini dan terima kasih atas kesabaran Anda.\n\n"
            "Salam,\nTim Pengembang",
          ),
          actions: [
            BlocBuilder<LogoutBloc, LogoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return ElevatedButton(
                      onPressed: () {
                        context
                            .read<LogoutBloc>()
                            .add(const LogoutEvent.logout());
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.white,
                        backgroundColor: AppColors.red, // Warna teks
                      ),
                      child: const Text('Logout'),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void showRoleAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent dismissing when tapping outside the dialog
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async =>
            false, // Prevent dismissing when back button is pressed
        child: const AlertDialog(
          title: Text('Akses ditolak'),
          content: Text("Anda tidak memiliki akses ke dalam aplikasi ini.\n\n"
              "Silahkan download sesuai dengan akses yang anda miliki.\n\n"),
        ),
      );
    },
  );
}
