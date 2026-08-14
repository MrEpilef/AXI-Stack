import 'package:axi_stack/models/cliente_model.dart';
import 'package:axi_stack/models/projeto_model.dart';
import 'package:axi_stack/services/cliente_service.dart';
import 'package:axi_stack/services/projeto_service.dart';
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
  final _formKey = GlobalKey<FormState>();
  String? _prioridadeSelecionado;
  final _clienteController = TextEditingController();
  final _nomeProjetoController = TextEditingController();
  final _dataInicioController = TextEditingController();
  final _dataFimController = TextEditingController();
  final _escopoProjetoController = TextEditingController();
  Cliente? _clienteSelecionado;
  List<Cliente> _listaTodosClientes = [];

  bool _carregandoClientes = true;

  void initState() {
    super.initState();

    _baixarClientes();
  }

  Future<void> _baixarClientes() async {
    final service = ClienteService();
    final listaClientes = await service.buscarListaCLientes();

    if (mounted) {
      setState(() {
        _listaTodosClientes = listaClientes;
        _carregandoClientes = false;
      });
    }
  }

  @override
  void dispose() {
    _dataInicioController.dispose();
    _dataFimController.dispose();

    super.dispose();
  }

  void pesquisa() {}

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

        child: Form(
          key: _formKey,
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
                    child: Autocomplete<Cliente>(
                      displayStringForOption: (Cliente cliente) =>
                          cliente.razaoSocial,

                      onSelected: (Cliente clienteEscolhido) {
                        setState(() {
                          _clienteSelecionado = clienteEscolhido;
                          print(
                            "Cliente selecionado nos bastidores: ${_clienteSelecionado!.razaoSocial}",
                          );
                        });
                      },

                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<Cliente>.empty();
                        }
                        return _listaTodosClientes.where((Cliente cliente) {
                          return cliente.razaoSocial.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          );
                        });
                      },
                      fieldViewBuilder:
                          (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFildSubmitted,
                          ) {
                            return CampoTextoPadrao(
                              label: 'Cliente',
                              hint: _carregandoClientes
                                  ? 'Baixando clientes..'
                                  : 'Digite para pesquisar',
                              controller: textEditingController,
                              focusNode: focusNode,
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Color(0xFFFF4103),
                                ),
                                onPressed: () {
                                  if (textEditingController.text.isEmpty) {
                                    focusNode.unfocus();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Por favor, digite algo para pesquisar!',
                                        ),
                                        backgroundColor: Colors.orange,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    focusNode.requestFocus();
                                  }
                                },
                              ),
                            );
                          },
                      // COLOCAR O DESIGN DO MEU Autocomplete
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    flex: 3,
                    child: CampoTextoPadrao(
                      label: 'Nome do Projeto',
                      hint: 'Título do Projeto',
                      controller: _nomeProjetoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Necessário declarar um nome ao projeto';
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
                bool formularioValido = _formKey.currentState!.validate();

                if (_prioridadeSelecionado == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color(0xFF001B29),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color(0xFFFF4103),
                          width: 1.5,
                        ),
                      ),
                      content: const Text(
                        'Por favor, pesquise e selecione um cliente na lista!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                  return;
                }

                if (formularioValido) {
                  print("Tudo validado! Preparando para salvar...");

                  Projeto novoProjeto = Projeto(
                    nomeProjeto: _nomeProjetoController.text,
                    descricaoEscopo: _escopoProjetoController.text,
                    prioridade: _prioridadeSelecionado!,
                    dataInicioPrevista: _dataInicioController.text,
                    dataTerminoPrevista: _dataFimController.text,
                    cliente: _clienteSelecionado!,
                  );

                  final IProjetoService servico = ProjetoServiceMock();

                  Projeto? projetoSalvo = await servico.salvarProjeto(novoProjeto);

                  if (projetoSalvo != null &&
                      projetoSalvo.codigoProjeto != null) {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Sucesso! Analista salvo com o Código: ${projetoSalvo.codigoProjeto}',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  print(novoProjeto.toJson());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
