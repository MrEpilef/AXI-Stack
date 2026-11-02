import 'package:axi_stack/models/cliente_model.dart';
import 'package:axi_stack/services/ordem_servico_pdf.dart';

class OrdemServico {
  // === GERADOS PELO BACKEND ===
  final int? codigoOS;
  final String? numeroIdentificador;
  final String? dataCriacao;

  // === OBRIGATÓRIOS ===
  final Cliente cliente;
  final String analista;
  final DateTime dataRelatorio;
  final TipoServico tipoServico;
  final List<ItemServico> servicos;
  final List<Map<String, String>> periodos;

  // === CAMPOS NÃO OBRIGATÓRIOS ===
  final double? horasTrabalhadas;
  final bool isFaturada;
  final String? statusOs;
  final String? alimentacaoRS;
  final String? kmTotal;
  final String? motivoServico;
  final String? numeroChamado;
  final String? servicoLocal;
  final int? codigoProjeto;

  OrdemServico({
    this.codigoOS,
    this.numeroIdentificador,
    this.dataCriacao,
    required this.cliente,
    required this.analista,
    required this.dataRelatorio,
    required this.tipoServico,
    required this.servicos,
    required this.periodos,
    this.isFaturada = false,
    this.horasTrabalhadas,
    this.statusOs,
    this.alimentacaoRS,
    this.kmTotal,
    this.motivoServico,
    this.numeroChamado,
    this.servicoLocal,
    this.codigoProjeto,
  });

  OrdemServico copyWith({
    int? codigoOS,
    String? numeroIdentificador,
    String? dataCriacao,
    String? statusOs,
  }) {
    return OrdemServico(
      codigoOS: codigoOS ?? this.codigoOS,
      numeroIdentificador: numeroIdentificador ?? this.numeroIdentificador,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      statusOs: statusOs ?? this.statusOs,
      cliente: cliente,
      analista: analista,
      dataRelatorio: dataRelatorio,
      tipoServico: tipoServico,
      servicos: servicos,
      periodos: periodos,
      isFaturada: isFaturada,
      horasTrabalhadas: horasTrabalhadas,
      alimentacaoRS: alimentacaoRS,
      kmTotal: kmTotal,
      motivoServico: motivoServico,
      numeroChamado: numeroChamado,
      servicoLocal: servicoLocal,
      codigoProjeto: codigoProjeto,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // IDs de relacionamento esperados pelo OrdemServicoRequestDTO no Java
      'codigoCliente': cliente.codigoCliente,
      'codigoProjeto': codigoProjeto,
      'codigoAnalista': 1,

      // Dados da O.S.
      'numeroChamado': numeroChamado,
      'servicoLocal': servicoLocal,
      'tipoServico': tipoServico.name.toUpperCase(),
      'dataRelatorio': dataRelatorio.toIso8601String().substring(0, 10),
      'motivoServico': motivoServico,

      // Conversão de String para Double
      'valorAlimentacao': double.tryParse(
              (alimentacaoRS ?? '0').replaceAll(',', '.').trim()) ??
          0.0,
      'kmTotal':
          double.tryParse((kmTotal ?? '0').replaceAll(',', '.').trim()) ?? 0.0,

      // Envia a descricao real e preenche valor/assinatura como null para o DTO do Java
      'servicos': servicos
          .map((item) => {
                'descricao': item.descricao,
                'valor': null,
                'assinatura': null,
              })
          .toList(),
      'periodos': periodos,
    };
  }

  factory OrdemServico.fromJson(Map<String, dynamic> json) {
    // 1. Trata o nome do analista com segurança
    String nomeAnalista = 'Felipe Miguel';
    final rawAnalista = json['analista'];
    if (rawAnalista is Map) {
      nomeAnalista = rawAnalista['nome']?.toString() ?? 'Felipe Miguel';
    } else if (rawAnalista != null) {
      nomeAnalista = rawAnalista.toString();
    }

    // 2. Converte a lista de serviços vinda do banco
    final List<ItemServico> listaServicos = [];
    if (json['servicos'] is List) {
      for (final item in (json['servicos'] as List)) {
        if (item is Map) {
          listaServicos.add(
            ItemServico(descricao: item['descricao']?.toString() ?? ''),
          );
        } else if (item is String) {
          listaServicos.add(ItemServico(descricao: item));
        }
      }
    }

    // 3. Converte a lista de períodos vinda do banco
    final List<Map<String, String>> listaPeriodos = [];
      if (json['periodos'] is List) {
        for (final item in (json['periodos'] as List)) {
          if (item is Map) {
            listaPeriodos.add(
              item.map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')),
            );
          }
        }
      }

    return OrdemServico(
      codigoOS: json['codigoOS'],
      numeroIdentificador: json['numeroIdentificador'],
      dataCriacao: json['dataCriacao']?.toString(),
      statusOs: json['statusOs'],
      isFaturada: json['isFaturada'] ?? false,
      horasTrabalhadas: (json['horasTrabalhadas'] as num?)?.toDouble(),
      numeroChamado: json['numeroChamado'],
      servicoLocal: json['servicoLocal'],
      motivoServico: json['motivoServico'],
      alimentacaoRS: json['valorAlimentacao']?.toString(),
      kmTotal: json['kmTotal']?.toString(),
      dataRelatorio: json['dataRelatorio'] != null
          ? DateTime.parse(json['dataRelatorio'].toString())
          : DateTime.now(),
      tipoServico: TipoServico.values.firstWhere(
        (e) =>
            e.name.toUpperCase() ==
            (json['tipoServico'] as String? ?? '').toUpperCase(),
        orElse: () => TipoServico.implantacao,
      ),
      cliente: json['cliente'] != null
          ? Cliente.fromJson(json['cliente'])
          : Cliente(
              codigoCliente: json['codigoCliente'],
              razaoSocial: json['nomeCliente'] ?? 'Cliente',
              cnpj: '',
              cidade: '',
              uf: '',
              endereco: '',
              contato: '',
              telefone: '',
            ),
      analista: nomeAnalista,
      servicos: listaServicos,
      periodos: listaPeriodos,
    );
  }
}