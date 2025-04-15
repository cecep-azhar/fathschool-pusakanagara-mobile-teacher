import 'dart:convert';

import 'package:fath_school/presentation/home/bloc/get_lesson/get_lesson_bloc.dart';
import 'package:fath_school/presentation/home/bloc/qrin_attendance/qrin_attendance_bloc.dart';
import 'package:fath_school/presentation/home/pages/qr_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRInPage extends StatefulWidget {
  const QRInPage({super.key});

  @override
  _QRInPageState createState() => _QRInPageState();
}

class _QRInPageState extends State<QRInPage> {
  bool isScanned = false;
  String scannedData = '';
  double overlayLeft = 0.0;
  double overlayTop = 0.0;
  double overlayWidth = 0.0;
  double overlayHeight = 0.0;

  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    context.read<GetLessonBloc>().add(const GetLessonEvent.getLesson());
  }

  void _onDetect(BarcodeCapture barcodeCapture, String qrCodeId) async {
    if (!isScanned) {
      final Barcode barcode = barcodeCapture.barcodes.first;

      setState(() {
        overlayLeft = barcode.corners.first.dx;
        overlayTop = barcode.corners.first.dy;
        overlayWidth = (barcode.corners[2].dx - barcode.corners[0].dx) +
            50; // Added padding
        overlayHeight = (barcode.corners[2].dy - barcode.corners[0].dy) +
            50; // Added padding
      });

      // 🔹 Periksa apakah barcode berada dalam area overlay
      bool isWithinOverlay = barcode.corners.every((point) {
        return point.dx >= overlayLeft &&
            point.dx <= overlayLeft + overlayWidth &&
            point.dy >= overlayTop &&
            point.dy <= overlayTop + overlayHeight;
      });

      if (isWithinOverlay) {
        setState(() {
          isScanned = true;
          scannedData = barcode.rawValue ?? 'Unknown data';
        });

        // 🔹 Ambil lokasi pengguna saat scan
        Location location = Location();

        bool serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            _showLocationErrorDialog(
                "GPS harus diaktifkan untuk melakukan absensi.");
            return;
          }
        }

        PermissionStatus permissionGranted = await location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();
          if (permissionGranted != PermissionStatus.granted) {
            _showLocationErrorDialog("Izin lokasi diperlukan untuk absensi.");
            return;
          }
        }

        LocationData locationData = await location.getLocation();
        double latitude = locationData.latitude ?? 0.0;
        double longitude = locationData.longitude ?? 0.0;

        print("Lokasi pengguna: Lat: $latitude, Lng: $longitude");

        // 🔹 Kirim event ke Bloc jika QR Code sesuai
        if ((scannedData) == qrCodeId) {
          context.read<QrinAttendanceBloc>().add(
                QrinAttendanceEvent.qrin(
                  qrCodeId,
                  latitude.toString(),
                  longitude.toString(),
                ),
              );
        } else {
          await _showInvalidQRCodeDialog();
        }
      }
    }
  }

  void _showLocationErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Kesalahan Lokasi"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInvalidQRCodeDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Code Invalid'),
        content: const Text('QR Code is incorrect'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    setState(() {
      isScanned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<GetLessonBloc, GetLessonState>(
      builder: (context, lessonState) {
        return lessonState.maybeWhen(
          success: (lesson) {
            return BlocListener<QrinAttendanceBloc, QrinAttendanceState>(
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (responseModel) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QrSuccessPage(
                          status: 'Berhasil Masuk Kelas',
                        ),
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Masuk'),
                  ),
                  body: Stack(
                    children: [
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        width: size.width,
                        height: size.height,
                        child: MobileScanner(
                          controller: _scannerController,
                          onDetect: (barcodeCapture) async {
                            // Panggil _onDetect dengan lokasi yang diperoleh
                            _onDetect(
                              barcodeCapture,
                              lesson[0].qrCodeId ?? '',
                            );
                          },
                        ),
                      ),
                      // Overlay box
                      Positioned(
                        top: overlayTop,
                        left: overlayLeft,
                        child: Container(
                          width: overlayWidth,
                          height: overlayHeight,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20.0,
                        left: 40.0,
                        right: 40.0,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.47),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            isScanned ? 'QR Code Valid' : 'Scan a QR Code',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5.0,
                        left: 0.0,
                        right: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.47),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Absensi Masuk',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          lesson.isNotEmpty
                                              ? lesson[0].className.toString()
                                              : 'Loading...',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Reverse camera functionality
                                      _scannerController.switchCamera();
                                    },
                                    icon: const Icon(Icons.flip_camera_android,
                                        size: 48.0, color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Torch functionality
                                      _scannerController.toggleTorch();
                                    },
                                    icon: const Icon(Icons.flash_on,
                                        size: 48.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          orElse: () => SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Masuk'),
              ),
              body: Stack(
                children: [
                  // Jika kamera tidak diakses, tampilkan loading indicator
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    width: size.width,
                    height: size.height,
                    child: Container(
                      color: Colors.black.withOpacity(
                          0.5), // Menambahkan latar belakang semi-transparan
                      child: const Center(
                        child:
                            CircularProgressIndicator(), // Loading indicator di tengah
                      ),
                    ),
                  ),
                  // Overlay box
                  Positioned(
                    top: overlayTop,
                    left: overlayLeft,
                    child: Container(
                      width: overlayWidth,
                      height: overlayHeight,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 40.0,
                    right: 40.0,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.47),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        'Tidak ada jadwal',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.0,
                    left: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.47),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Absensi Masuk',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Tidak ada jadwal',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Reverse camera functionality
                                  // _scannerController.switchCamera();
                                },
                                icon: const Icon(Icons.flip_camera_android,
                                    size: 48.0, color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Torch functionality
                                  // _scannerController.toggleTorch();
                                },
                                icon: const Icon(Icons.flash_on,
                                    size: 48.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
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
  }
}
