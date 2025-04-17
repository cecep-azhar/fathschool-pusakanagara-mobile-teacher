import 'package:fath_school/presentation/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fath_school/presentation/auth/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fath_school/core/core.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  late final TextEditingController numberController;

  @override
  void initState() {
    numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddingHorizontal =
        screenSize.width * 0.05; // 10% of screen width
    final double logoHeight = screenSize.height * 0.2; // 20% of screen height
    final double spaceHeight = screenSize.height * 0.05; // 5% of screen height
    final double fieldHeight = screenSize.height * 0.06; // 6% of screen height
    final double buttonHeight = screenSize.height * 0.07; // 7% of screen height

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: spaceHeight * 5.5),
              Image.asset(
                Assets.images.logo.path,
                width: screenSize.width * 0.5, // 50% of screen width
                height: logoHeight,
              ),
              SizedBox(height: spaceHeight),
              CustomTextField(
                controller: numberController,
                label: 'Phone Number',
                showLabel: false,
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.all(fieldHeight * 0.2), // 20% of field height
                  child: SvgPicture.asset(
                    Assets.icons.menu.call.path,
                    height: fieldHeight * 0.6, // 60% of field height
                    width: fieldHeight * 0.6,
                  ),
                ),
              ),
              SizedBox(height: spaceHeight * 0.2), // 20% of space height
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Sudah Punya Akun?'),
                  onPressed: () {
                    context.push(const LoginPage());
                  },
                ),
              ),
              SizedBox(height: spaceHeight * 0.3), // 60% of space height
              BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    // Tampilkan pesan sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kode kata sandi berhasil dikirim.'),
                        backgroundColor: AppColors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                    // Tunggu beberapa detik sebelum kembali ke halaman sebelumnya
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    });
                  } else if (state is ForgotPasswordFailure) {
                    // Tampilkan pesan error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal mengirim kode kata sandi.'),
                        backgroundColor: AppColors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state is ForgotPasswordLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SizedBox(
                        width: screenSize.width * 0.9, // 80% of screen width
                        height: buttonHeight,
                        child: Button.filled(
                          onPressed: () {
                            BlocProvider.of<ForgotPasswordBloc>(context).add(
                              ForgotPasswordRequested(numberController.text),
                            );
                          },
                          label: 'Kirim Verifikasi',
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: spaceHeight * 1.2), // 60% of space height
              Align(
                alignment: Alignment.bottomCenter,
                child: Assets.images.component.image(
                  height: fieldHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
