import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';
import '../../home/pages/main_page.dart';
import 'forgot_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddingHorizontal = screenSize.width * 0.05;
    final double logoHeight = screenSize.height * 0.2;
    final double spaceHeight = screenSize.height * 0.05;
    final double fieldHeight = screenSize.height * 0.06;
    final double buttonHeight = screenSize.height * 0.07;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: spaceHeight * 4),
              Image.asset(
                Assets.images.logoSMKN1Kawali.path,
                width: screenSize.width * 0.5,
                height: logoHeight,
              ),
              SizedBox(height: spaceHeight),
              CustomTextField(
                controller: emailController,
                label: 'Email Address',
                showLabel: false,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(fieldHeight * 0.2),
                  child: SvgPicture.asset(
                    Assets.icons.email.path,
                    height: fieldHeight * 0.6,
                    width: fieldHeight * 0.6,
                  ),
                ),
              ),
              SizedBox(height: spaceHeight * 0.4),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                showLabel: false,
                obscureText: !isShowPassword,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(fieldHeight * 0.2),
                  child: SvgPicture.asset(
                    Assets.icons.password.path,
                    height: fieldHeight * 0.6,
                    width: fieldHeight * 0.6,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isShowPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                ),
              ),
              SizedBox(height: spaceHeight * 0.1),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Lupa Password?'),
                  onPressed: () {
                    context.push(const ForgotPage());
                  },
                ),
              ),
              SizedBox(height: spaceHeight * 0.2),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (data) {
                      AuthLocalDatasource().saveAuthData(data);
                      context.pushReplacement(const MainPage());
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    },
                  );
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return SizedBox(
                          width: screenSize.width * 0.9,
                          height: buttonHeight,
                          child: Button.filled(
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    LoginEvent.login(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                            },
                            label: 'Sign In',
                          ),
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
              ),
              SizedBox(height: spaceHeight * 1.2),
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
