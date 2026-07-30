import 'package:flutter/material.dart';
import '../widgets/custom_title_bar.dart';
import 'dashboard_view.dart';
import 'cadastro/cadastro_view.dart';
import 'projetos/grade_projetos_view.dart';
import 'relatorios_view.dart';
import 'configuracao_view.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _indiceSelecionado = 0;
  bool _menuAberto = true;

  final List<Widget> _telas = [
    DashboardView(),
    CadastroView(),
    GradeProjetosView(),
    RelatoriosView(),
    ConfiguracaoView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001621),
      body: Column(
        children: [
          const CustomTitleBar(),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  //backgroundColor: const Color(0xFF001621),
                  backgroundColor: const Color(0xFF001B29),
                  selectedIndex: _indiceSelecionado,
                  extended: _menuAberto,
                  minExtendedWidth: 200,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _indiceSelecionado = index;
                    });
                  },
                  selectedIconTheme: const IconThemeData(color: Color(0xFFFF4103),),
                  unselectedIconTheme: const IconThemeData(color: Colors.white60,),
                  selectedLabelTextStyle: const TextStyle(color: Color(0xFFFF4103),fontWeight: FontWeight.bold,),
                  unselectedLabelTextStyle: const TextStyle(color: Colors.white60,),

                  leading: GestureDetector(
                    
                    onTap: () {
                      // Ao clicar no logo, inverte o estado do menu!
                      setState(() {
                        _menuAberto = !_menuAberto;
                      });
                    },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                      // Se estiver aberto, mostra Ícone + Texto. Se fechado, só o Ícone.
                      child: _menuAberto
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'SOFTTEC',
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                    : Image.asset(
                              'assets/logo.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),




                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_add),
                      label: Text('Cadastro'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.folder),
                      label: Text('Projetos'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.insert_chart),
                      label: Text('Relatórios'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text('Configuração'),
                    ),
                  ],
                ),

                Expanded(child: _telas[_indiceSelecionado]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
