import 'package:fath_school/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class QrSuccessPage extends StatelessWidget {
  final String status;
  const QrSuccessPage({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.success.image(),
            const Text(
              'Berhasil !',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(8.0),
            Center(
              child: Text(
                'Anda telah melakukan Absensi $status Pukul ${DateTime.now().toFormattedTime()}. Selamat bekerja ',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SpaceHeight(80.0),
            Button.filled(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                  (Route<dynamic> route) => false,
                );
              },
              label: 'Oke, dimengerti',
            ),
          ],
        ),
      ),
    );
  }
}
