import 'package:flutter/material.dart';

class RadioGroupPadrao<T> extends StatelessWidget{
  
  final List<T> opcoes;
  final T? valorSelecionado;
  final ValueChanged<T> onChanged;
  final String Function(T) tituloOpcao;

  const RadioGroupPadrao({
    super.key,
    required this.opcoes,
    this.valorSelecionado,
    required this.onChanged,
    required this.tituloOpcao    
    });


  
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 1366;

    final List<Widget> botoesRadio = opcoes.map((T opcao) {
        return RadioListTile<T>(
          title: Text(
            tituloOpcao(opcao),
            style: const TextStyle(color: Colors.white),
          ),
          value: opcao,
          groupValue: valorSelecionado,
          activeColor: const Color(0xFFFF4103),
          onChanged: (T? valor){
            if (valor != null){
              onChanged(valor);
            }
          },
          );
      }).toList();

      return isMobile
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: botoesRadio,
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: botoesRadio.map((botao) => Expanded(child: botao)).toList(),
      );
  }
}