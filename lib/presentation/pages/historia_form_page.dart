import 'package:flutter/material.dart';
import '../../domain/entities/historia.dart';

class HistoriaFormPage extends StatefulWidget {
  final Historia? historia;
  const HistoriaFormPage({Key? key, this.historia}) : super(key: key);

  @override
  State<HistoriaFormPage> createState() => _HistoriaFormPageState();
}

class _HistoriaFormPageState extends State<HistoriaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController pacDniCtrl;
  late TextEditingController medCmpCtrl;
  late TextEditingController diagnosticoCtrl;
  late TextEditingController analisisCtrl;
  late TextEditingController tratamientoCtrl;
  DateTime fecha = DateTime.now();

  @override
  void initState() {
    super.initState();
    final h = widget.historia;
    pacDniCtrl = TextEditingController(text: h?.pacDni ?? '');
    medCmpCtrl = TextEditingController(text: h?.medCmp ?? '');
    diagnosticoCtrl = TextEditingController(text: h?.diagnostico ?? '');
    analisisCtrl = TextEditingController(text: h?.analisis ?? '');
    tratamientoCtrl = TextEditingController(text: h?.tratamiento ?? '');
    fecha = h?.fechaAtencion ?? DateTime.now();
  }

  @override
  void dispose() {
    pacDniCtrl.dispose();
    medCmpCtrl.dispose();
    diagnosticoCtrl.dispose();
    analisisCtrl.dispose();
    tratamientoCtrl.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) {
      final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(fecha));
      if (t != null) {
        setState(() {
          fecha = DateTime(d.year, d.month, d.day, t.hour, t.minute);
        });
      } else {
        setState(() {
          fecha = DateTime(d.year, d.month, d.day, fecha.hour, fecha.minute);
        });
      }
    }
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;
    final h = Historia(
      id: widget.historia?.id,
      pacDni: pacDniCtrl.text.trim(),
      medCmp: medCmpCtrl.text.trim(),
      fechaAtencion: fecha,
      diagnostico: diagnosticoCtrl.text.trim(),
      analisis: analisisCtrl.text.trim(),
      tratamiento: tratamientoCtrl.text.trim(),
    );
    Navigator.pop(context, h);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.historia != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Historia' : 'Nueva Historia')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: pacDniCtrl,
                decoration: const InputDecoration(labelText: 'PAC_DNI'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'DNI requerido' : null,
              ),
              TextFormField(
                controller: medCmpCtrl,
                decoration: const InputDecoration(labelText: 'MED_CMP'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'CMP requerido' : null,
              ),
              const SizedBox(height: 8),
              ListTile(
                title: Text('Fecha: ${fecha.toLocal()}'),
                trailing: IconButton(icon: const Icon(Icons.calendar_today), onPressed: pickDate),
              ),
              TextFormField(
                controller: diagnosticoCtrl,
                decoration: const InputDecoration(labelText: 'Diagnóstico'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Diagnóstico requerido' : null,
              ),
              TextFormField(
                controller: analisisCtrl,
                decoration: const InputDecoration(labelText: 'Análisis'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Análisis requerido' : null,
              ),
              TextFormField(
                controller: tratamientoCtrl,
                decoration: const InputDecoration(labelText: 'Tratamiento'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Tratamiento requerido' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: submit, child: Text(isEditing ? 'Guardar' : 'Crear')),
            ],
          ),
        ),
      ),
    );
  }
}
