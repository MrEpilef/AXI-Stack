import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTextoPadrao extends StatelessWidget {
  final String label;
  final String hint;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  

  const CampoTextoPadrao({
    super.key,
    required this.label,
    required this.hint,
    this.inputFormatters,
    this.controller,
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30),
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
