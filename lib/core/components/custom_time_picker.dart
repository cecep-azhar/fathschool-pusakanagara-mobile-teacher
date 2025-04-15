import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final void Function(TimeOfDay selectedTime)? onTimeSelected;
  final TimeOfDay? initialTime;
  final Widget? prefix;
  final String label;
  final bool showLabel;

  const CustomTimePicker({
    super.key,
    required this.label,
    this.showLabel = true,
    this.initialTime,
    this.onTimeSelected,
    this.prefix,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TextEditingController controller;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.initialTime?.format(context),
    );
    selectedTime = widget.initialTime ?? TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        controller.text = selectedTime.format(context);
      });
      if (widget.onTimeSelected != null) {
        widget.onTimeSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12.0),
        ],
        TextFormField(
          controller: controller,
          onTap: () => _selectTime(context),
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.access_time),
            ),
            hintText: widget.initialTime != null
                ? selectedTime.format(context)
                : widget.label,
          ),
        ),
      ],
    );
  }
}
