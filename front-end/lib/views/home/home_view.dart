import 'package:axi_stack/views/home/widgets/BottomNavigationBar_widget.dart';
import 'package:axi_stack/views/home/widgets/NavigationRail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../widgets/custom_title_bar.dart';
import '../dashboard_view.dart';
import '../cadastro/cadastro_view.dart';
import 'package:axi_stack/views/cadastro/grade_projetos_view.dart';
import '../relatorios_view.dart';
import '../configuracao/configuracao_view.dart';
import 'dart:io';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// Classe auxiliar para centralizar os itens de navegação
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

class _HomeViewState extends State<HomeView> {
  int _indiceSelecionado = 0;
  bool _menuAberto = true;

  // 1. Centralização das cores
  static const Color _corFundo = Color(0xFF001621);
  static const Color _corMenu = Color(0xFF001B29);
  static const Color _corDestaque = Color(0xFFFF4103);
  static const Color _corInativa = Colors.white60;

  // 2. Telas
  final List<Widget> _telas = const [
    DashboardView(),
    CadastroView(),
    GradeProjetosView(),
    RelatoriosView(),
    ConfiguracaoView(),
  ];

  // 3. Itens de navegação únicos (usados tanto no PC quanto no Mobile)
  final List<_NavItem> _itensNavegacao = const [
    _NavItem(Icons.dashboard, 'Dashboard'),
    _NavItem(Icons.person_add, 'Cadastro'),
    _NavItem(Icons.folder, 'Projetos'),
    _NavItem(Icons.insert_chart, 'Relatórios'),
    _NavItem(Icons.settings, 'Configuração'),
  ];

  // Verificação segura para evitar crash na Web ao usar dart:io
  bool get _mostrarTitleBar =>
      !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  void _alterarAba(int index) => setState(() => _indiceSelecionado = index);
  
  void _alternarMenu() => setState(() => _menuAberto = !_menuAberto);
  

  @override
  Widget build(BuildContext context) {

    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      backgroundColor: _corFundo,
      body: Column(
        children: [
          if (_mostrarTitleBar) const CustomTitleBar(),
          Expanded(
            child: isMobile
                ? _telas[_indiceSelecionado]
                : Row(
                    children: [
                      NavigationRailWidget(
                        indiceSelecionado: _indiceSelecionado,
                        menuAberto: _menuAberto,
                        corMenu: _corMenu,
                        corDestaque: _corDestaque,
                        corInativa: _corInativa,
                        alterarAba: _alterarAba,
                        alternarMenu: _alternarMenu,
                        itensNavegacao: _itensNavegacao,
                      ),
                      Expanded(child: _telas[_indiceSelecionado]),
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile 
        ? BottomNavigationBarWidget(
            corMenu: _corMenu,
            corDestaque: _corDestaque,
            corInativa: _corInativa,
            indiceSelecionado: _indiceSelecionado,
            alterarAba: _alterarAba,
            itensNavegacao: _itensNavegacao,
          )
        : null,
    );
  }
}