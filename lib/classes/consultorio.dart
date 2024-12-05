class Consultorio {
  String email;
  String senha;
  String nome;
  String cnpj;
  String id;

  Consultorio({
    required this.email,
    required this.senha,
    required this.nome,
    required this.cnpj,
    required this.id,
  });

  factory Consultorio.fromJson(Map<String, dynamic> json) {
    return Consultorio(
      email: json['email'],
      senha: json['senha'],
      nome: json['nome'],
      cnpj: json['cnpj'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'senha': senha,
      'nome': nome,
      'cnpj': cnpj,
      'id': id,
    };
  }
}
