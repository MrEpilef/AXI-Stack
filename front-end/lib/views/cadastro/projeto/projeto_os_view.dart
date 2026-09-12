import 'package:axi_stack/services/ordem_servico_pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:axi_stack/models/cliente_model.dart';


class VisualizarOsView extends StatelessWidget {
  final TipoServico tipoServico;
  final String analista;
  final DateTime dataRelatorio;
  final Cliente cliente;
  final String numeroChamado;
  final String servicoLocal;
  final String alimentacaoRS;
  final String kmTotal;
  final List<ItemServico> servicos;
  final String motivoServico;
  final List<Map<String, String>> periodos;

  const VisualizarOsView({
    super.key,
    required this.tipoServico,
    required this.analista,
    required this.dataRelatorio,
    required this.cliente,
    required this.numeroChamado,
    required this.servicoLocal,
    this.alimentacaoRS = '',
    this.kmTotal = '',
    required this.servicos,
    this.motivoServico = '',
    required this.periodos,
  });

  @override
  Widget build(BuildContext context) {
    const corFundo = Color(0xFF000D15);
    const corCard = Color(0xFF001B29);
    const corLaranja = Color(0xFFFF4103);

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        backgroundColor: corCard,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Pré-visualização da O.S',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                ),
                if (numeroChamado.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: corLaranja.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: corLaranja, width: 1),
                    ),
                    child: Text(
                      '#$numeroChamado',
                      style: const TextStyle(color: corLaranja, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
            Text(
              cliente.razaoSocial,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Imprimir',
            icon: const Icon(Icons.print_outlined, color: Colors.white),
            onPressed: () => _imprimir(context),
          ),
          IconButton(
            tooltip: 'Compartilhar',
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () => _compartilhar(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: PdfPreview(
        // Remove a barra roxa do rodapé:
        useActions: false, 
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        maxPageWidth: 720, // Limita a largura para a folha A4 não esticar excessivamente em telas grandes

        // Fundo escuro atrás da folha
        scrollViewDecoration: const BoxDecoration(
          color: corFundo,
        ),

        // Efeito de folha física de papel (margem e sombra suave)
        pdfPreviewPageDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 16,
              spreadRadius: 2,
              offset: Offset(0, 6),
            ),
          ],
        ),

        build: (format) => OrdemServicoPdfService.gerarPdf(
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
      ),
    );
  }

  Future<void> _imprimir(BuildContext context) async {
    final bytes = await OrdemServicoPdfService.gerarPdf(
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
    );

    await Printing.layoutPdf(
      onLayout: (_) => bytes,
      name: 'OS_${numeroChamado.isNotEmpty ? numeroChamado : "Relatorio"}',
    );
  }

  Future<void> _compartilhar(BuildContext context) async {
    final bytes = await OrdemServicoPdfService.gerarPdf(
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
    );

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'OS_${cliente.razaoSocial.replaceAll(' ', '_')}.pdf',
    );
  }
}