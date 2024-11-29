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

  final List<Funcionario> funcionarios = [
    Funcionario.enfermeiro(
      id: 1,
      cpf: '111.222.333-44',
      nome: 'Carlos Pereira',
      coren: 'COREN12345',
    ),
    Funcionario.medico(
      id: 2,
      cpf: '555.666.777-88',
      nome: 'Ana Martins',
      especialidade: 'Cardiologia',
      crm: 'CRM67890',
    ),
    Funcionario.secretario(
      id: 3,
      cpf: '999.000.111-22',
      nome: 'Fernanda Lima',
    ),
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pacientes',
                            style: GoogleFonts.anekOdia(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _showPacienteDialog(context);
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: pacientes.map((paciente) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                        _showPacienteDialog(context,
                                            paciente: paciente);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deletePaciente(
                                            pacientes.indexOf(paciente));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Funcionários',
                            style: GoogleFonts.anekOdia(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _showFuncionarioDialog(context);
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: funcionarios.map((funcionario) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                        _deleteFuncionario(
                                            funcionarios.indexOf(funcionario));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
