import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarea8/models/incident.dart';
import 'package:tarea8/utils/database_helper.dart';
import 'dart:io';

class AddIncidentScreen extends StatefulWidget {
  @override
  _AddIncidentScreenState createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title, _description, _photoPath, _audioPath;
  DateTime? _date;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Incidencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                onSaved: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _selectDate,
                child: Text('Seleccionar Fecha'),
              ),
              ElevatedButton(
                onPressed: _selectPhoto,
                child: Text('Seleccionar Foto'),
              ),
              
              ElevatedButton(
                onPressed: _saveIncident,
                child: Text('Guardar Incidencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photoPath = pickedFile.path;
      });
    }
  }

  void _saveIncident() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (_title != null && _date != null && _description != null && _photoPath != null && _audioPath != null) {
        Incident newIncident = Incident(
          title: _title!,
          date: _date!,
          description: _description!,
          photoPath: _photoPath!,
          audioPath: _audioPath!,
        );
        DatabaseHelper.instance.insertIncident(newIncident);
        Navigator.pop(context);
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor complete todos los campos')),
        );
      }
    }
  }
}


