import 'package:axi_stack/models/cliente_model.dart';

class Projeto {
  final int? codigoProjeto; //feito 1

  final Cliente cliente; //feito 1

  final String nomeProjeto; //feito 1
  final String descricaoEscopo; //feito 3
  final String prioridade; //feito 2
  final String dataInicioPrevista; // feito 2
  final String dataTerminoPrevista; // feito 2

  

  final bool isAtivo;
  final String? dataCriacao;
  final double? orcamentoHoras;
  final String? statusProjeto;

  Projeto({
    this.codigoProjeto,

    required this.nomeProjeto,
    required this.descricaoEscopo,
    required this.prioridade,
    required this.dataInicioPrevista,
    required this.dataTerminoPrevista,
    this.isAtivo = true,
    required this.cliente,

    this.dataCriacao,
    this.orcamentoHoras,
    this.statusProjeto,
  });

  


  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto(
      codigoProjeto: json['codigoProjeto'],
      dataCriacao: json['dataCriacao'],
      orcamentoHoras: json['orcamentoHoras']?.toDouble(),
      statusProjeto: json['statusProjeto'],

      nomeProjeto: json['nomeProjeto'],
      descricaoEscopo: json['descricaoEscopo'],
      prioridade: json['prioridade'],
      dataInicioPrevista: json['dataInicioPrevista'],
      dataTerminoPrevista: json['dataTerminoPrevista'],
      isAtivo: json['isAtivo'] ?? true,

      cliente: Cliente.fromJson(json['cliente']),
    );
  }
}
