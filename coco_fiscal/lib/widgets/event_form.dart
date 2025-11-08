import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventForm extends StatefulWidget {
  final DateTime selectedDate;
  final List<Map<String, dynamic>> eventos;

  EventForm({required this.selectedDate, this.eventos = const []});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _tituloController = TextEditingController();
  final _horaInicioController = TextEditingController();
  final _horaCierreController = TextEditingController();
  final _recordatorioController = TextEditingController();
  final _descripcionController = TextEditingController();
  String _categoriaSeleccionada = "Categoría 1";

  Future<void> guardarEvento() async {
    final evento = {
      "titulo": _tituloController.text,
      "fecha": widget.selectedDate.toIso8601String().split("T")[0],
      "hora_inicio": _horaInicioController.text,
      "hora_cierre": _horaCierreController.text,
      "recordatorio": _recordatorioController.text,
      "descripcion": _descripcionController.text,
      "categoria": _categoriaSeleccionada
    };

    final url = Uri.parse("http://10.0.2.2:81/api_agenda/insert_event.php");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(evento),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      print("Error al guardar: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nuevo Evento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(controller: _tituloController, decoration: InputDecoration(labelText: "Título")),
            SizedBox(height: 10),
            Text("Fecha: ${widget.selectedDate.toLocal().toString().split(' ')[0]}"),
            Row(
              children: [
                Expanded(child: TextField(controller: _horaInicioController, decoration: InputDecoration(labelText: "Hora de Inicio"))),
                SizedBox(width: 10),
                Expanded(child: TextField(controller: _horaCierreController, decoration: InputDecoration(labelText: "Hora de Cierre"))),
              ],
            ),
            SizedBox(height: 10),
            TextField(controller: _recordatorioController, decoration: InputDecoration(labelText: "Recordatorio")),
            SizedBox(height: 10),
            TextField(controller: _descripcionController, decoration: InputDecoration(labelText: "Descripción")),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _categoriaSeleccionada,
              decoration: InputDecoration(labelText: "Categoría"),
              items: ["Categoría 1", "Categoría 2", "Categoría 3"]
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _categoriaSeleccionada = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardarEvento,
              child: Text("Crear nuevo evento"),
            ),
            SizedBox(height: 30),
            if (widget.eventos.isNotEmpty)
              Text("Eventos guardados:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...widget.eventos.map((e) => Card(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(e['titulo']),
                subtitle: Text("${e['hora_inicio']} - ${e['hora_cierre']}\n${e['descripcion']}"),
                trailing: Text(e['categoria']),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
