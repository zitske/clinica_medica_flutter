class Funcionario {
  int id;
  String cpf;
  String nome;
  String tipo;
  String? coren;
  String? especialidade;
  String? crm;
  int? idConsultorio;

  Funcionario.enfermeiro({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.coren,
  })  : tipo = 'Enfermeiro',
        especialidade = null,
        crm = null,
        idConsultorio = null;

  Funcionario.medico({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.especialidade,
    required this.crm,
  })  : tipo = 'Medico',
        coren = null,
        idConsultorio = null;

  Funcionario.secretario({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.idConsultorio,
  })  : tipo = 'Secretario',
        coren = null,
        especialidade = null,
        crm = null;
}
