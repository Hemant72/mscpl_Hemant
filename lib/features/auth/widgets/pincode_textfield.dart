import 'package:flutter/material.dart';

class PinCodeTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final TextInputType keyboardType;
  final void Function(String) onSubmitted;

  const PinCodeTextField({
    super.key,
    required this.controller,
    required this.maxLength,
    required this.keyboardType,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      obscureText: true,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24),
      onChanged: (value) {
        if (value.length == maxLength) {
          onSubmitted(value);
        }
      },
    );
  }
}
