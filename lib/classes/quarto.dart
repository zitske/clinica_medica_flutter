class Quarto {
  int numero;
  String id;
  String idConsultorio;
  int lotacao;
  String enfermeiraResponsavel;

  Quarto({
    required this.numero,
    required this.id,
    required this.idConsultorio,
    required this.lotacao,
    required this.enfermeiraResponsavel,
  });

  factory Quarto.fromJson(Map<String, dynamic> json) {
    return Quarto(
      numero: json['numero'],
      id: json['id'],
      idConsultorio: json['idConsultorio'],
      lotacao: json['lotacao'],
      enfermeiraResponsavel: json['enfermeiraResponsavel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'id': id,
      'idConsultorio': idConsultorio,
      'lotacao': lotacao,
      'enfermeiraResponsavel': enfermeiraResponsavel,
    };
  }
}
