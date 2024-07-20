import 'package:flutter/material.dart';
import 'package:tarea8/models/incident.dart';
import 'package:tarea8/screens/add_incident_screen.dart';
import 'package:tarea8/screens/incident_list_screen.dart';
import 'package:tarea8/screens/incident_detail_screen.dart';
import 'package:tarea8/utils/database_helper.dart';  

void main() {
  initializeDatabase(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Incidencias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IncidentListScreen(),  
      routes: {
        '/add': (context) => AddIncidentScreen(),  
        '/details': (context) {
          final Incident incident = ModalRoute.of(context)!.settings.arguments as Incident;
          return IncidentDetailScreen(incident: incident); 
        },
      },
    );
  }
}



