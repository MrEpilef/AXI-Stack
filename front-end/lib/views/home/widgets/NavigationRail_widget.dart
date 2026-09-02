import 'package:flutter/material.dart';

class NavigationRailWidget extends StatelessWidget{
  final Color corMenu;
  final Color corDestaque;
  final Color corInativa;
  final bool menuAberto;
  final int indiceSelecionado;
  final Function(int) alterarAba;
  final List<dynamic> itensNavegacao;
  final VoidCallback alternarMenu;

  const NavigationRailWidget({
    super.key,
    required this.corMenu,
    required this.corDestaque,
    required this.corInativa,
    required this.menuAberto,
    required this.indiceSelecionado,
    required this.alterarAba,
    required this.itensNavegacao,  
    required this.alternarMenu,
    });
  
  
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        backgroundColor: corMenu,
        selectedIndex: indiceSelecionado,
        extended: menuAberto,
        minExtendedWidth: 200,
        onDestinationSelected: alterarAba,
        selectedIconTheme: IconThemeData(color: corDestaque),
        unselectedIconTheme: IconThemeData(color: corInativa),
        selectedLabelTextStyle: TextStyle(color: corDestaque, fontWeight: FontWeight.bold),
        unselectedLabelTextStyle:  TextStyle(color: corInativa),
        leading: buildRailHeader(),
        destinations: itensNavegacao
            .map((item) => NavigationRailDestination(
                  icon: Icon(item.icon),
                  label: Text(item.label),
                ))
            .toList(),
      );
  }



  Widget buildRailHeader (){
    return GestureDetector(
      onTap: alternarMenu,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 32, height: 32, fit: BoxFit.contain),
            if (menuAberto) ...[
              const SizedBox(width: 12),
              const Text(
                'SOFTTEC',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ]
          ],
        ),
      ),
    );
  }
}