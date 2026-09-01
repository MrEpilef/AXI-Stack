import 'package:axi_stack/models/cliente_model.dart';

class Projeto {
  final int? codigoProjeto;

  final Cliente cliente;

  final String nomeProjeto;
  final String descricaoEscopo;
  final String prioridade;
  final String dataInicioPrevista;
  final String dataTerminoPrevista;
  //final bool isSlaCritico; 
  
  
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
    //this.isSlaCritico = false,
    this.isAtivo = true,
    required this.cliente,

    this.dataCriacao,
    this.orcamentoHoras,
    this.statusProjeto,
  });

  Map<String, dynamic> toJson(){
    return {
      'codigoProjeto' :codigoProjeto,
      'nomeProjeto' : nomeProjeto,
      'descricaoEscopo' : descricaoEscopo,
      'prioridade' : prioridade,
      'dataInicioPrevista' : dataInicioPrevista,
      'dataTerminoPrevista' : dataTerminoPrevista,
      //'isSlaCritico': isSlaCritico,
      'isAtivo' : isAtivo,
      'cliente' : cliente.toJson(),
      'dataCriacao' : dataCriacao,
      'orcamentoHoras' : orcamentoHoras,
      'statusProjeto' : statusProjeto,
    };
  }


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
      //isSlaCritico: json['isAtivo'] ?? false,

      cliente: Cliente.fromJson(json['isSlaCritico']),
    );
  }
}
