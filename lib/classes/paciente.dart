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
}
