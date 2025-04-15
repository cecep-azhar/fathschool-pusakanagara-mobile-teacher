import 'package:fath_school/presentation/home/pages/student_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fath_school/presentation/home/bloc/class_info_details/class_info_details_bloc.dart';
import 'package:fath_school/data/models/response/class_info_details_response_model.dart';

class ClassDetailPage extends StatefulWidget {
  final int classId; // Tambahkan parameter classId

  const ClassDetailPage({super.key, required this.classId});

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  @override
  void initState() {
    super.initState();
    // Menggunakan widget.classId untuk memanggil event dari Bloc
    context
        .read<ClassInfoDetailsBloc>()
        .add(LoadClassInfoDetailsById(widget.classId));
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Info Siswa"),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ClassInfoDetailsBloc, ClassInfoDetailsState>(
                  builder: (context, state) {
                    if (state is ClassInfoDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ClassInfoDetailsLoaded) {
                      return _buildClassInfo(state.classInfo);
                    } else if (state is ClassInfoDetailsError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text("Unknown state"));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassInfo(ClassInfoDetailsResponseModel classInfo) {
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
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: double.infinity,
            height: 200.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 0.0, horizontal: 15.0),
                    child: Text(
                      classInfo.className,
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 56.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 0.0, horizontal: 15.0),
                    child: Text(
                      "Total ${classInfo.users.length} Siswa",
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff6A7D94),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ...classInfo.users.map((user) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 100.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentInfoPage(
                                userId: user.userId,
                                absenNo: user.absenNumber)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 0.0, horizontal: 15.0),
                        child: Text(
                          user.userName,
                          style: const TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 0.0, horizontal: 15.0),
                        child: Text(
                          "Nomor Absen ${user.absenNumber}",
                          style: const TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff6A7D94),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
