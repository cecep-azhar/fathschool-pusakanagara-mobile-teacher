import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fath_school/presentation/home/bloc/change_password/change_password_bloc.dart';

import '../../../core/core.dart'; // Sesuaikan dengan path yang benarimport 'change_password_bloc.dart'; // Import Bloc yang telah Anda buat

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key}); // Perbaiki parameter key

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  bool isShowPassword = false;

  @override
  void initState() {
    confirmPasswordController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Ganti Password"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_color.png"), // Sesuaikan dengan path gambar latar belakang
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    showLabel: false,
                    obscureText: !isShowPassword,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        Assets.icons.password.path,
                        height: 20,
                        width: 20,
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: confirmPasswordController,
                    label: 'Konfirmasi Password',
                    showLabel: false,
                    obscureText: !isShowPassword,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        Assets.icons.password.path,
                        height: 20,
                        width: 20,
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
                  const SizedBox(height: 20),
                    BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (state is! ChangePasswordLoading) {
                              final password = passwordController.text.trim();
                              final confirmPassword = confirmPasswordController.text.trim();
                              
                              if (password.isEmpty || confirmPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password tidak boleh kosong.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                context.read<ChangePasswordBloc>().add(
                                  ChangePasswordRequested(
                                    password: password,
                                    passwordConfirmation: confirmPassword,
                                  ),
                                );
                              }
                            }
                          },
                           style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blue, // Warna teks
                            ),
                          child: state is ChangePasswordLoading
                              ? const CircularProgressIndicator()
                              : const Text('Ubah'),
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                  BlocListener<ChangePasswordBloc, ChangePasswordState>(
                    listener: (context, state) {
                      if (state is ChangePasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password berhasil diubah.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Contoh untuk kembali ke halaman sebelumnya setelah sukses
                        Navigator.pop(context);
                      } else if (state is ChangePasswordFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal mengubah password: ${state.error}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(), // Widget ini tidak menggambarkan UI tambahan
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
