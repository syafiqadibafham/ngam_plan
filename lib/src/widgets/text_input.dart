import 'package:flutter/material.dart';
import 'package:ngam_plan/src/core/theme/custom_outline_input_border.dart';
import 'package:ngam_plan/src/core/theme/theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key, required this.controller, this.validator, required this.labelText});

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: CustomInputBorder(
            gradient: const RadialGradient(
              colors: [Colors.orangeAccent, Colors.black],
              focalRadius: 1.5,
              radius: 4.5,
              center: Alignment(-1, -0.8),
            ),
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          enabledBorder: CustomInputBorder(
            gradient: const RadialGradient(
              colors: [Colors.orange, Colors.black],
              focalRadius: 0.1,
              radius: 7.5,
              center: Alignment(1, 0.8),
            ),
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          )),
      validator: validator,
    );
  }
}
