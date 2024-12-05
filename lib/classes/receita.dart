class Receita {
  final String medicamento;
  final int consultaId;

  Receita({required this.medicamento, required this.consultaId});

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      medicamento: json['medicamento'],
      consultaId: json['consultaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicamento': medicamento,
      'consultaId': consultaId,
    };
  }
}
