import 'package:axi_stack/widgets/radio_group_padrao.dart';
import 'package:flutter/material.dart';
import 'package:axi_stack/widgets/botao_padrao.dart';
import 'package:axi_stack/widgets/campo_texto_padrao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

enum TipoServico { implantacao, visita, treinamento, suporte_tecnico }

class ProjetoDiarioView extends StatefulWidget {
  const ProjetoDiarioView({super.key});

  @override
  State<StatefulWidget> createState() => _ProjetoDiarioViewState();
}

class _ProjetoDiarioViewState extends State<ProjetoDiarioView> {
  DateTime _dataSelecionada = DateTime.now();
  bool _mostraPainel = false;
  bool _assinarDigitalmente = false;
  TipoServico? _servicoSelecionado = TipoServico.implantacao;
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
          await imprimirOrdemDeServico();
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
  Future<void> imprimirOrdemDeServico() async {
  // 1. Cria o documento PDF em branco
    final pdf = pw.Document();

    // 2. Monta a página (O padrão já é folha A4)
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              pw.Center(
                child: pw.Text('ORDEM DE SERVIÇO', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              
              // Aqui você puxa as variáveis reais do seu sistema
              pw.Text('Data: 04 de Setembro de 2026', style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Analista: (Nome do Analista)', style: const pw.TextStyle(fontSize: 14)),
              pw.Divider(),


              pw.Text('Tipo Serviço:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Wrap(
                spacing: 20,
                children: TipoServico.values.map((opcao) {
                  String textoOpcao = '';
                  switch (opcao) {
                    case TipoServico.implantacao: textoOpcao = 'Implantação'; break;
                    case TipoServico.visita: textoOpcao = 'Visita'; break;
                    case TipoServico.treinamento: textoOpcao = 'Treinamento'; break;
                    case TipoServico.suporte_tecnico: textoOpcao = 'Treinamento'; break;
                  }

                  
                  bool isSelecionado = _servicoSelecionado == opcao;

                  return pw.Row(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Container(
                        width: 14,
                        height: 14,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          border: pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                        
                        child: isSelecionado
                            ? pw.Center(
                                child: pw.Container(
                                  width: 7,
                                  height: 7,
                                  decoration: const pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    color: PdfColors.black,
                                  ),
                                ),
                              )
                            : pw.SizedBox(),
                      ),
                      
                      pw.SizedBox(width: 6), // Espaço entre a bolinha e o texto
                      
                      // O Texto
                      pw.Text(textoOpcao, style: const pw.TextStyle(fontSize: 12)),
                    ],
                  );
                }).toList(),
              ),

              pw.SizedBox(height: 20),
              pw.Divider(),


              // Serviços Realizados (Igual ao seu print)
              pw.Text('Serviços Realizados:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              ..._servicoController.text
                  .split('\n')
                  .where((linha) => linha.trim().isNotEmpty)
                  .map((servico) => pw.Bullet(text: servico)),

              pw.SizedBox(height: 15),
              
              // Horários
              pw.Text('Horários Apontados:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('1º Entrada: 08:15'),
                  pw.Text('1º Saída: 12:00'),
                  pw.Text('2º Entrada: 13:15'),
                  pw.Text('2º Saída: 18:00'),
                ],
              ),
              pw.Divider(),

              // Espaço para Assinatura no final da página
              pw.Spacer(),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Container(width: 250, height: 1, color: PdfColors.black),
                    pw.SizedBox(height: 5),
                    pw.Text('Assinatura do Cliente / Responsável'),
                  ]
                )
              )
            ],
          );
        },
      ),
    );

    // 3. O "Pulo do Gato": Chama o sistema nativo de impressão (Windows/Android)
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'OS_04_Setembro_2026', // Nome do arquivo gerado
    );
  }
}
