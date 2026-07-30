import 'package:flutter/material.dart';

class ProjetoPendenciasView extends StatelessWidget{
  const ProjetoPendenciasView({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pendências', 
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold
        ),
      )
    );
  }
  
}