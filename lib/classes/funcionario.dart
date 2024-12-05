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
  })  : tipo = 'Secretario',
        coren = null,
        especialidade = null,
        crm = null,
        idConsultorio = null;

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    switch (json['tipo']) {
      case 'Enfermeiro':
        return Funcionario.enfermeiro(
          id: json['id'],
          cpf: json['cpf'],
          nome: json['nome'],
          coren: json['coren'],
        );
      case 'Medico':
        return Funcionario.medico(
          id: json['id'],
          cpf: json['cpf'],
          nome: json['nome'],
          especialidade: json['especialidade'],
          crm: json['crm'],
        );
      case 'Secretario':
        return Funcionario.secretario(
          id: json['id'],
          cpf: json['cpf'],
          nome: json['nome'],
        );
      default:
        throw Exception('Tipo de funcionário desconhecido');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'nome': nome,
      'tipo': tipo,
      'coren': coren,
      'especialidade': especialidade,
      'crm': crm,
      'idConsultorio': idConsultorio,
    };
  }

  Funcionario._({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.tipo,
    this.coren,
    this.especialidade,
    this.crm,
    this.idConsultorio,
  });
}
