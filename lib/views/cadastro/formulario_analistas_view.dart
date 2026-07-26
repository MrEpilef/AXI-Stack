import 'package:flutter/material.dart';
import 'package:gestorsofttec/widgets/botao_padrao.dart';
import 'package:gestorsofttec/widgets/campo_texto_padrao.dart';
import 'package:gestorsofttec/widgets/dropdown_padrao.dart';

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
                      onChanged: (valorSelecionado) {
                        print('Cargo selecionado é :$valorSelecionado');
                      },
                      valorSelecionado: _cargoSelecionado,
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
            onPressed: () {
              print('Cadastro realizado com sucesso!');
            },
            icone: Icons.save,
          ),
        ),
      ],
    );
  }
}
