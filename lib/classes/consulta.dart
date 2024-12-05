class Consulta {
  final int idPaciente;
  final int idMedico;
  final DateTime data;

  Consulta({
    required this.idPaciente,
    required this.idMedico,
    required this.data,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      idPaciente: json['idPaciente'] ?? 0,
      idMedico: json['idMedico'] ?? 0,
      data: DateTime.parse(json['data'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPaciente': idPaciente,
      'idMedico': idMedico,
      'data': data.toIso8601String(),
    };
  }
}
