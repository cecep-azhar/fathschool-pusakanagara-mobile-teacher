import 'package:flutter/material.dart';
import 'package:fath_school/presentation/auth/pages/onboarding_1_page.dart';
import 'package:fath_school/presentation/auth/pages/onboarding_3_page.dart';

class OnBoarding2Page extends StatefulWidget {
  const OnBoarding2Page({super.key});

  @override
  State<OnBoarding2Page> createState() => _OnBoarding2PageState();
}

class _OnBoarding2PageState extends State<OnBoarding2Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double verticalPadding =
        screenSize.height * 0.07; // 7% of screen height
    final double horizontalPadding =
        screenSize.width * 0.1; // 10% of screen width
    final double imageHeight = screenSize.height * 0.19; // 40% of screen height
    final double titleFontSize = screenSize.width * 0.08; // 8% of screen width
    final double descriptionFontSize =
        screenSize.width * 0.05; // 5% of screen width
    final double buttonSize = screenSize.width * 0.15; // 15% of screen width

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_color.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: verticalPadding),
            Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: Image(
                image: const AssetImage('assets/images/on2.png'),
                height: imageHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding * 0.2),
              child: Text(
                '''
Kenalkan Aplikasi FathSchool
__________________
                ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                '''
FathSchool adalah sistem informasi sekolah terintegrasi yang menawarkan solusi lengkap untuk manajemen administrasi dan kegiatan akademik.
                ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.normal,
                  fontSize: descriptionFontSize,
                ),
              ),
            ),
            SizedBox(height: verticalPadding * 0.2),
            Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(const OnBoarding1Page());
                    },
                    child: Image(
                      image: const AssetImage('assets/images/back.png'),
                      width: buttonSize,
                      height: buttonSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const OnBoarding3Page());
                    },
                    child: Image(
                      image: const AssetImage('assets/images/next.png'),
                      width: buttonSize,
                      height: buttonSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
