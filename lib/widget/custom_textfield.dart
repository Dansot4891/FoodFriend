import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscure;
  final List<TextInputFormatter>? inputFormatter;
  final bool enabled;
  
  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscure = false,
    this.enabled = true,
    this.inputFormatter,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      obscureText: obscure,
      controller: controller,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      validator: validator,
    );
  }
}