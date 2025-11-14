import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di.dart' as di;
import 'core/constants.dart';
import 'domain/repositories/historia_repository.dart';
import 'presentation/providers/historia_provider.dart';
import 'presentation/pages/historias_list_page.dart';

void main() {
  // Selecciona la baseUrl adecuada: para Android emulator (AVD) usar 10.0.2.2
  di.setupDI(baseUrl: Constants.baseUrlAndroidEmulator);

  // Registra manualmente provider con repository desde get_it
  final repo = di.getIt<HistoriaRepository>();

  runApp(MyApp(repository: repo));
}

class MyApp extends StatelessWidget {
  final HistoriaRepository repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoriaProvider(repository)),
      ],
      child: MaterialApp(
        title: 'Historias Clínicas',
        theme: ThemeData(colorScheme: colorScheme, useMaterial3: true),
        home: const HistoriasListPage(),
      ),
    );
  }
}
