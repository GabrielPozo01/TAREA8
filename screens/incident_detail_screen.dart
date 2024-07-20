import 'package:flutter/material.dart';
import 'package:tarea8/models/incident.dart';
import 'dart:io';

class IncidentDetailScreen extends StatelessWidget {
  final Incident incident;

  IncidentDetailScreen({required this.incident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incident.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Fecha: ${incident.date.toString()}'),
            SizedBox(height: 10),
            Text('Descripción: ${incident.description}'),
            SizedBox(height: 10),
            incident.photoPath.isNotEmpty
                ? Image.file(File(incident.photoPath))
                : Container(),
            SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}


