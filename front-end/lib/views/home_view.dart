import 'package:flutter/material.dart';
import '../widgets/custom_title_bar.dart';
import 'dashboard_view.dart';
import 'cadastro/cadastro_view.dart';
import 'projetos/grade_projetos_view.dart';
import 'relatorios_view.dart';
import 'configuracao/configuracao_view.dart';
import 'dart:io';

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
    // 1. O Flutter verifica a largura da tela em tempo real
    final double larguraTela = MediaQuery.of(context).size.width;
    final bool isMobile = larguraTela < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF001621),
      
      // 2. O conteúdo da tela muda dependendo do aparelho
      body: Column(
        children: [
          if (Platform.isWindows || Platform.isMacOS || Platform.isLinux)
            const CustomTitleBar(),
          Expanded(
            child: isMobile 
              // VERSÃO CELULAR: Apenas mostra a tela, sem menu lateral roubando espaço
              ? _telas[_indiceSelecionado]
              
              // VERSÃO PC: Mantém exatamente o seu código original com o Row e o NavigationRail
              : Row(
                  children: [
                    NavigationRail(
                      backgroundColor: const Color(0xFF001B29),
                      selectedIndex: _indiceSelecionado,
                      extended: _menuAberto,
                      minExtendedWidth: 200,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _indiceSelecionado = index;
                        });
                      },
                      selectedIconTheme: const IconThemeData(color: Color(0xFFFF4103)),
                      unselectedIconTheme: const IconThemeData(color: Colors.white60),
                      selectedLabelTextStyle: const TextStyle(color: Color(0xFFFF4103), fontWeight: FontWeight.bold),
                      unselectedLabelTextStyle: const TextStyle(color: Colors.white60),
                      leading: GestureDetector(
                        onTap: () {
                          setState(() {
                            _menuAberto = !_menuAberto;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                          child: _menuAberto
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/logo.png', width: 32, height: 32, fit: BoxFit.contain),
                                    const SizedBox(width: 12),
                                    const Text('SOFTTEC', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                                  ],
                                )
                              : Image.asset('assets/logo.png', width: 32, height: 32, fit: BoxFit.contain),
                        ),
                      ),
                      destinations: const [
                        NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                        NavigationRailDestination(icon: Icon(Icons.person_add), label: Text('Cadastro')),
                        NavigationRailDestination(icon: Icon(Icons.folder), label: Text('Projetos')),
                        NavigationRailDestination(icon: Icon(Icons.insert_chart), label: Text('Relatórios')),
                        NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Configuração')),
                      ],
                    ),
                    Expanded(child: _telas[_indiceSelecionado]),
                  ],
                ),
          ),
        ],
      ),

      // 3. VERSÃO CELULAR: Adiciona o menu nativo no rodapé (se for PC, fica nulo/invisível)
      bottomNavigationBar: isMobile 
        ? BottomNavigationBar(
            backgroundColor: const Color(0xFF001B29),
            currentIndex: _indiceSelecionado,
            type: BottomNavigationBarType.fixed, // Mantém o fundo escuro
            selectedItemColor: const Color(0xFFFF4103),
            unselectedItemColor: Colors.white60,
            onTap: (int index) {
              setState(() {
                _indiceSelecionado = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Cadastro'),
              BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projetos'),
              BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: 'Relatórios'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuração'),
            ],
          )
        : null,
    );
  }
}
