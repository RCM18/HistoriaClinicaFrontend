import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/historia_provider.dart';
import '../widgets/historia_card.dart';
import 'historia_form_page.dart';
import '../../domain/entities/historia.dart';

class HistoriasListPage extends StatefulWidget {
  const HistoriasListPage({Key? key}) : super(key: key);

  @override
  State<HistoriasListPage> createState() => _HistoriasListPageState();
}

class _HistoriasListPageState extends State<HistoriasListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoriaProvider>(context, listen: false).loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HistoriaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Historias Clínicas')),
      body: RefreshIndicator(
        onRefresh: provider.loadAll,
        child: provider.loading
            ? const Center(child: CircularProgressIndicator())
            : provider.error != null
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Error: ${provider.error}'),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (context, i) {
                      final h = provider.items[i];
                      return HistoriaCard(
                        historia: h,
                        onEdit: () async {
                          final updated = await Navigator.push<Historia?>(
                            context,
                            MaterialPageRoute(builder: (_) => HistoriaFormPage(historia: h)),
                          );
                          if (updated != null) {
                            provider.update(updated);
                          }
                        },
                        onDelete: () async {
                          final ok = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Confirmar'),
                                  content: const Text('¿Eliminar historia?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
                                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sí')),
                                  ],
                                ),
                              ) ??
                              false;
                          if (ok && h.id != null) {
                            await provider.delete(h.id!);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado')));
                          }
                        },
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push<Historia?>(
            context,
            MaterialPageRoute(builder: (_) => const HistoriaFormPage()),
          );
          if (created != null) {
            provider.create(created);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
