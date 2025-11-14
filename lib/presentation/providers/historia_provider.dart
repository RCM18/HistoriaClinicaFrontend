import 'package:flutter/foundation.dart';
import '../../domain/entities/historia.dart';
import '../../domain/repositories/historia_repository.dart';

class HistoriaProvider with ChangeNotifier {
  final HistoriaRepository repository;

  HistoriaProvider(this.repository);

  List<Historia> _items = [];
  bool _loading = false;
  String? _error;

  List<Historia> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadAll() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _items = await repository.getAll();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(Historia h) async {
    try {
      final created = await repository.create(h);
      _items.add(created);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> update(Historia h) async {
    try {
      final updated = await repository.update(h);
      final idx = _items.indexWhere((e) => e.id == updated.id);
      if (idx != -1) _items[idx] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      await repository.delete(id);
      _items.removeWhere((e) => e.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
