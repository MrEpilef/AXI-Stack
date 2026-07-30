import 'package:flutter/material.dart';
import 'package:axi_stack/views/projetos/projeto/projeto_detalhe_view.dart';
import 'package:axi_stack/views/projetos/projeto/projeto_diario_view.dart';
import 'package:axi_stack/views/projetos/projeto/projeto_financeiro_view.dart';
import 'package:axi_stack/views/projetos/projeto/projeto_pendencias_view.dart';

class ProjetoView extends StatelessWidget {
  final VoidCallback onVoltar;

  const ProjetoView({super.key, required this.onVoltar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF000D15),
      

      child: Padding(
        padding: const EdgeInsets.all(32.0),


        child: DefaultTabController(
          length: 4,


          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF001621),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1), 
                width: 1.0,
              ),
            ),


            padding: const EdgeInsets.all(12.0),


            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 16), 
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        onPressed: onVoltar,
                        tooltip: 'Voltar para a lista',
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
            
                      const SizedBox(width: 16), 
            
                      Expanded(
                        child: TabBar(
                          indicatorColor: Color(0xFFFF4103),
                          indicatorWeight: 3.0,
                          labelColor: Color(0xFFFF4103),
                          unselectedLabelColor: Colors.white60,
                            tabs: [
                              Tab(icon: Icon(Icons.dashboard), text: 'Detalhes'),
                              Tab(icon: Icon(Icons.attach_money), text: 'Financeiro'),
                              Tab(icon: Icon(Icons.calendar_month_outlined), text: 'Diário'),
                              Tab(icon: Icon(Icons.pending_actions), text: 'Pendências'),
                            ],
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
            
                  Expanded(
                    child: TabBarView(
                      children: [
                        DetalheProjetoView(),
                        ProjetoFinanceiroView(),
                        ProjetoDiarioView(),
                        ProjetoPendenciasView(),
                        
                      ],
                    ),
                  ),
                ],
              ),
          ),
          
        ),
      ),
    );
  }
}
