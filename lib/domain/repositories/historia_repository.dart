import '../entities/historia.dart';

abstract class HistoriaRepository {
  Future<List<Historia>> getAll();
  Future<Historia> create(Historia historia);
  Future<Historia> update(Historia historia);
  Future<void> delete(int id);
}
