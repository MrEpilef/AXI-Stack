import 'package:axi_stack/widgets/botao_padrao.dart';
import 'package:flutter/material.dart';

class ProjetoFinanceiroView extends StatelessWidget {
  const ProjetoFinanceiroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              

            ],
          )
        ),


        Positioned(
          left: 32,
          bottom: 32,
          child: BotaoPadrao(
            label: 'Lançar despesa',
            icone: Icons.add,
            onPressed: (){}
          )
        )
      ],
    );
  }
  
}