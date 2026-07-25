import 'package:flutter/material.dart';

class ProjetoFinanceiroView extends StatelessWidget {
  const ProjetoFinanceiroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Financeiro', 
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold
        ),
      )
    );
  }
  
}