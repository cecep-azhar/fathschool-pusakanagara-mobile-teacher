import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fath_school/presentation/home/bloc/get_leaves_type/get_leaves_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fath_school/presentation/home/bloc/add_permission/add_permission_bloc.dart';
import 'package:fath_school/presentation/home/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/components/custom_date_picker.dart';
import '../../../core/core.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  String? imagePath;
  String? _selectedLeavesId;
  late final TextEditingController startController;
  late final TextEditingController endController;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    startController = TextEditingController();
    endController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    context.read<LeavesBloc>().add(const LeavesEvent.getLeavesId());
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
      } else {
        debugPrint('No file selected.');
      }
    });
  }

  String formatDate(DateTime date) {
    // Gunakan DateFormat untuk mengatur format tanggal
    final dateFormatter = DateFormat('yyyy-MM-dd');
    // Kembalikan tanggal dalam format yang dinginkan
    return dateFormatter.format(date);
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
            backgroundColor: Colors.transparent,
            title: const Text("Izin"),
          ),
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: const EdgeInsets.all(18.0),
            children: [
              CustomDatePicker(
                label: 'Dari Tanggal',
                onDateSelected: (selectedDate) =>
                    startController.text = formatDate(selectedDate).toString(),
              ),
              const SpaceHeight(16.0),
              CustomDatePicker(
                label: 'Sampai Tanggal',
                onDateSelected: (selectedDate) =>
                    endController.text = formatDate(selectedDate).toString(),
              ),
              const SpaceHeight(16.0),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Tipe',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipe',
                  border: OutlineInputBorder(),
                ),
                value: _selectedLeavesId,
                onChanged: (value) {
                  setState(() {
                    _selectedLeavesId = value;
                  });
                },
                items: context.watch<LeavesBloc>().state.maybeWhen(
                      orElse: () => [],
                      loaded: (leaves) => leaves.map((leave) {
                        return DropdownMenuItem<String>(
                          value: leave.id.toString(),
                          child: Text(leave.name),
                        );
                      }).toList(),
                    ),
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: titleController,
                label: 'Judul',
                maxLines: 1,
              ),
              const SpaceHeight(16.0),
              CustomTextField(
                controller: descriptionController,
                label: 'Keperluan',
                maxLines: 5,
              ),
              const SpaceHeight(26.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: imagePath == null
                      ? DottedBorder(
                          borderType: BorderType.RRect,
                          color: Colors.grey,
                          radius: const Radius.circular(18.0),
                          dashPattern: const [8, 4],
                          child: Center(
                            child: SizedBox(
                              height: 120.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.icons.image.svg(),
                                  const SpaceHeight(18.0),
                                  const Text('Lampiran'),
                                ],
                              ),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18.0),
                          ),
                          child: Image.file(
                            File(imagePath!),
                            // height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SpaceHeight(65.0),
              BlocConsumer<AddPermissionBloc, AddPermissionState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    },
                    success: () {
                      startController.clear();
                      endController.clear();
                      titleController.clear();
                      descriptionController.clear();
                      setState(() {
                        imagePath = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Submit Izin success'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      context.pushReplacement(const MainPage());
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          final image =
                              imagePath != null ? XFile(imagePath!) : null;
                          context.read<AddPermissionBloc>().add(
                                AddPermissionEvent.addPermission(
                                    leaveTypeId: _selectedLeavesId!,
                                    start: startController.text,
                                    end: endController.text,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    image: image!),
                              );
                        },
                        label: 'Kirm Permintaan',
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
