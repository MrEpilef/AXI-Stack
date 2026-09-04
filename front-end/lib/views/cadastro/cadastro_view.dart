import 'package:flutter/material.dart';
import 'package:axi_stack/views/cadastro/formulario_analistas_view.dart';
import 'package:axi_stack/views/cadastro/formulario_clientes_view.dart';
import 'package:axi_stack/views/cadastro/grade_projetos_view.dart';


class CadastroView extends StatelessWidget {
  const CadastroView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: Container(
            //==========================================
            // CONTAINER DE BAIXO
            // ==========================================
            color: const Color(0xFF001621),
            child: LayoutBuilder(
              builder: (context, constraints){

                final isDesktop = constraints.maxWidth >= 600;

                
                final content = Expanded(
                  child: TabBarView(
                    children: [
                      FormularioClientes(),
                      FormularioAnalistas(),
                      GradeProjetosView(),
                    ],
                  ),
                );

                const divider = Divider(
                  height: 1,           
                  thickness: 1,        
                  color: Colors.white12,
                  );

                final tab_bar = Container(
                  color: const Color(0xFF001621),
                  child: const TabBar(
                    indicatorColor: Color(0xFFFF4103),
                    indicatorWeight: 3.0,
                    labelColor: Color(0xFFFF4103),
                    unselectedLabelColor: Colors.white60,
                    tabs: [
                      Tab(icon: Icon(Icons.store), text: 'Clientes'),
                      Tab(icon: Icon(Icons.badge), text: 'Analistas'),
                      Tab(icon: Icon(Icons.folder),text: 'Projetos'),
                    ],
                  ),
                );
                return Column(
                  children: isDesktop
                  ? [tab_bar, content]
                  : [content, divider, tab_bar]
                  ,
                );


              }
            ),
          ),
      ),
    );
  }
  
}



