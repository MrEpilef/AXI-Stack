import 'package:flutter/material.dart';
import 'package:axi_stack/views/cadastro/formulario_analistas_view.dart';
import 'package:axi_stack/views/cadastro/formulario_clientes_view.dart';
//import 'package:gestorsofttec/views/cadastro/formulario_servicos_view.dart';

class CadastroView extends StatelessWidget {
  const CadastroView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        //==========================================
        // CONTAINER DE BAIXO
        // ==========================================
        color: const Color(0xFF001621),
        //color: const Color(0xFFFF4103),
        child: Column(
          children: [
            // ==========================================
            // BARRA DE ABAS (TOPO)
            // ==========================================
            Container(
              //color: const Color.fromARGB(255, 0, 27, 41), - Azul mais claro, da cor da Custom title
              color: const Color(0xFF001621),
              child: const TabBar(
                indicatorColor: Color(0xFFFF4103),
                indicatorWeight: 3.0,
                labelColor: Color(0xFFFF4103),
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(icon: Icon(Icons.store), text: 'Clientes'),
                  Tab(icon: Icon(Icons.badge), text: 'Analistas'),
                  //Tab(icon: Icon(Icons.build_circle), text: 'Tipo de serviços'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FormularioClientes(),
                  FormularioAnalistas(),
                  //FormularioServicos(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



