import 'package:flutter/material.dart';
import '../../domain/entities/historia.dart';

class HistoriaCard extends StatelessWidget {
  final Historia historia;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const HistoriaCard({Key? key, required this.historia, this.onEdit, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        title: Text('${historia.diagnostico} — ${historia.pacDni}'),
        subtitle: Text('Med: ${historia.medCmp}\nFecha: ${historia.fechaAtencion.toLocal()}'),
        isThreeLine: true,
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.red)),
        ]),
      ),
    );
  }
}
