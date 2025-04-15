import 'package:fath_school/data/datasources/permisson_remote_datasource.dart';
import 'package:fath_school/presentation/home/bloc/get_permission_list/get_permission_list_bloc.dart';
import 'package:fath_school/presentation/home/pages/permission_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PermissionListPage extends StatefulWidget {
  const PermissionListPage({super.key});

  @override
  State<PermissionListPage> createState() => _PermissionListPageState();
}

class _PermissionListPageState extends State<PermissionListPage> {
  late GetPermissionListBloc _permissionListBloc;

  @override
  void initState() {
    super.initState();
    _permissionListBloc = GetPermissionListBloc(PermissonRemoteDatasource());
    _permissionListBloc.add(const FetchGetPermissionList());
  }

  @override
  void dispose() {
    _permissionListBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _permissionListBloc.add(const FetchGetPermissionList());
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
            title: const Text("List Izin"),
          ),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<GetPermissionListBloc, GetPermissionListState>(
            bloc: _permissionListBloc,
            builder: (context, state) {
              if (state is GetPermissionListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetPermissionListLoaded) {
                return ListView.builder(
                  itemCount: state.permissions.length,
                  itemBuilder: (context, index) {
                    final permission = state.permissions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PermissionDetailPage(id: permission.id)));
                          print('Permission ${permission.title} tapped');
                        },
                        child: Stack(
                          children: [
                            Container(
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        permission.title,
                                        style: const TextStyle(
                                          fontFamily: 'roboto',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                            .format(permission.createdAt),
                                        style: const TextStyle(
                                          fontFamily: 'roboto',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff6A7D94),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: permission.status == 'accepted'
                                      ? Colors.green
                                      : permission.status == 'rejected'
                                          ? Colors.red
                                          : Colors.orange,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  permission.status,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is GetPermissionListError) {
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
              } else if (state is GetPermissionListEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Tidak ada izin yang tersedia"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _refresh,
                        child: const Text('Refresh'),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('No permissions found.'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
