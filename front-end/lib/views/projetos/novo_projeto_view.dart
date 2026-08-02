import 'package:axi_stack/models/projeto_model.dart';
import 'package:axi_stack/widgets/dropdown_padrao.dart';
import 'package:flutter/material.dart';
import 'package:axi_stack/widgets/botao_padrao.dart';
import 'package:axi_stack/widgets/campo_texto_padrao.dart';

class NovoProjetoView extends StatefulWidget {
  final VoidCallback onVoltar;
  const NovoProjetoView({super.key, required this.onVoltar});

  @override
  State<NovoProjetoView> createState() => _NovoProjetoViewState();
}

class _NovoProjetoViewState extends State<NovoProjetoView> {
  String? _prioridadeSelecionado;
  final _clienteProjetoController = TextEditingController();
  final _nomeProjetoController = TextEditingController();
  final _dataInicioController = TextEditingController();
  final _dataFimController = TextEditingController();
  final _escopoProjetoController = TextEditingController();

  @override
  void dispose() {
    _dataInicioController.dispose();
    _dataFimController.dispose();

    super.dispose();
  }

  Future<void>? _selecionarData(TextEditingController controladorAlvo) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2099),
    );

    if (dataSelecionada != null) {
      setState(() {
        String dia = dataSelecionada.day.toString().padLeft(2, '0');
        String mes = dataSelecionada.month.toString().padLeft(2, '0');
        String ano = dataSelecionada.year.toString();
        controladorAlvo.text = "$dia/$mes/$ano";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000D15),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: widget.onVoltar,
              tooltip: 'Voltar para a lista',
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),

            const SizedBox(width: 12),

            const Text(
              'Cadastro de projeto',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CampoTextoPadrao(label: 'Código', hint: 'Código'),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: 4,
                  child: CampoTextoPadrao(
                    label: 'Cliente',
                    hint: 'Cliente',
                    controller: _clienteProjetoController,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: 3,
                  child: CampoTextoPadrao(
                    label: 'Nome do Projeto',
                    hint: 'Título do Projeto',
                    controller: _nomeProjetoController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: DropdownPadrao(
                    label: 'Prioridade',
                    itens: ['Baixa', 'Média', 'Alta'],
                    valorSelecionado: _prioridadeSelecionado,
                    onChanged: (valorSelecionado) {
                      setState(() {
                        print('Cargo selecionado é: $valorSelecionado');
                        _prioridadeSelecionado = valorSelecionado;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CampoTextoPadrao(
                    label: 'Data inicio',
                    hint: 'Data Inicio',
                    controller: _dataInicioController,
                    onTap: () => _selecionarData(_dataInicioController),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A data é obrigatória';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(width: 8),

                Expanded(
                  child: CampoTextoPadrao(
                    label: 'Data Fim',
                    hint: 'Data Fim',
                    controller: _dataFimController,
                    onTap: () => _selecionarData(_dataFimController),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A data é obrigatória';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CampoTextoPadrao(
                    label: 'Escopo',
                    hint: 'Escopo do projeto',
                    controller: _escopoProjetoController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SizedBox(
          height: 56,
          child: Align(
            alignment: Alignment.centerLeft,
            child: BotaoPadrao(
              label: 'Salvar Projeto',
              onPressed: () async {

                if (_prioridadeSelecionado == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, selecione o cargo do analista!'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return;
              }

                Projeto novoProjeto = Projeto(
                  nomeProjeto: _nomeProjetoController,
                  descricaoEscopo: _escopoProjetoController,
                  prioridade: _prioridadeSelecionado,
                  dataInicioPrevista: _dataInicioController,
                  dataTerminoPrevista: _dataFimController,
                  cliente: _clienteProjetoController,
                );
                
              },
            ),
          ),
        ),
      ),
    );
  }
}
