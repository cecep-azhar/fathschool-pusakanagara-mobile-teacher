import 'package:flutter/material.dart';
import 'package:fath_school/presentation/auth/pages/login_page.dart';
import 'package:fath_school/presentation/auth/pages/onboarding_3_page.dart';

class OnBoarding4Page extends StatefulWidget {
  const OnBoarding4Page({super.key});

  @override
  State<OnBoarding4Page> createState() => _OnBoarding4PageState();
}

class _OnBoarding4PageState extends State<OnBoarding4Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double verticalPadding = screenSize.height * 0.02; // 2% of screen height
    final double horizontalPadding = screenSize.width * 0.1; // 10% of screen width
    final double imageHeight = screenSize.height * 0.46; // 40% of screen height
    final double titleFontSize = screenSize.width * 0.06; // 6% of screen width
    final double subtitleFontSize = screenSize.width * 0.045; // 4.5% of screen width
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
              padding: EdgeInsets.all(horizontalPadding * 0.2),
              child: Image(
                image: const AssetImage('assets/images/on4.png'),
                height: imageHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Text(
                '''
Digunakan Oleh
SMKN 1 Kota Bengkulu 
SMK Nurul Islam Cianjur 
SMKS Muhammadiyah 3 Bandung  
                ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ),
            SizedBox(height: verticalPadding),
            Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(const OnBoarding3Page());
                    },
                    child: Image(
                      image: const AssetImage('assets/images/back.png'),
                      width: buttonSize,
                      height: buttonSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const LoginPage());
                    },
                    child: Image(
                      image: const AssetImage('assets/images/toLogin.png'),
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
