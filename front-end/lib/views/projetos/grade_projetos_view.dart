import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:axi_stack/controllers/projeto_controller.dart';
import 'package:axi_stack/views/projetos/novo_projeto_view.dart';
import 'package:axi_stack/views/projetos/projeto/projeto_view.dart';
import 'package:provider/provider.dart';
import 'package:axi_stack/models/projeto_model.dart';

class GradeProjetosView extends StatelessWidget {
  const GradeProjetosView({super.key});
  final String jsonDeExemplo = '''
  [
    {
      "codigoCliente": "1",
      "titulo": "Implantação de PDV",
      "cliente": "Mega São Luís",
      "status": "Em Andamento",
      "progresso": 65
    },
    {
      "codigoCliente": "2",
      "titulo": "Auditoria e Migração Firebird",
      "cliente": "Supermercado Central",
      "status": "Pendente",
      "progresso": 10
    },
    {
      "codigoCliente": "3",
      "titulo": "Automação Fiscal de Notas",
      "cliente": "Rede Varejo Sul",
      "status": "Concluído",
      "progresso": 100
    },
    {
      "codigoCliente": "4",
      "titulo": "Implantação e treinamento rede varejo sul",
      "cliente": "Rede Varejo Sul",
      "status": "Pendente",
      "progresso": 80
    },
    {
      "codigoCliente": "5",
      "titulo": "Treinamento Quallity",
      "cliente": "Supermercado Quallity",
      "status": "Pendente",
      "progresso": 98
    }
  ]
  ''';

  // Função que transforma o Texto JSON na Lista de Objetos
  List<Projeto> _carregarProjetos() {
    List<dynamic> lista = jsonDecode(jsonDeExemplo);
    return lista.map((item) => Projeto.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final projetos = _carregarProjetos();

    final telaAtual = context.watch<ProjetoController>().telaAtual;
    switch (telaAtual) {
      case TelaProjeto.novoProjeto:
        return NovoProjetoView(
          onVoltar: () {
            context.read<ProjetoController>().mudarTela(TelaProjeto.lista);
          },
        );
      /* case TelaProjeto.detalheProjeto:
        return DetalheProjetoView(
          onVoltar: () {
            context.read<ProjetoController>().mudarTela(TelaProjeto.lista);
          },
        ); */
      case TelaProjeto.visualizarProjeto:
        return ProjetoView(
          onVoltar: () {
            context.read<ProjetoController>().mudarTela(
              TelaProjeto.lista,
            );
          },
        );
      case TelaProjeto.lista:
      default:
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000D15),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fundo.png"),
            fit: BoxFit.cover,
            ),
            
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
        
                child: Wrap(
                  spacing: 24.0,
                  runSpacing: 24.0,
                  children: projetos.map((projetoAtual) {
                    return _construirCardProjeto(context, projetoAtual);
                  }).toList(),
                ),
              ),
            ),
        
            Positioned(
              bottom: 32.0,
              left: 32.0,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF14004), Color(0xFFC9350F)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //lógica para controler futuro
                    print('Novo Projeto clicado!');
                    context.read<ProjetoController>().mudarTela(
                      TelaProjeto.novoProjeto,
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Novo Projeto',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  //                  WIDGET DO CARD
  // ==================================================
  Widget _construirCardProjeto(BuildContext context, Projeto projeto) {
    Color corDestaque;
    IconData iconeStatus;

    if (projeto.status == 'Concluído') {
      corDestaque = const Color(0xFF2ECC71);
      iconeStatus = Icons.check_circle;
    } else if (projeto.status == 'Pendente') {
      corDestaque = const Color(0xFFF39C12);
      iconeStatus = Icons.folder_special;
    } else {
      corDestaque = const Color(0xFF3498DB);
      iconeStatus = Icons.folder;
    }

    return GestureDetector(
      onTap: () {
        context.read<ProjetoController>().setProjetoAtivo(projeto);
        context.read<ProjetoController>().mudarTela(TelaProjeto.visualizarProjeto);
        print('Navegando para a visualização do projeto ${projeto.cliente}');
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 280,
            height: 200,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF001B29).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),


            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TÍTULO E ÍCONE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        projeto.cliente,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(iconeStatus, color: corDestaque, size: 24),
                  ],
                ),
                const SizedBox(height: 8),

                // CLIENTE
                Text(
                  'Projeto: ${projeto.titulo}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 32),
                Spacer(),
                // TEXTOS DA BARRA DE PROGRESSO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      projeto.status,
                      style: TextStyle(
                        color: corDestaque,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${projeto.progresso}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // BARRA DE PROGRESSO
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: projeto.progresso / 100,
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    valueColor: AlwaysStoppedAnimation<Color>(corDestaque),
                    minHeight: 6,
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
