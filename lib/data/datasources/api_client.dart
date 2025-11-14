import 'package:dio/dio.dart';
import '../models/historia_model.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ));

  Future<List<HistoriaModel>> fetchHistorias() async {
    final res = await _dio.get('/historias');
    final List data = res.data as List;
    return data.map((e) => HistoriaModel.fromJson(e)).toList();
  }

  Future<HistoriaModel> getHistoria(int id) async {
    final res = await _dio.get('/historias/$id');
    return HistoriaModel.fromJson(res.data);
  }

  Future<HistoriaModel> createHistoria(HistoriaModel model) async {
    final res = await _dio.post('/historias', data: model.toJson());
    return HistoriaModel.fromJson(res.data);
  }

  Future<HistoriaModel> updateHistoria(int id, HistoriaModel model) async {
    final res = await _dio.put('/historias/$id', data: model.toJson());
    return HistoriaModel.fromJson(res.data);
  }

  Future<void> deleteHistoria(int id) async {
    await _dio.delete('/historias/$id');
  }
}
