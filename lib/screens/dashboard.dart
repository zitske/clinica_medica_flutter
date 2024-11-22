import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: false,
        title: Text(
          'The Simple Clinic | Dashboard',
          style: GoogleFonts.anekOdia(
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
        backgroundColor: Color(0xFFafffe7),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo ao Dashboard!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para outra tela
              },
              child: Text('Ir para outra tela'),
            ),
          ],
        ),
      ),
    );
  }
}
