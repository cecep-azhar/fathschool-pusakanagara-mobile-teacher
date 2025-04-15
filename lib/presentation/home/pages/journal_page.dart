import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:fath_school/core/components/custom_date_picker.dart';
import 'package:fath_school/core/components/custom_time_picker.dart';
import 'package:fath_school/presentation/home/bloc/add_journal/add_journal_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_lesson/get_lesson_bloc.dart';
import 'package:fath_school/presentation/home/pages/main_page.dart';
import 'package:fath_school/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  String? imagePath;
  late final TextEditingController dateController;
  late final TextEditingController timeController;
  late final TextEditingController descriptionController;
  String? _selectedClassId;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    timeController = TextEditingController();
    descriptionController = TextEditingController();
    context.read<GetLessonBloc>().add(const GetLessonEvent.getLesson());
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        _saveImagePath(imagePath!);
      } else {
        debugPrint('No file selected.');
      }
    });
  }

  Future<void> _saveImagePath(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('image_path', imagePath);
  }

  Future<void> _clearImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('image_path');
  }

  String formatDate(DateTime date) {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(date);
  }

  String formatTime(TimeOfDay time) {
    final formattedTime =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')}:00';
    return formattedTime;
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
            title: const Text("Jurnal"),
          ),
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: const EdgeInsets.all(18.0),
            children: [
              CustomDatePicker(
                label: 'Tanggal',
                onDateSelected: (selectedDate) =>
                    dateController.text = formatDate(selectedDate).toString(),
              ),
              const SizedBox(height: 16.0),
              CustomTimePicker(
                label: 'Jam',
                onTimeSelected: (selectedTime) {
                  timeController.text = formatTime(selectedTime);
                },
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Kelas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Kelas',
                  border: OutlineInputBorder(),
                ),
                value: _selectedClassId,
                onChanged: (value) {
                  setState(() {
                    _selectedClassId = value;
                  });
                },
                items: context.watch<GetLessonBloc>().state.maybeWhen(
                      orElse: () => [],
                      success: (lessons) => lessons.map((lesson) {
                        return DropdownMenuItem<String>(
                          value: lesson.classId.toString(),
                          child: Text(
                              '${lesson.className} | ${lesson.timeIn} - ${lesson.timeOut}'),
                        );
                      }).toList(),
                    ),
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: descriptionController,
                label: 'Deskripsi',
                maxLines: 5,
              ),
              const SizedBox(height: 26.0),
              GestureDetector(
                onTap: _pickImage,
                child: imagePath == null
                    ? DottedBorder(
                        borderType: BorderType.RRect,
                        color: Colors.grey,
                        radius: const Radius.circular(18.0),
                        dashPattern: const [8, 5],
                        child: const Center(
                          child: SizedBox(
                            height: 200.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 40),
                                SizedBox(height: 18.0),
                                Text('Lampiran'),
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
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 65.0),
              BlocConsumer<AddJournalBloc, AddJournalState>(
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
                      dateController.clear();
                      descriptionController.clear();
                      timeController.clear();
                      setState(() {
                        _selectedClassId = null;
                        imagePath = null;
                      });
                      _clearImagePath();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Jurnal berhasil ditambahkan'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          if (_selectedClassId != null && imagePath != null) {
                            context.read<AddJournalBloc>().add(
                                  AddJournalEvent.addJournal(
                                    date: dateController.text,
                                    time: timeController.text,
                                    description: descriptionController.text,
                                    classLists: _selectedClassId!,
                                    image: imagePath!,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Harap lengkapi semua bidang'),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          }
                        },
                        label: 'Kirim Jurnal',
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
