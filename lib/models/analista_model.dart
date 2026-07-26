class Analista {
  final int codigoAnalista;
  final String nome;
  final String cargo;
  final String email;
  final String telefone;

  Analista({
    required this.codigoAnalista,
    required this.nome,
    required this.cargo,
    required this.email,
    required this.telefone,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigoAnalista': codigoAnalista,
      'nome': nome,
      'cargo': cargo,
      'email': email,
      'telefone': telefone
    };
  }

  factory Analista.fromJson(Map<String, dynamic> json){
    return Analista(
      codigoAnalista: json['codigoAnalista'],
      nome: json['nome'],
      cargo: json['cargo'],
      email: json['email'],
      telefone: json['telefone'], 
    );
  }
}
