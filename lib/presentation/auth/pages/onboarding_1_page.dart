import 'package:flutter/material.dart';
import 'package:fath_school/presentation/auth/pages/onboarding_2_page.dart';

class OnBoarding1Page extends StatefulWidget {
  const OnBoarding1Page({super.key});

  @override
  State<OnBoarding1Page> createState() => _OnBoarding1PageState();
}

class _OnBoarding1PageState extends State<OnBoarding1Page> {
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
    final double imageHeight = screenSize.height * 0.4; // 40% of screen height
    final double fontSize = screenSize.width * 0.08; // 8% of screen width
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
                image: const AssetImage('assets/images/on1.png'),
                height: imageHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                '''
Banyak Aplikasi Sekolah Tapi Tidak Terintegrasi ?
                ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
            SizedBox(
                height: verticalPadding * 0.2), // Adjust the spacing as needed
            GestureDetector(
              onTap: () {
                context.push(const OnBoarding2Page());
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
    );
  }
}
