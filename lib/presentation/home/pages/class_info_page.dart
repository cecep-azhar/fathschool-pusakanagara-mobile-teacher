import 'package:fath_school/data/datasources/class_info_remote_datasource.dart';
import 'package:fath_school/presentation/home/bloc/class_info/class_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Sesuaikan dengan import yang sesuai di aplikasi Anda
import 'package:fath_school/presentation/home/pages/class_detail_page.dart'; // Jika diperlukan

class ClassInfoPage extends StatefulWidget {
  const ClassInfoPage({super.key});

  @override
  State<ClassInfoPage> createState() => _ClassInfoPageState();
}

class _ClassInfoPageState extends State<ClassInfoPage> {
  final classInfoBloc = ClassInfoBloc(ClassInfoRemoteDatasource());

  @override
  void initState() {
    super.initState();
    classInfoBloc.add(const FetchClassInfo());
  }

  Future<void> _refresh() async {
    classInfoBloc.add(const FetchClassInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Siswa"),
      ),
      body: BlocBuilder<ClassInfoBloc, ClassInfoState>(
        bloc: classInfoBloc,
        builder: (context, state) {
          if (state is ClassInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClassInfoLoaded) {
            return ListView.builder(
              itemCount: state.classinfo.length,
              itemBuilder: (context, index) {
                final classInfo = state.classinfo[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: ListTile(
                      title: Text(
                        classInfo.name,
                        style: const TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 21.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text("Total ${classInfo.totalUser} Siswa"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClassDetailPage(classId: classInfo.id)));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ClassInfoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Koneksi Terputus"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }
          return Container(); // Default kosong
        },
      ),
    );
  }

  @override
  void dispose() {
    classInfoBloc.close();
    super.dispose();
  }
}
