import 'package:flutter/material.dart';

class DropdownPadrao extends StatelessWidget {
  final String label;
  final List<String> itens;
  final String? valorSelecionado;

  final void Function(String?)? onChanged;

  const DropdownPadrao({
    super.key,
    required this.label,
    required this.itens,
    this.onChanged,
    this.valorSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: valorSelecionado,
      dropdownColor: const Color(0xFF001B29),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
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
      items: itens.map((String valor) {
        return DropdownMenuItem(
          value: valor,
          child: Text(valor));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
