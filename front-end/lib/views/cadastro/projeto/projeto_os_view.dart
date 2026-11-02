import 'dart:typed_data';
import 'package:axi_stack/services/ordem_servico_pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:axi_stack/models/cliente_model.dart';

class VisualizarOsView extends StatefulWidget {
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
  State<VisualizarOsView> createState() => _VisualizarOsViewState();
}

class _VisualizarOsViewState extends State<VisualizarOsView> {
  // Variável que vai guardar o PDF gerado em memória
  late Future<Uint8List> _pdfFuture;

  @override
  void initState() {
    super.initState();
    // Inicia a geração apenas UMA vez quando a tela abre
    _pdfFuture = _gerarPdfEmMemoria();
  }

  Future<Uint8List> _gerarPdfEmMemoria() {
    return OrdemServicoPdfService.gerarPdf(
      tipoServico: widget.tipoServico,
      analista: widget.analista,
      dataRelatorio: widget.dataRelatorio,
      cliente: widget.cliente,
      numeroChamado: widget.numeroChamado,
      servicoLocal: widget.servicoLocal,
      alimentacaoRS: widget.alimentacaoRS,
      kmTotal: widget.kmTotal,
      servicos: widget.servicos,
      motivoServico: widget.motivoServico,
      periodos: widget.periodos,
    );
  }

  Future<void> _imprimir(BuildContext context) async {
    // Reutiliza os bytes já gerados no initState!
    final bytes = await _pdfFuture;

    await Printing.layoutPdf(
      onLayout: (_) async => bytes,
      name: 'OS_${widget.numeroChamado.isNotEmpty ? widget.numeroChamado : "Relatorio"}',
    );
  }

  Future<void> _compartilhar(BuildContext context) async {
    final bytes = await _pdfFuture;
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'OS_${widget.cliente.razaoSocial.replaceAll(' ', '_')}.pdf',
    );
  }

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
        automaticallyImplyLeading: false, 
        
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Pré-visualização da O.S',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      if (widget.numeroChamado.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: corLaranja.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: corLaranja, width: 1),
                          ),
                          child: Text(
                            '#${widget.numeroChamado}',
                            style: const TextStyle(
                                color: corLaranja,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    widget.cliente.razaoSocial,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // --- CENTRO: Botões Imprimir e Compartilhar ---
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  mouseCursor: SystemMouseCursors.click,
                  tooltip: 'Imprimir',
                  icon: const Icon(Icons.print, color: Colors.white),
                  onPressed: () => _imprimir(context),
                ),
                IconButton(
                  mouseCursor: SystemMouseCursors.click,
                  tooltip: 'Download',
                  icon: const Icon(Icons.save_alt, color: Colors.white),
                  onPressed: () => _compartilhar(context),
                ),
              ],
            ),
            
            const Spacer(),
          ],
        ),
        
        actions: [
          IconButton(
            tooltip: 'Fechar',
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: PdfPreview(
        useActions: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        maxPageWidth: 720,
        scrollViewDecoration: const BoxDecoration(
          color: corFundo,
        ),
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
        build: (format) => _pdfFuture,
      ),
    );
  }
}