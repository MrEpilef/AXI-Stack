import 'package:flutter/material.dart';
import 'package:gestorsofttec/widgets/botao_padrao.dart';
import 'package:gestorsofttec/widgets/campo_texto_padrao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProjetoDiarioView extends StatefulWidget {
  const ProjetoDiarioView({super.key});

  @override
  State<StatefulWidget> createState() => _ProjetoDiarioViewState();
}

class _ProjetoDiarioViewState extends State<ProjetoDiarioView> {
  DateTime _dataSelecionada = DateTime.now();
  bool _mostraPainel = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(top: 16, bottom: 32),
      child: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFF001B29),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xFFF14004),
                      onPrimary: Colors.white,
                      surface: Color(0xFF001B29),
                      onSurface: Colors.white,
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: _dataSelecionada,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099),
                    onDateChanged: (novaData) {
                      setState(() {
                        _dataSelecionada = novaData;
                        _mostraPainel = true;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          if (_mostraPainel) _construirPainelOS(),
        ],
      ),
    );
  }

  Widget _construirPainelOS() {
    final mascaraHorario = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CampoTextoPadrao(
                label: "Adicionar Serviço",
                hint: "Treinamento ...",
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
                label: "1º Entrada",
                hint: "08:00",
                inputFormatters: [mascaraHorario],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: CampoTextoPadrao(
                label: "2º Entrada",
                hint: "12:00",
                inputFormatters: [mascaraHorario],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: CampoTextoPadrao(
                label: "2º Entrada",
                hint: "13:15",
                inputFormatters: [mascaraHorario],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: CampoTextoPadrao(
                label: "2º Saída",
                hint: "18:00",
                inputFormatters: [mascaraHorario],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: CampoTextoPadrao(
                label: "Assinar Digitalmente a O.S",
                hint: "Horário feito",
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: BotaoPadrao(
                label: "Salvar",
                onPressed: () {
                  print("Salvar O.S dia: ${_dataSelecionada}");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
