import '../../domain/entities/historia.dart';
import '../../domain/repositories/historia_repository.dart';
import '../datasources/api_client.dart';
import '../models/historia_model.dart';

class HistoriaRepositoryImpl implements HistoriaRepository {
  final ApiClient apiClient;
  HistoriaRepositoryImpl(this.apiClient);

  @override
  Future<List<Historia>> getAll() async {
    final models = await apiClient.fetchHistorias();
    return models.map((m) => Historia.fromModel(m)).toList();
  }

  @override
  Future<Historia> create(Historia historia) async {
    final model = HistoriaModel(
      id: null,
      pacDni: historia.pacDni,
      medCmp: historia.medCmp,
      fechaAtencion: historia.fechaAtencion,
      diagnostico: historia.diagnostico,
      analisis: historia.analisis,
      tratamiento: historia.tratamiento,
    );
    final created = await apiClient.createHistoria(model);
    return Historia.fromModel(created);
  }

  @override
  Future<Historia> update(Historia historia) async {
    if (historia.id == null) throw Exception('Historia sin id para actualizar');
    final model = HistoriaModel(
      id: historia.id,
      pacDni: historia.pacDni,
      medCmp: historia.medCmp,
      fechaAtencion: historia.fechaAtencion,
      diagnostico: historia.diagnostico,
      analisis: historia.analisis,
      tratamiento: historia.tratamiento,
    );
    final updated = await apiClient.updateHistoria(historia.id!, model);
    return Historia.fromModel(updated);
  }

  @override
  Future<void> delete(int id) async {
    await apiClient.deleteHistoria(id);
  }
}
