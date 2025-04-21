import 'package:fath_school/core/constants/variables.dart';
import 'package:fath_school/data/models/response/permission_response_model.dart';
import 'package:fath_school/presentation/home/bloc/get_details_permission/get_details_permission_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PermissionDetailPage extends StatefulWidget {
  final int id;

  const PermissionDetailPage({super.key, required this.id});

  @override
  State<PermissionDetailPage> createState() => _PermissionDetailPageState();
}

class _PermissionDetailPageState extends State<PermissionDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetDetailsPermissionBloc>()
        .add(FetchListPermission(widget.id));
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
            title: const Text("Detail Izin"),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<GetDetailsPermissionBloc,
                      GetDetailsPermissionState>(
                    builder: (context, state) {
                      if (state is GetDetailsPermissionLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GetDetailsPermissionLoaded) {
                        return _buildDetailJournal(state.permission);
                      } else if (state is GetDetailsPermissionError) {
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
        ),
      ],
    );
  }

  Widget _buildDetailJournal(PermissionResponseModel permission) {
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      permission.title,
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat("EEEE, d MMMM yyyy", "id_ID")
                          .format(permission.createdAt),
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff6A7D94),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dari: ${DateFormat('dd-MM-yyyy').format(permission.start)}, Sampai: ${DateFormat('dd-MM-yyyy').format(permission.end)}",
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff6A7D94),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      permission.description,
                      style: const TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Image.network(
                  "${Variables.baseUrl}/storage/leaves/${permission.image}",
                  width: 480.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Jika terjadi error saat memuat gambar, tampilkan gambar default
                    return Image.asset(
                      'assets/images/logo.png',
                      width: 450.0,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                const SizedBox(height: 130),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: permission.status == 'accepted'
                            ? Colors.green
                            : permission.status == 'pending'
                                ? Colors.orange
                                : Colors.red,
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
                ),
                if (permission.rejectedCause.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ditolak karena: ${permission.rejectedCause}",
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
