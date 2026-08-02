import 'package:axi_stack/models/analista_model.dart';
import 'package:axi_stack/models/projeto_model.dart';

class OrdemServicoModel {
  

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

  OrdemServicoModel({
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
    required this.analista});

}