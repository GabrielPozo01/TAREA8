import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/officer_photo.jpg'),
            ),
            SizedBox(height: 10),
            Text('Nombre: John Doe'),
            Text('Apellido: Doe'),
            Text('Matrícula: 123456'),
            SizedBox(height: 10),
            Text(
              'Reflexión: La vigilancia es la madre de la seguridad.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  

}

