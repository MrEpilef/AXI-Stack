class Cliente {
  final int codigoCliente;
  final String razaoSocial;
  final String cnpj;
  final String endereco;
  final String cidade;
  final String uf;
  final String contato;
  final String telefone;
  final String email;

  Cliente({
    required this.codigoCliente,
    required this.razaoSocial,
    required this.cnpj,
    required this.endereco,
    required this.cidade,
    required this.uf,
    required this.contato,
    required this.telefone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigoCliente': codigoCliente,
      'razaoSocial': razaoSocial,
      'cnpj': cnpj,
      'endereco': endereco,
      'cidade': cidade,
      'uf': uf,
      'contato': contato,
      'telefone': telefone,
      'email': email,
    };
  }

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      codigoCliente: json['codigoCliente'],
      razaoSocial: json['razaoSocial'],
      cnpj: json['cnpj'],
      endereco: json['endereco'],
      cidade: json['cidade'],
      uf: json['uf'],
      contato: json['contato'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
}
