import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTextoPadrao extends StatelessWidget {
  final String label;
  final String hint;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  final String? Function(String?)? validator;

  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final int? maxLines;

  const CampoTextoPadrao({
    super.key,
    required this.label,
    required this.hint,
    this.inputFormatters,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.validator,
    this.focusNode,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      inputFormatters: inputFormatters,
      validator: validator,
      focusNode: focusNode,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,

      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF001B29),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFFF4103), width: 2),
        ),
      ),
    );
  }
}
