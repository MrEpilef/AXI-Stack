import 'package:flutter/material.dart';

class ConfiguracaoView extends StatelessWidget {
  const ConfiguracaoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF000D15),
      ),
    child: Text(
      "Esta é a aba Configurações",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}