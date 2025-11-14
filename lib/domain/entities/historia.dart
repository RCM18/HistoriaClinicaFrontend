import '../../data/models/historia_model.dart';

class Historia {
  final int? id;
  final String pacDni;
  final String medCmp;
  final DateTime fechaAtencion;
  final String diagnostico;
  final String analisis;
  final String tratamiento;

  Historia({
    this.id,
    required this.pacDni,
    required this.medCmp,
    required this.fechaAtencion,
    required this.diagnostico,
    required this.analisis,
    required this.tratamiento,
  });

  factory Historia.fromModel(HistoriaModel m) {
    return Historia(
      id: m.id,
      pacDni: m.pacDni,
      medCmp: m.medCmp,
      fechaAtencion: m.fechaAtencion,
      diagnostico: m.diagnostico,
      analisis: m.analisis,
      tratamiento: m.tratamiento,
    );
  }
}
