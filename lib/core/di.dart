import 'package:get_it/get_it.dart';
import '../data/datasources/api_client.dart';
import '../data/repositories/historia_repository_impl.dart';
import '../domain/repositories/historia_repository.dart';

final getIt = GetIt.instance;

void setupDI({required String baseUrl}) {
  // Register API client
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl));

  // Repositories
  getIt.registerLazySingleton<HistoriaRepository>(
      () => HistoriaRepositoryImpl(getIt<ApiClient>()));
}
