class Projeto {
  final int codigoProjeto;
  final int codigoCliente;
  String titulo;
  String cliente;
  String status;
  int progresso;

  Projeto({
    required this.codigoCliente,
    required this.titulo,
    required this.cliente,
    required this.status,
    required this.progresso,
    required this.codigoProjeto,
  });

  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto(
      codigoCliente: json['codigoCliente'] ?? '1',
      titulo: json['titulo'] ?? 'Sem título',
      cliente: json['cliente'] ?? 'Cliente não informado',
      status: json['status'] ?? 'Pendente',
      progresso: json['progresso'] ?? 0,
      codigoProjeto: json['codigoProjeto'] ?? '1',
    );
  }
}
