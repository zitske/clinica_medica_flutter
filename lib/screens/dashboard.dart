import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/paciente.dart';
import '../classes/funcionario.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

  final List<Funcionario> funcionarios = [];

  void _showPacienteDialog(BuildContext context, {Paciente? paciente}) {
    final nomeController = TextEditingController(text: paciente?.nome ?? '');
    final cpfController = TextEditingController(text: paciente?.cpf ?? '');
    final restricoesController =
        TextEditingController(text: paciente?.restricoes ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              paciente == null ? 'Cadastrar Novo Paciente' : 'Editar Paciente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
              ),
              TextField(
                controller: restricoesController,
                decoration: InputDecoration(labelText: 'Restrições'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar ou editar paciente
                Navigator.of(context).pop();
              },
              child: Text(paciente == null ? 'Cadastrar' : 'Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showFuncionarioDialog(BuildContext context,
      {Funcionario? funcionario}) {
    final nomeController = TextEditingController(text: funcionario?.nome ?? '');
    final cpfController = TextEditingController(text: funcionario?.cpf ?? '');
    String tipo = funcionario?.tipo ?? 'Secretario';
    final corenController =
        TextEditingController(text: funcionario?.coren ?? '');
    final especialidadeController =
        TextEditingController(text: funcionario?.especialidade ?? '');
    final crmController = TextEditingController(text: funcionario?.crm ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(funcionario == null
                  ? 'Cadastrar Novo Funcionário'
                  : 'Editar Funcionário'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  TextField(
                    controller: cpfController,
                    decoration: InputDecoration(labelText: 'CPF'),
                  ),
                  DropdownButton<String>(
                    value: tipo,
                    onChanged: (String? newValue) {
                      setState(() {
                        tipo = newValue!;
                      });
                    },
                    items: <String>['Secretario', 'Medico', 'Enfermeiro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  if (tipo == 'Enfermeiro')
                    TextField(
                      controller: corenController,
                      decoration: InputDecoration(labelText: 'COREN'),
                    ),
                  if (tipo == 'Medico')
                    TextField(
                      controller: especialidadeController,
                      decoration: InputDecoration(labelText: 'Especialidade'),
                    ),
                  if (tipo == 'Medico')
                    TextField(
                      controller: crmController,
                      decoration: InputDecoration(labelText: 'CRM'),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar ou editar funcionário
                    Navigator.of(context).pop();
                  },
                  child: Text(funcionario == null ? 'Cadastrar' : 'Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deletePaciente(int index) {
    setState(() {
      pacientes.removeAt(index);
    });
  }

  void _deleteFuncionario(int index) {
    setState(() {
      funcionarios.removeAt(index);
    });
  }

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
            ElevatedButton(
              onPressed: () {
                _showPacienteDialog(context);
              },
              child: Text('Cadastrar Novo Paciente'),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showPacienteDialog(context, paciente: paciente);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletePaciente(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showFuncionarioDialog(context);
              },
              child: Text('Cadastrar Novo Funcionário'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: funcionarios.length,
                itemBuilder: (context, index) {
                  final funcionario = funcionarios[index];
                  return Card(
                    child: ListTile(
                      title: Text(funcionario.nome),
                      subtitle: Text(
                          'CPF: ${funcionario.cpf}\nTipo: ${funcionario.tipo}\nCOREN: ${funcionario.coren}\nEspecialidade: ${funcionario.especialidade}\nCRM: ${funcionario.crm}\nID Consultório: ${funcionario.idConsultorio}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showFuncionarioDialog(context,
                                  funcionario: funcionario);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteFuncionario(index);
                            },
                          ),
                        ],
                      ),
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
