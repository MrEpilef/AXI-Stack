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
      "codigoProjeto": 1,
      "nomeProjeto": "Implantação de PDV",
      "descricaoEscopo": "Implantação completa do PDV nas frentes de caixa",
      "prioridade": "Alta",
      "dataInicioPrevista": "2026-08-01",
      "dataTerminoPrevista": "2026-08-30",
      "statusProjeto": "Em Andamento",
      "isAtivo": true,
      "cliente": {
        "codigoCliente": 1,
        "razaoSocial": "Mega São Luís",
        "cnpj": "12.345.678/0001-99",
        "endereco": "Av. Independência, 1500",
        "cidade": "Goiânia",
        "uf": "GO",
        "contato": "Roberto Carlos",
        "telefone": "(62) 98888-1111",
        "email": "ti@megasaoluis.com.br"
      }
    },
    {
      "codigoProjeto": 2,
      "nomeProjeto": "Auditoria e Migração Firebird",
      "descricaoEscopo": "Migração completa de dados para Oracle",
      "prioridade": "Alta",
      "dataInicioPrevista": "2026-08-05",
      "dataTerminoPrevista": "2026-09-10",
      "statusProjeto": "Pendente",
      "isAtivo": true,
      "cliente": {
        "codigoCliente": 2,
        "razaoSocial": "Supermercado Central",
        "cnpj": "98.765.432/0001-10",
        "endereco": "Rua 44, Setor Norte",
        "cidade": "Goiânia",
        "uf": "GO",
        "contato": "Maria Souza",
        "telefone": "(62) 99999-2222",
        "email": "gerencia@central.com.br"
      }
    },
    {
      "codigoProjeto": 3,
      "nomeProjeto": "Automação Fiscal de Notas",
      "descricaoEscopo": "Automação de auditoria de cupons via Python",
      "prioridade": "Média",
      "dataInicioPrevista": "2026-07-01",
      "dataTerminoPrevista": "2026-07-20",
      "statusProjeto": "Concluído",
      "isAtivo": true,
      "cliente": {
        "codigoCliente": 3,
        "razaoSocial": "Rede Varejo Sul",
        "cnpj": "11.222.333/0001-44",
        "endereco": "Av. Rio Verde, 500",
        "cidade": "Aparecida de Goiânia",
        "uf": "GO",
        "contato": "Carlos Eduardo",
        "telefone": "(62) 97777-3333",
        "email": "fiscal@varejosul.com.br"
      }
    },
    {
      "codigoProjeto": 4,
      "nomeProjeto": "Treinamento Quallity",
      "descricaoEscopo": "Treinamento da equipe no novo módulo de estoque",
      "prioridade": "Baixa",
      "dataInicioPrevista": "2026-09-01",
      "dataTerminoPrevista": "2026-09-05",
      "statusProjeto": "Pendente",
      "isAtivo": true,
      "cliente": {
        "codigoCliente": 4,
        "razaoSocial": "Supermercado Quallity",
        "cnpj": "55.444.333/0001-88",
        "endereco": "Praça Central, S/N",
        "cidade": "Trindade",
        "uf": "GO",
        "contato": "Ana Clara",
        "telefone": "(62) 96666-4444",
        "email": "rh@quallity.com.br"
      }
    },
    {
      "codigoProjeto": 5,
      "nomeProjeto": "Configuração Servidor Dell",
      "descricaoEscopo": "Setup de RAID e instalação de Windows Server",
      "prioridade": "Alta",
      "dataInicioPrevista": "2026-08-15",
      "dataTerminoPrevista": "2026-08-18",
      "statusProjeto": "Em Andamento",
      "isAtivo": true,
      "cliente": {
        "codigoCliente": 5,
        "razaoSocial": "Atacadão do Povo",
        "cnpj": "77.888.999/0001-22",
        "endereco": "Rodovia BR-153, Km 10",
        "cidade": "Senador Canedo",
        "uf": "GO",
        "contato": "Felipe Marques",
        "telefone": "(62) 95555-5555",
        "email": "infra@atacadaopovo.com.br"
      }
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
                // TÍTULO E ÍCONE
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

                // CLIENTE
                Text(
                  'Projeto: ${projeto.nomeProjeto}',
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

                // BARRA DE PROGRESSO
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
