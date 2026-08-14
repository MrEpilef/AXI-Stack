import 'package:axi_stack/models/analista_model.dart';
import 'package:axi_stack/models/projeto_model.dart';

class OrdemServico {
  //  ===GERADOS PELO BACKEND ===
  final int? codigoOS;
  final String? numeroIdentificador;
  final String? dataCriacao;

  //  === OBRIGATORIOS ===
  final String dataServico;
  final String horaInicio;
  final String horaFim;
  final String descricaoAtividade;
  final String tipoServico;

  //  === CAMPOS NAO OBRIGATORIOS ===
  final double? horasTrabalhadas;
  final bool isFaturada;
  final String? statusOs;

  final Projeto projeto;
  final Analista analista;

  OrdemServico({
    this.codigoOS,
    this.numeroIdentificador,
    this.dataCriacao,

    required this.dataServico,
    required this.horaInicio,
    required this.horaFim,
    required this.descricaoAtividade,
    required this.tipoServico,

    this.isFaturada = false,
    this.horasTrabalhadas,
    this.statusOs,

    required this.projeto,
    required this.analista,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigoOS': codigoOS,
      'numeroIdentificador': numeroIdentificador,
      'dataCriacao': dataCriacao,
      'dataServico': dataServico,
      'horaInicio': horaInicio,
      'horaFim': horaFim,
      'descricaoAtividade': descricaoAtividade,
      'tipoServico': tipoServico,
      'isFaturada': isFaturada,
      'horasTrabalhadas': horasTrabalhadas,
      'statusOs': statusOs,
      'projeto': projeto.toJson(),
      'analista': analista.toJson(),
    };
  }

  factory OrdemServico.fromJson(Map<String, dynamic> json) {
    if (json['projeto'] == null) {
      throw FormatException('Erro Crítico: A API enviou uma O.S. sem Projeto. Verifique o banco de dados. OS ID: ${json['codigoOS']}');
    }
    
    if (json['analista'] == null) {
      throw FormatException('Erro Crítico: A API enviou uma O.S. sem Analista. Verifique o banco de dados. OS ID: ${json['codigoOS']}');
    }

    return OrdemServico(
      codigoOS: json['codigoOS'],
      numeroIdentificador: json['numeroIdentificador'],
      dataCriacao: json['dataCriacao'],
      dataServico: json['dataServico'],
      horaInicio: json['horaInicio'],
      horaFim: json['horaFim'],
      descricaoAtividade: json['descricaoAtividade'],
      tipoServico: json['tipoServico'],
      isFaturada: json['isFaturada'] ?? false,
      horasTrabalhadas: json['horasTrabalhadas']?.toDouble(),
      statusOs: json['statusOs'],
      
      projeto: Projeto.fromJson(json['projeto']),
      analista: Analista.fromJson(json['analista']),
    );
  }
}
