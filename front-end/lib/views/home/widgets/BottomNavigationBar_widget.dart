import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget{
  final int indiceSelecionado;
  final Color corMenu;
  final Color corDestaque;
  final Color corInativa;

  final Function(int) alterarAba;
  
  final List<dynamic> itensNavegacao;

  const BottomNavigationBarWidget({
    super.key,
    required this.corMenu,
    required this.corDestaque,
    required this.corInativa,
    required this.indiceSelecionado,
    required this.alterarAba,
    required this.itensNavegacao
    });

  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: corMenu,
        child: SafeArea(
          child:SizedBox(
            height: 70,
            
            child: BottomNavigationBar(
              backgroundColor: corMenu,
              currentIndex: indiceSelecionado,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: corDestaque,
              unselectedItemColor: corInativa,
              selectedFontSize: 11.0,
              unselectedFontSize: 10.0,
              onTap: alterarAba,
              items: itensNavegacao
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(item.icon),
                        label: item.label,
                      ))
                  .toList(),
            ),
          ),
      )
    );
  }
}

