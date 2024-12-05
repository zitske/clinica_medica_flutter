class Paciente {
  int id;
  String nome;
  String cpf;
  String restricoes;
  int idSecretaria;
  int? idQuarto;

  Paciente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.restricoes,
    required this.idSecretaria,
    this.idQuarto,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Nome': nome,
      'Cpf': cpf,
      'Restricoes': restricoes,
      'idSecretaria': idSecretaria,
      'quartosID': idQuarto,
    };
  }

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['ID'] ?? 0,
      nome: json['Nome'] ?? '',
      cpf: json['Cpf'] ?? '',
      restricoes: json['Restricoes'] ?? '',
      idSecretaria: json['idSecretaria'] ?? 0,
      idQuarto: json['quartosID'],
    );
  }
}
