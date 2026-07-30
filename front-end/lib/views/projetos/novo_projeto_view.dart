import 'package:flutter/material.dart';
import 'package:axi_stack/widgets/botao_padrao.dart';
import 'package:axi_stack/widgets/campo_texto_padrao.dart';

class NovoProjetoView extends StatelessWidget {
  final VoidCallback onVoltar;

  const NovoProjetoView({super.key, required this.onVoltar});

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
              onPressed: onVoltar,
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
                  child: CampoTextoPadrao(label: 'Cliente', hint: 'Cliente'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: CampoTextoPadrao(
                    label: 'Título',
                    hint: 'Título do projeto',
                  ),
                ),
              ],
            ),
            Row(),
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
            onPressed: () {
              print('Salvo projeto');
            },
          ),
          ),
        ),
      ),
    );
  }
}
