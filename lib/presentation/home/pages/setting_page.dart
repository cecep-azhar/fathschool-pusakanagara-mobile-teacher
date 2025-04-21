import 'dart:io';
import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/presentation/home/bloc/update_profile/update_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/core/core.dart';
import 'package:fath_school/data/datasources/auth_local_datasource.dart';
import 'package:fath_school/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:fath_school/presentation/auth/pages/login_page.dart';
import 'package:fath_school/presentation/home/pages/app_info_page.dart';
import 'package:fath_school/presentation/home/pages/change_password_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  File? _avatarFile;
  bool _showButtons = false;

  Future<void> _changeAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      bool isValid = true; // Replace with actual validation
      if (isValid) {
        setState(() {
          _avatarFile = File(pickedFile.path);
          _showButtons = true;
        });
      } else {
        _showCustomDialog('Error', 'Invalid image selected.', Colors.red);
      }
    }
  }

  void _showChangeAvatarDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ganti Foto Profile'),
          content: const Text(
              'Apakah Anda yakin ingin mengubah gambar profil Anda?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Iya'),
              onPressed: () {
                Navigator.of(context).pop();
                _changeAvatar();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: color,
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_color.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: 650.0,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.bgUpdate.provider(),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      state.maybeMap(
                        orElse: () {},
                        success: (_) {
                          context.pushReplacement(const LoginPage());
                        },
                        error: (value) {
                          _showCustomDialog(
                              'Error', value.error, AppColors.red);
                        },
                      );
                    },
                  ),
                  BlocListener<UpdateProfileBloc, UpdateProfileState>(
                    listener: (context, state) {
                      state.maybeMap(
                        orElse: () {},
                        success: (value) {
                          // Menyembunyikan tombol setelah update profil berhasil
                          setState(() {
                            _showButtons = false;
                            _avatarFile = null; // Reset avatarFile jika perlu
                          });

                          _showCustomDialog(
                            'Success',
                            'Profile berhasil diperbaharui',
                            Colors.green,
                          );
                        },
                        error: (value) {
                          _showCustomDialog(
                            'Error',
                            'Profile gagal diperbaharui: ${value.error}',
                            AppColors.red,
                          );
                        },
                      );
                    },
                  )
                ],
                child: BlocBuilder<LogoutBloc, LogoutState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100.0),
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: AuthLocalDatasource().getAuthData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    final user = snapshot.data?.user;
                                    final photoUrl =
                                        '${Variables.baseUrl}/storage/images/${user?.profilePhotoPath}' ??
                                            'https://i.pinimg.com/originals/1b/14/53/1b14536a5f7e70664550df4ccaa5b231.jpg';
                                    return GestureDetector(
                                      onTap: () {
                                        if (_avatarFile == null) {
                                          _showChangeAvatarDialog();
                                        } else {
                                          setState(() {
                                            _showButtons = true;
                                          });
                                        }
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: _avatarFile != null
                                                ? Image.file(
                                                    _avatarFile!,
                                                    width: 96.0,
                                                    height: 96.0,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    photoUrl,
                                                    width: 96.0,
                                                    height: 96.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/images/logo.png',
                                                        width: 48.0,
                                                        height: 48.0,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                          ),
                                          Visibility(
                                            visible: _showButtons,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _avatarFile = null;
                                                      _showButtons = false;
                                                    });
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                const SizedBox(width: 10.0),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (_avatarFile != null) {
                                                      final bloc = context.read<
                                                          UpdateProfileBloc>();
                                                      final image = XFile(
                                                          _avatarFile!.path);
                                                      bloc.add(
                                                          UpdateProfileEvent
                                                              .updateProfile(
                                                                  image:
                                                                      image));
                                                    }
                                                  },
                                                  child: const Text('Confirm'),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: AuthLocalDatasource().getAuthData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text('Loading...');
                                  } else {
                                    final user = snapshot.data?.user;
                                    return Column(
                                      children: [
                                        Text(
                                          user?.name ?? 'Chopper Sensei',
                                          style: const TextStyle(
                                            fontSize: 25.0,
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w900,
                                          ),
                                          maxLines: 2,
                                        ),
                                        Text(
                                          user?.idReference ?? '-',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: AppColors.white,
                                          ),
                                          maxLines: 2,
                                        ),
                                        const Text(
                                          'SMKN 1 KAWALI', // user?.role ?? '-',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color.fromARGB(
                                                255, 238, 255, 0),
                                            fontWeight: FontWeight.w900,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 0.0),
                                child: Button.filled(
                                  onPressed: () {
                                    context.push(const ChangePasswordPage());
                                  },
                                  label: 'Ganti Password',
                                  color: AppColors.white,
                                  textColor: AppColors.primary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 0.0),
                                child: Button.filled(
                                  onPressed: () {
                                    context.push(const AppInfoPage());
                                  },
                                  label: 'Info Aplikasi',
                                  color: AppColors.white,
                                  textColor: AppColors.primary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 0.0),
                                child: Button.filled(
                                  onPressed: () {
                                    context
                                        .read<LogoutBloc>()
                                        .add(const LogoutEvent.logout());
                                  },
                                  label: 'Logout',
                                  color: AppColors.white,
                                  textColor: AppColors.red,
                                ),
                              ),
                            ],
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
            ),
          ),
        ),
      ],
    );
  }
}
