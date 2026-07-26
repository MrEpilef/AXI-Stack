class Projeto {
  //final int? codigoProjeto;
  //final int codigoCliente;
  String titulo;
  String cliente;
  String status;
  int progresso;

  Projeto({
    //required this.codigoCliente,
    required this.titulo,
    required this.cliente,
    required this.status,
    required this.progresso,
    //this.codigoProjeto,
  });

  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto(
      //codigoCliente: json['codigoCliente'],
      titulo: json['titulo'],
      cliente: json['cliente'],
      status: json['status'],
      progresso: json['progresso'],
      //codigoProjeto: json['codigoProjeto'],
    );
  }
}
