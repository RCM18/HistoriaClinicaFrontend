
class HistoriaModel {
  final int? id;
  final String pacDni;
  final String medCmp;
  final DateTime fechaAtencion;
  final String diagnostico;
  final String analisis;
  final String tratamiento;

  HistoriaModel({
    this.id,
    required this.pacDni,
    required this.medCmp,
    required this.fechaAtencion,
    required this.diagnostico,
    required this.analisis,
    required this.tratamiento,
  });

  factory HistoriaModel.fromJson(Map<String, dynamic> json) {
    return HistoriaModel(
      id: json['id'] is int ? json['id'] : (json['id'] == null ? null : int.parse(json['id'].toString())),
      pacDni: json['pacDni'] ?? '',
      medCmp: json['medCmp'] ?? '',
      fechaAtencion: DateTime.parse(json['fechaAtencion']),
      diagnostico: json['diagnostico'] ?? '',
      analisis: json['analisis'] ?? '',
      tratamiento: json['tratamiento'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'pacDni': pacDni,
      'medCmp': medCmp,
      'fechaAtencion': fechaAtencion.toIso8601String(),
      'diagnostico': diagnostico,
      'analisis': analisis,
      'tratamiento': tratamiento,
    };
  }
}
