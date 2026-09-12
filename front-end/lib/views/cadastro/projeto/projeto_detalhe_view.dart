import 'package:flutter/material.dart';

class DetalheProjetoView extends StatelessWidget {

  const DetalheProjetoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001621),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Text("Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              ),
          )
        ),
      ),
    );
  }
}
