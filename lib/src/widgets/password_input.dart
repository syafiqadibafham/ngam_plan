import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ngam_plan/src/widgets/text_input.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextInput(
          controller: widget.controller,
          labelText: 'Password',
          obscureText: showPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: TextButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: !showPassword ? const Icon(LucideIcons.eyeOff) : const Icon(LucideIcons.eye),
          ),
        ),
      ],
    );
  }
}
