import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/paciente.dart';

class DashboardScreen extends StatelessWidget {
  final List<Paciente> pacientes = [
    Paciente(
        id: 1,
        nome: 'João Silva',
        cpf: '123.456.789-00',
        restricoes: 'Nenhuma',
        idSecretaria: 1),
    Paciente(
        id: 2,
        nome: 'Maria Souza',
        cpf: '987.654.321-00',
        restricoes: 'Alergia a penicilina',
        idSecretaria: 2),
  ];

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
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Cadastrar Novo Paciente',
                        style: TextStyle(fontSize: 20)),
                    TextField(
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'CPF'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Restrições'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para cadastrar paciente
                      },
                      child: Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  final paciente = pacientes[index];
                  return Card(
                    child: ListTile(
                      title: Text(paciente.nome),
                      subtitle: Text(
                          'CPF: ${paciente.cpf}\nRestrições: ${paciente.restricoes}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
