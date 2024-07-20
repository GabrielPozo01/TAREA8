import 'package:flutter/material.dart';
import 'package:tarea8/models/incident.dart';
import 'package:tarea8/utils/database_helper.dart';
import 'package:tarea8/screens/incident_detail_screen.dart';  
import 'dart:io';

class IncidentListScreen extends StatefulWidget {
  @override
  _IncidentListScreenState createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incidencias Registradas'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteAllIncidents,
          ),
        ],
      ),
      body: FutureBuilder<List<Incident>>(
        future: DatabaseHelper.instance.incidents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final incidents = snapshot.data;

            if (incidents == null || incidents.isEmpty) {
              return Center(child: Text('No hay incidencias registradas.'));
            } else {
              return ListView.builder(
                itemCount: incidents.length,
                itemBuilder: (context, index) {
                  final incident = incidents[index];
                  return ListTile(
                    title: Text(incident.title),
                    subtitle: Text(incident.date.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncidentDetailScreen(incident: incident),
                        ),
                      );
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  void _deleteAllIncidents() async {
    await DatabaseHelper.instance.deleteAllIncidents();
    setState(() {});
  }
}



