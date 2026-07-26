import 'package:flutter/material.dart';
import 'package:gestorsofttec/widgets/botao_padrao.dart';
import 'package:gestorsofttec/widgets/campo_texto_padrao.dart';

class FormularioClientes extends StatefulWidget {
  const FormularioClientes({super.key});

  @override
  State<FormularioClientes> createState() => _FormularioClientesState();
}

class _FormularioClientesState extends State<FormularioClientes>{
  
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
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'CNPJ',
                      hint: '00.000.000/0000-00',
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
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: CampoTextoPadrao(
                      label: 'Cidade',
                      hint: 'Goiânia',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'UF',
                      hint: 'GO',
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
                      hint: 'Nome',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CampoTextoPadrao(
                      label: 'Telefone',
                      hint: '(00) 9 0000-0000',
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
                          hint: 'administração@Softtecsistemas.com.br'),
                      ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 32.0,
          left: 32.0,
          child: BotaoPadrao(
            label: 'Salvar Cliente',
            onPressed: () {
              print('Cliente salvo!');
            },
            icone: Icons.save,
          ),
        ),
        
      ],
    );
  }


}