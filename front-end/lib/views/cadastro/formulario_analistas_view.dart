import 'package:flutter/material.dart';
import 'package:axi_stack/models/analista_model.dart';
import 'package:axi_stack/services/analista_service.dart';
import 'package:axi_stack/widgets/botao_padrao.dart';
import 'package:axi_stack/widgets/campo_texto_padrao.dart';
import 'package:axi_stack/widgets/dropdown_padrao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormularioAnalistas extends StatefulWidget {
  const FormularioAnalistas({super.key});

  @override
  State<FormularioAnalistas> createState() => _FormularioAnalistasState();
}

class _FormularioAnalistasState extends State<FormularioAnalistas> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  String? _cargoSelecionado;
  final _mascaraTelefone = MaskTextInputFormatter(
    mask: '(##)# ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dados do Analista',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CampoTextoPadrao(
                      label: 'Nome completo',
                      hint: 'Nome Completo',
                      controller: _nomeController,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    flex: 1,
                    child: DropdownPadrao(
                      label: 'Cargo',
                      itens: [
                        'Suporte Técnico',
                        'Implantador',
                        'Gerente',
                        'Diretor',
                      ],
                      valorSelecionado: _cargoSelecionado,
                      onChanged: (valorSelecionado) {
                        print('Cargo selecionado é :$valorSelecionado');
                        setState(() {
                          _cargoSelecionado = valorSelecionado;
                        });
                      },
                    ),
                  ),

                  

                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CampoTextoPadrao(
                      label: 'E-mail',
                      hint: 'analista@softtecsistemas.com.br',
                      controller: _emailController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'Telefone',
                      hint: '(00) 00000-0000',
                      controller: _telefoneController,
                      inputFormatters: [_mascaraTelefone],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 32.0,
          left: 32.0,
          child: BotaoPadrao(
            label: 'SALVAR ANALISTA',
            icone: Icons.save,
            onPressed: () async {

              if (_cargoSelecionado == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, selecione o cargo do analista!'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                return;
              }

              Analista novoAnalista = Analista(
                nome: _nomeController.text,
                cargo: _cargoSelecionado!,
                email: _emailController.text,
                telefone: _telefoneController.text,
              );

              Analista? analistaSalvo = await AnalistaService().salvarAnalista(
                novoAnalista,
              );

              if (analistaSalvo != null &&
                  analistaSalvo.codigoAnalista != null) {
                if (!context.mounted) return; // Proteção padrão do Flutter

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sucesso! Analista salvo com o Código: ${analistaSalvo.codigoAnalista}',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
