import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final bool isDatePicker;
  final Function(DateTime)? onDateSelected;

  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.isDatePicker = false,
    this.onDateSelected,
  });

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Format the date and update the controller
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      // Call the callback if provided
      if (onDateSelected != null) {
        onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: () {
        if (isDatePicker) {
          _showDatePicker(context);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
      readOnly: isDatePicker, // Make the field read-only if it's a date picker
    );
  }
}