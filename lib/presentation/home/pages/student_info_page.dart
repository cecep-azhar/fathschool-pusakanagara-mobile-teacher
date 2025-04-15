import 'package:fath_school/data/models/response/student_details_response_model.dart';
import 'package:fath_school/presentation/home/bloc/get_details_student/get_details_student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class StudentInfoPage extends StatefulWidget {
  final int userId;
  final int absenNo;

  const StudentInfoPage(
      {super.key, required this.userId, required this.absenNo});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetDetailsStudentBloc>()
        .add(LoadUserDetailsById(widget.userId));
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
          )),
        ),
        Scaffold(
          appBar: AppBar(
              title: const Text("Info Siswa"),
              backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              BlocBuilder<GetDetailsStudentBloc, GetDetailsStudentState>(
                builder: (context, state) {
                  if (state is GetDetailsStudentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetDetailsStudentLoaded) {
                    return _buildUserDetails(state.userdetails, widget.absenNo);
                  } else if (state is GetDetailsStudentError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text("Unknown state"));
                  }
                },
              )
            ]),
          ),
        ),
      ],
    );
  }
}

Widget _buildUserDetails(StudentDetailsResponseModel userdetails, int absenNo) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ]),
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                  userdetails.profilePhotoUrl,
                  width: 128.0,
                  height: 128.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.network(
                      userdetails.profilePhotoUrl,
                      width: 128.0,
                      height: 128.0,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '''
Nama: ${userdetails.name}
Nomor Absen: $absenNo
NIS : ${userdetails.idReference ?? '-'}
Alamat: ${userdetails.address}
Telepon: ${userdetails.phone}
Nama Ortu/Wali: -
Telp. Ortu/Wali: -
                                        ''',
                    style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
