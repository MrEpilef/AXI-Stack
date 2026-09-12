import 'package:axi_stack/models/cliente_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

enum TipoServico { implantacao, visita, treinamento, suporte_tecnico }

String formatarData(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  
class ItemServico {
    final String descricao;
    final String? valor;
    final String? assinatura;
  
    ItemServico({
      required this.descricao,
      this.valor,
      this.assinatura});
  }

class OrdemServicoPdfService {
  //  impedir instanciação em outras telas
  OrdemServicoPdfService._();


  static const _corLaranjaClara = PdfColor.fromInt(0xFFFBD9B8);
  static const _corCabecalhoTabela = PdfColor.fromInt(0xFFBFD7EA);


  
  static String textoTipo(TipoServico t) {
    switch (t) {
      case TipoServico.implantacao:
        return 'Implantação';
      case TipoServico.visita:
        return 'Visita';
      case TipoServico.treinamento:
        return 'Treinamento';
      case TipoServico.suporte_tecnico:
        return 'Suporte Técnico';
    }
  }




  static Future<Uint8List> gerarPdf({
    // Cabeçalho / tipo de serviço
    PdfPageFormat format = PdfPageFormat.a4,

    required TipoServico tipoServico,
    required String analista,
    required DateTime dataRelatorio,
  
    // Dados do cliente
    required Cliente cliente,

    required String numeroChamado,
    required String servicoLocal, 

    String alimentacaoRS = '',
    String kmTotal = '',
  
    required List<ItemServico> servicos,
    String motivoServico = '',
  
    required List<Map<String, String>> periodos,
    
  }) async {
    final fonteRegular = await PdfGoogleFonts.robotoRegular();
    final fonteBold = await PdfGoogleFonts.robotoBold();
    final fonteItalic = await PdfGoogleFonts.robotoItalic();

    
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: fonteRegular,
        bold: fonteBold,
        italic: fonteItalic,
      ),
    );
  
    // Carrega as logos
    final logoIntersolid =
        pw.MemoryImage((await rootBundle.load('assets/logo_intersolid.png')).buffer.asUint8List());
    final logoSoftTec =
        pw.MemoryImage((await rootBundle.load('assets/logo_softtec.png')).buffer.asUint8List());
    final logoIxSoft =
        pw.MemoryImage((await rootBundle.load('assets/logo_mixsoft.png')).buffer.asUint8List());
  
    
  
    
  
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(24, 20, 24, 0),
  
        // ---------------------------------------------------------
        // CABEÇALHO — repetido em todas as páginas
        // ---------------------------------------------------------
        header: (context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(logoIntersolid, height: 40),
                  pw.Image(logoSoftTec, height: 40),
                  pw.Image(logoIxSoft, height: 40),
                ],
              ),
              pw.SizedBox(height: 6),
              pw.Center(
                child: pw.Text(
                  'Requisição de Serviços Técnicos',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 10),
            ],
          );
        },
  
        // ---------------------------------------------------------
        // RODAPÉ — barra laranja com endereço, repetida em todas as páginas
        // ---------------------------------------------------------
        footer: (context) {
          return pw.Container(
            width: double.infinity,
            margin: const pw.EdgeInsets.only(top: 10),
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: const pw.BoxDecoration(color: _corLaranjaClara),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Soft-Tec - Soluções para Supermercado',
                    style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                pw.Text('Rua Carlos Chagas nº 154 - Setor Serrinha - Goiânia', style: const pw.TextStyle(fontSize: 8)),
                pw.Text('Rua Padre Luiz Gonzaga nº 427 - Bairro Jundiaí - Anápolis', style: const pw.TextStyle(fontSize: 8)),
                pw.Text('Fone: (62) 3096-7760', style: const pw.TextStyle(fontSize: 8)),
                pw.SizedBox(height: 4),
                pw.Text('Página ${context.pageNumber} de ${context.pagesCount}', style: const pw.TextStyle(fontSize: 7)),
              ],
            ),
          );
        },
  
        // ---------------------------------------------------------
        // CONTEÚDO — flui automaticamente para novas páginas
        // ---------------------------------------------------------
        build: (context) => [
          // ---- Tipo de Serviço ----
          pw.Text('Tipo de Serviço', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.SizedBox(height: 4),
          pw.Row(
            children: TipoServico.values.map((opcao) {
              final selecionado = tipoServico == opcao;
              return pw.Padding(
                padding: const pw.EdgeInsets.only(right: 18),
                child: pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Container(
                      width: 12,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.black, width: 1),
                      ),
                      child: selecionado
                          ? pw.Center(
                              child: pw.Container(
                                width: 6,
                                height: 6,
                                decoration:
                                    const pw.BoxDecoration(shape: pw.BoxShape.circle, color: PdfColors.black),
                              ),
                            )
                          : pw.SizedBox(),
                    ),

                    pw.SizedBox(width: 5),

                    pw.Text(textoTipo(opcao),
                        style: pw.TextStyle(
                            fontSize: 11, fontWeight: selecionado ? pw.FontWeight.bold : pw.FontWeight.normal)),
                  ],
                ),
              );
            }).toList(),
          ),
          pw.SizedBox(height: 10),
  
          // ---- Analista / Data ----
          pw.Row(
            children: [
              pw.Text('Analista:  ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
              pw.Text(analista, style: const pw.TextStyle(fontSize: 11)),
              pw.SizedBox(width: 40),
              pw.Text('Data do Relatório:  ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
              pw.Text(formatarData(dataRelatorio),
                  style: pw.TextStyle(fontSize: 11, fontStyle: pw.FontStyle.italic)),
            ],
          ),
          pw.SizedBox(height: 12),
  
          // ---- Dados do Cliente ----
          _tituloSecao('DADOS DO CLIENTE'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey600, width: 0.6),
            columnWidths: const {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(3),
              2: pw.FlexColumnWidth(1.3),
              3: pw.FlexColumnWidth(2),
            },
            children: [
              _linhaTabela('Nome Fantasia', cliente.razaoSocial, 'CNPJ', cliente.cnpj),
              _linhaTabela('Contato', cliente.contato, 'Telefone', cliente.telefone),
              _linhaTabela('Cidade', cliente.cidade, 'UF', cliente.uf),
              _linhaTabela('Nº Chamado', numeroChamado, 'Serviço', servicoLocal),
              _linhaTabela('Alimentação R\$', alimentacaoRS, 'Km total', kmTotal),
            ],
          ),
          pw.SizedBox(height: 14),
  
          // ---- Descrição do Serviço ----
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey600, width: 0.6),
            columnWidths: const {
              0: pw.FlexColumnWidth(5),
              1: pw.FlexColumnWidth(1),
              2: pw.FlexColumnWidth(1.6),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: _corCabecalhoTabela),
                children: [
                  _celulaCabecalho('Descrição do Serviço'),
                  _celulaCabecalho('Valor'),
                  _celulaCabecalho('Assinatura do Funcionário'),
                ],
              ),
              for (final item in servicos)
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    child: pw.Text(item.descricao, style: const pw.TextStyle(fontSize: 9.5)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    child: pw.Text(item.valor ?? '', style: const pw.TextStyle(fontSize: 9.5)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    child: pw.Text(item.assinatura ?? '', style: const pw.TextStyle(fontSize: 9.5)),
                  ),
                ]),
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: _corCabecalhoTabela),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    child: pw.Text('Motivo do Serviço:  $motivoServico',
                        style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.SizedBox(),
                  pw.SizedBox(),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 14),
  
          // ---- Controle de Tempo no Cliente ----
          _tituloSecao('CONTROLE DE TEMPO NO CLIENTE'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey600, width: 0.6),
            columnWidths: const {
              0: pw.FlexColumnWidth(1.4),
              1: pw.FlexColumnWidth(1),
              2: pw.FlexColumnWidth(1),
              3: pw.FlexColumnWidth(1),
              4: pw.FlexColumnWidth(1),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: _corCabecalhoTabela),
                children: [
                  _celulaCabecalho('Data'),
                  _celulaCabecalho('Início'),
                  _celulaCabecalho('Saída'),
                  _celulaCabecalho('Retorno'),
                  _celulaCabecalho('Fim'),
                ],
              ),
              for (final p in periodos)
                pw.TableRow(children: [
                  _celula(p['data'] ?? ''),
                  _celula(p['inicio'] ?? ''),
                  _celula(p['saida'] ?? ''),
                  _celula(p['retorno'] ?? ''),
                  _celula(p['fim'] ?? ''),
                ]),
            ],
          ),
          pw.SizedBox(height: 30),
  
          // ---- Assinatura ----
          pw.Text('ASSINATURA', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 24),
        ],
      ),
    );
  
    return pdf.save();
  }
  
  /// ----------------------------------------------------------------
  /// HELPERS de estilo
  /// ----------------------------------------------------------------
  static pw.Widget _tituloSecao(String titulo) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      color: const PdfColor.fromInt(0xFFBFD7EA),
      child: pw.Text(titulo, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
    );
  }
  
  static pw.TableRow _linhaTabela(String label1, String valor1, String label2, String valor2) {
    return pw.TableRow(children: [
      _celulaLabel(label1),
      _celula(valor1),
      _celulaLabel(label2),
      _celula(valor2),
    ]);
  }
  
  static pw.Widget _celulaLabel(String texto) => pw.Container(
        color: const PdfColor.fromInt(0xFFEFEFEF),
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: pw.Text(texto, style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
      );
  
  static pw.Widget _celula(String texto) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: pw.Text(texto, style: const pw.TextStyle(fontSize: 9.5)),
      );
  
  static pw.Widget _celulaCabecalho(String texto) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: pw.Text(texto, style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold)),
      );

  static Future<void> imprimir({
    required TipoServico tipoServico,
    required String analista,
    required DateTime dataRelatorio,
    required Cliente cliente,
    required String numeroChamado,
    required String servicoLocal,
    String alimentacaoRS = '',
    String kmTotal = '',
    required List<ItemServico> servicos,
    String motivoServico = '',
    required List<Map<String, String>> periodos,
  }) async {
    await Printing.layoutPdf(
      onLayout: (format) => gerarPdf(
        format: format,
        tipoServico: tipoServico,
        analista: analista,
        dataRelatorio: dataRelatorio,
        cliente: cliente,
        numeroChamado: numeroChamado,
        servicoLocal: servicoLocal,
        alimentacaoRS: alimentacaoRS,
        kmTotal: kmTotal,
        servicos: servicos,
        motivoServico: motivoServico,
        periodos: periodos,
      ),
      name: 'OS_${formatarData(dataRelatorio).replaceAll('/', '_')}',
    );
  }
}
