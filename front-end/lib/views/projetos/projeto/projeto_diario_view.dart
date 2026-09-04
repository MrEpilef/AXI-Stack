import 'package:axi_stack/controllers/projeto_controller.dart';
import 'package:axi_stack/services/ordem_servico_pdf.dart';
import 'package:axi_stack/widgets/radio_group_padrao.dart';
import 'package:flutter/material.dart';
import 'package:axi_stack/widgets/campo_texto_padrao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ProjetoDiarioView extends StatefulWidget {
  const ProjetoDiarioView({super.key});

  @override
  State<StatefulWidget> createState() => _ProjetoDiarioViewState();
}

class _ProjetoDiarioViewState extends State<ProjetoDiarioView> {
  DateTime _dataSelecionada = DateTime.now();
  bool _mostraPainel = false;
  bool _assinarDigitalmente = false;
  TipoServico _servicoSelecionado = TipoServico.implantacao;
  final TextEditingController _servicoController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double larguraTela = MediaQuery.of(context).size.width;
    final bool isMobile = larguraTela < 1200;

    final Widget calendarioBox = Container(
                  width: 300,
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
                );


    return Scaffold(
      backgroundColor: Colors.transparent,

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF4103),
        onPressed: () async {
          
            final projetoAtivo = context.read<ProjetoController>().projetoAtivo;

            if (projetoAtivo == null) {
              print("Erro: Nenhum projeto ativo encontrado no controller");
              return; 
            }

            final clienteProjeto = projetoAtivo.cliente;

            await OrdemServicoPdfService.imprimir(
              tipoServico: _servicoSelecionado,
              analista: 'Felipe Miguel',
              cliente: clienteProjeto,
              dataRelatorio: _dataSelecionada,
              
              motivoServico: 'Solicitaçõa de Acompanhamento',
              numeroChamado: '',
              servicoLocal: 'Presencial',
              servicos: _servicoController.text
                        .split('\n')
                        .where((linha) => linha.trim().isNotEmpty)
                        .map((linha) => ItemServico(descricao: linha.trim()))
                        .toList(),
              periodos: [
                {'data': formatarData(_dataSelecionada),
                'inicio': '08:00',
                'saida': '12:00',
                'retorno': '13:15',
                'fim': '18:00'},
              ],
            );
        },
        child: const Icon(Icons.print, color: Colors.white),
      ),


      body: Padding(
        padding: const EdgeInsetsGeometry.only(top: 16, bottom: 32),
        child: ListView(
          children: [
            isMobile
              ? Column(
                  children: [
                    calendarioBox,
                    const SizedBox(height: 32), // Espaço vertical
                    if (_mostraPainel) _construirPainelOS(),
                  ],
                )
              : Row(
                children: [
                  calendarioBox,
                  const SizedBox(width: 32),
                  if (_mostraPainel) Expanded(child: _construirPainelOS())
                ],
              )
          ],
        ),
      )
    );
  }

  Widget _construirPainelOS() {
    final mascaraHorario = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tipo Serviço',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              RadioGroupPadrao<TipoServico>(
                opcoes: TipoServico.values,
                valorSelecionado: _servicoSelecionado,
                onChanged: (valor){
                  setState(() {
                    _servicoSelecionado = valor;
                  });
                },
                tituloOpcao: (opcao){
                  switch (opcao){
                    case TipoServico.implantacao: return "Implantação";
                    case TipoServico.visita: return "Visita";
                    case TipoServico.treinamento: return "Treinamento";
                    case TipoServico.suporte_tecnico: return "Suporte Técnico";
                  }
                }),


            Text(
              'Serviços ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: CampoTextoPadrao(
                    label: "Adicionar Serviço",
                    hint: "Treinamento ...",
                    maxLines: null,
                    controller: _servicoController,
                  ),
                ),
              ],
            ),

            Divider(
              height: 40,
              thickness: 1,
            ),


            Text('Horário', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),


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
                    label: "1º Saída",
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

            const SizedBox(height: 15),

            Divider(
              height: 10,
              thickness: 1,
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Assinar Digitalmente OS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        Switch(
                          value: _assinarDigitalmente,
                          
                          activeThumbColor: const Color(0xFFFF4103),
                          activeTrackColor: const Color(0xFFFF4103).withValues(alpha: 0.3),
                          inactiveThumbColor: Colors.grey[350],
                          inactiveTrackColor: Color(0xFF001B29),
                          //inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                          




                          onChanged: (bool valorAlterado) {
                            setState(() {
                              _assinarDigitalmente = valorAlterado;
                            });
                            print("Switch mudou para: $_assinarDigitalmente");
                          },
                        ),


                        
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
    );
  }

}