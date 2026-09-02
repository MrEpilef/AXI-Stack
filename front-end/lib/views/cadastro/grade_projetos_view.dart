import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:axi_stack/controllers/projeto_controller.dart';
import 'package:axi_stack/views/projetos/novo_projeto_view.dart';
import 'package:axi_stack/views/projetos/projeto/projeto_view.dart';
import 'package:provider/provider.dart';
import 'package:axi_stack/models/projeto_model.dart';
import 'package:axi_stack/services/projeto_service.dart';

class GradeProjetosView extends StatefulWidget {
  const GradeProjetosView({super.key});

  @override
  State<GradeProjetosView> createState() => _GradeProjetosViewState();
}

class _GradeProjetosViewState extends State<GradeProjetosView> {
  
  // ==========================================
  // CHAVE DE TROCA DE AMBIENTE
  // ==========================================
  // Para usar sem o Java rodando: ProjetoServiceMock()
  // Para usar o Java + Banco de Dados: ProjetoServiceHttp()
  final IProjetoService _projetoService = ProjetoServiceMock(); 

  late Future<List<Projeto>> _futureProjetos;

  @override
  void initState() {
    super.initState();
    // Inicia a busca logo que a tela abre
    _futureProjetos = _projetoService.buscarListaProjetos();
  }

  @override
  Widget build(BuildContext context) {
    
    // A sua lógica de roteamento pelo Provider continua intacta!
    final telaAtual = context.watch<ProjetoController>().telaAtual;
    switch (telaAtual) {
      case TelaProjeto.novoProjeto:
        return NovoProjetoView(
          onVoltar: () {
            context.read<ProjetoController>().mudarTela(TelaProjeto.lista);
          },
        );
      case TelaProjeto.visualizarProjeto:
        return ProjetoView(
          onVoltar: () {
            context.read<ProjetoController>().mudarTela(TelaProjeto.lista);
          },
        );
      case TelaProjeto.lista:
      default:
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000D15),
      body: Container(
        /* decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fundo.png"),
            fit: BoxFit.cover,
          ),
        ), */
        child: Stack(
          children: [
            Positioned.fill(
              // FUTURE BUILDER
              child: FutureBuilder<List<Projeto>>(
                future: _futureProjetos,
                builder: (context, snapshot) {
                  
                  // AGUARDANDO CARREGAMENTO
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFFF14004)),
                    );
                  }

                  // ERRO DE REDE
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar dados: ${snapshot.error}',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }

                  final projetos = snapshot.data ?? [];

                  
                  if (projetos.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhum projeto encontrado.',
                        style: TextStyle(color: Colors.white54, fontSize: 18),
                      ),
                    );
                  }

                  // REDESENHA A GRADE
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(32.0),
                    child: Wrap(
                      spacing: 24.0,
                      runSpacing: 24.0,
                      children: projetos.map((projetoAtual) {
                        return _construirCardProjeto(context, projetoAtual);
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
        
            // BOTÃO FLUTUANTE DE NOVO PROJETO
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
                    print('Novo Projeto clicado!');
                    context.read<ProjetoController>().mudarTela(TelaProjeto.novoProjeto);
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
  //        WIDGET DO CARD 
  // ==================================================
  Widget _construirCardProjeto(BuildContext context, Projeto projeto) {
    Color corDestaque;
    IconData iconeStatus;
    int progressoSimulado = 0;

    if (projeto.statusProjeto == 'Concluído') {
      corDestaque = const Color(0xFF2ECC71);
      iconeStatus = Icons.check_circle;
      progressoSimulado = 100;
    } else if (projeto.statusProjeto == 'Pendente') {
      corDestaque = const Color(0xFFF39C12);
      iconeStatus = Icons.folder_special;
      progressoSimulado = 10;
    } else {
      corDestaque = const Color(0xFF3498DB);
      iconeStatus = Icons.folder;
      progressoSimulado = 65;
    }

    return GestureDetector(
      onTap: () {
        context.read<ProjetoController>().setProjetoAtivo(projeto);
        context.read<ProjetoController>().mudarTela(TelaProjeto.visualizarProjeto);
        print('Navegando para a visualização do projeto ${projeto.cliente.razaoSocial}');
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        projeto.cliente.razaoSocial,
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
                Text(
                  'Projeto: ${projeto.nomeProjeto}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      projeto.statusProjeto ?? 'Pendente',
                      style: TextStyle(
                        color: corDestaque,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$progressoSimulado%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressoSimulado / 100,
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