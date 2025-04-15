import 'package:flutter/material.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/presentation/home/pages/main_page.dart';
import 'package:fath_school/presentation/auth/pages/login_page.dart';
import '../../../core/core.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthStatus();
  }

  void _navigateBasedOnAuthStatus() async {
    bool isAuth = await AuthLocalDatasource().isAuth();
    print('Auth status: $isAuth'); // Debug print

    if (isAuth) {
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainPage())),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg_color.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.logoSMKN1Kawali.image(),
            ),
            const Spacer(),
            Assets.images.component.image(height: 85),
            const SpaceHeight(20.0),
          ],
        ),
      ),
    );
  }
}
