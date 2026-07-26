import 'package:flutter/material.dart';
import 'package:gestorsofttec/models/cliente_model.dart';
import 'package:gestorsofttec/services/cliente_service.dart';
import 'package:gestorsofttec/widgets/botao_padrao.dart';
import 'package:gestorsofttec/widgets/caixa_alta.dart';
import 'package:gestorsofttec/widgets/campo_texto_padrao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormularioClientes extends StatefulWidget {
  const FormularioClientes({super.key});

  @override
  State<FormularioClientes> createState() => _FormularioClientesState();
}

class _FormularioClientesState extends State<FormularioClientes> {
  final _razaoSocialController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();
  final _contatoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _mascaraCNPJ = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9a-zA-Z]')},
  );

  final _mascaraTelefone = MaskTextInputFormatter(
    mask: '(##)# ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _razaoSocialController.dispose();
    _cnpjController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _ufController.dispose();
    _contatoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
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
                'Dados do Cliente',
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
                      label: 'Razão Social',
                      hint: 'Ex: Supermercado ...',
                      controller: _razaoSocialController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'CNPJ',
                      hint: '00.000.000/0000-00',
                      inputFormatters: [UpperCaseTextFormatter(), _mascaraCNPJ],
                      controller: _cnpjController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CampoTextoPadrao(
                      label: 'Endereço',
                      hint: 'Ex: Avenida Oscar ...',
                      controller: _enderecoController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: CampoTextoPadrao(
                      label: 'Cidade',
                      hint: 'Goiânia',
                      controller: _cidadeController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'UF',
                      hint: 'GO',
                      controller: _ufController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'Contato',
                      hint: 'Nome do responsável',
                      controller: _contatoController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'Telefone',
                      hint: '(00) 9 0000-0000',
                      inputFormatters: [_mascaraTelefone],
                      controller: _telefoneController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'E-mail',
                      hint: 'administração@Softtecsistemas.com.br',
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
            label: 'Salvar Cliente',
            icone: Icons.save,
            onPressed: () async {
              Cliente clienteNovo = Cliente(
                razaoSocial: _razaoSocialController.text,
                cnpj: _cnpjController.text,
                endereco: _enderecoController.text,
                cidade: _cidadeController.text,
                uf: _ufController.text,
                contato: _contatoController.text,
                telefone: _telefoneController.text,
                email: _emailController.text,
              );

              Cliente? clienteSalvo = await ClienteService().salvarCliente(
                clienteNovo,
              );
              if (clienteSalvo != null && clienteSalvo.codigoCliente != null) {
                if (!context.mounted) return;

                // === MENSAGEM DE SUCESSO === //
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sucesso! Cliente salvo com o Código: ${clienteSalvo.codigoCliente}',
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
