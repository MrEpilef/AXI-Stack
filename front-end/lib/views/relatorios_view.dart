import 'package:flutter/material.dart';

class RelatoriosView extends StatelessWidget {
  const RelatoriosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors:[
            Color.fromARGB(255, 241, 64, 4),
            Color.fromARGB(255, 201, 53, 15),
          ]
        ),
      ),
    child: Text(
      "Esta é a aba Relatórios",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}