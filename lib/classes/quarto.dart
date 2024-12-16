class Quarto {
  int numero;
  int id;
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
      numero: json['numero'] ?? 0,
      id: json['id'] ?? 0,
      idConsultorio: json['idConsultorio']?.toString() ?? "",
      lotacao: json['lotacao'] ?? 0,
      enfermeiraResponsavel: json['enfermeiraResponsavel'] ?? '',
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
