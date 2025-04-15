import 'package:flutter/material.dart';
import 'package:fath_school/presentation/auth/pages/onboarding_2_page.dart';
import 'package:fath_school/presentation/auth/pages/onboarding_4_page.dart';

class OnBoarding3Page extends StatefulWidget {
  const OnBoarding3Page({super.key});

  @override
  State<OnBoarding3Page> createState() => _OnBoarding3PageState();
}

class _OnBoarding3PageState extends State<OnBoarding3Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double verticalPadding = screenSize.height * 0.07; // 7% of screen height
    final double horizontalPadding = screenSize.width * 0.1; // 10% of screen width
    final double imageHeight = screenSize.height * 0.4; // 40% of screen height
    final double titleFontSize = screenSize.width * 0.06; // 6% of screen width
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
                image: const AssetImage('assets/images/on3.png'),
                height: imageHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding * 0.2),
              child: Text(
                '''
Build With ❤︎
Dikembangkan oleh PT. Fath Synergy Group & SMKN 1 Kawali
                ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
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
                      context.push(const OnBoarding2Page());
                    },
                    child: Image(
                      image: const AssetImage('assets/images/back.png'),
                      width: buttonSize,
                      height: buttonSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const OnBoarding4Page());
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
