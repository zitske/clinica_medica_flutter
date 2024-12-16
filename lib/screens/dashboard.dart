import 'package:clinica_medica_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../classes/paciente.dart';
import '../classes/funcionario.dart';
import '../classes/consulta.dart';
import '../classes/receita.dart';
import '../classes/quarto.dart';
import 'package:clinica_medica_flutter/api/calls.dart';

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
    Funcionario.medica(
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

  final List<Consulta> consultas = [
    Consulta(
      idPaciente: 1,
      idMedico: 2,
      data: DateTime.parse('2023-10-01'),
    ),
    Consulta(
      idPaciente: 2,
      idMedico: 2,
      data: DateTime.parse('2023-10-02'),
    ),
  ];
  final List<Receita> receitas = [];
  final List<Quarto> quartos = [
    Quarto(
      numero: 101,
      id: 1,
      idConsultorio: 1,
      lotacao: 2,
      enfermeiraResponsavel: 'Carlos Pereira',
    ),
    Quarto(
      numero: 102,
      id: 2,
      idConsultorio: 1,
      lotacao: 1,
      enfermeiraResponsavel: 'Carlos Pereira',
    ),
    Quarto(
      numero: 103,
      id: 3,
      idConsultorio: 1,
      lotacao: 3,
      enfermeiraResponsavel: 'Carlos Pereira',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedPacientes = await getPacientes();
    final fetchedFuncionarios = await getEmpregados();
    final fetchedConsultas = await getConsultas();
    final fetchedReceitas = await getReceitas();
    final fetchedQuartos = await getQuartos();

    setState(() {
      pacientes.clear();
      pacientes.addAll(fetchedPacientes);

      funcionarios.clear();
      funcionarios.addAll(fetchedFuncionarios);

      consultas.clear();
      consultas.addAll(fetchedConsultas);

      receitas.clear();
      receitas.addAll(fetchedReceitas);

      quartos.clear();
      quartos.addAll(fetchedQuartos);
    });
  }

  void _showPacienteDialog(BuildContext context, {Paciente? paciente}) {
    final nomeController = TextEditingController(text: paciente?.nome ?? '');
    final cpfController = TextEditingController(text: paciente?.cpf ?? '');
    final restricoesController =
        TextEditingController(text: paciente?.restricoes ?? '');
    int? selectedQuartoId = paciente?.idQuarto;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(paciente == null
                  ? 'Cadastrar Novo Paciente'
                  : 'Editar Paciente'),
              content: SingleChildScrollView(
                child: Column(
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
                    DropdownButton<int>(
                      value: selectedQuartoId,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedQuartoId = newValue;
                        });
                      },
                      items:
                          quartos.map<DropdownMenuItem<int>>((Quarto quarto) {
                        return DropdownMenuItem<int>(
                          value: quarto.id, // Converte o id para inteiro
                          child: Text('Quarto ${quarto.numero}'),
                        );
                      }).toList(),
                      hint: Text('Selecione o Quarto'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (paciente == null) {
                        final novoPaciente = Paciente(
                          id: pacientes.length + 1,
                          nome: nomeController.text,
                          cpf: cpfController.text,
                          restricoes: restricoesController.text,
                          idSecretaria: 1,
                          idQuarto: selectedQuartoId,
                        );
                        pacientes.add(novoPaciente);
                        inserirPaciente(
                            novoPaciente); // Chamada para inserir no banco de dados
                      } else {
                        paciente.nome = nomeController.text;
                        paciente.cpf = cpfController.text;
                        paciente.restricoes = restricoesController.text;
                        paciente.idQuarto = selectedQuartoId;
                      }
                      _atualizarLotacaoQuartos();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(paciente == null ? 'Cadastrar' : 'Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _atualizarLotacaoQuartos() {
    for (var quarto in quartos) {
      quarto.lotacao = pacientes.where((p) => p.idQuarto == quarto.id).length;
    }
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
              content: SingleChildScrollView(
                child: Column(
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

  void _showConsultaDialog(BuildContext context, {Consulta? consulta}) {
    int? selectedPacienteId = consulta?.idPaciente;
    int? selectedMedicoId = consulta?.idMedico;
    final dataController =
        TextEditingController(text: consulta?.data.toString() ?? '');
    final medicamentoController = TextEditingController();

    Future<void> _selectDateTime(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: consulta?.data ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(consulta?.data ?? DateTime.now()),
        );
        if (pickedTime != null) {
          final DateTime pickedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          setState(() {
            dataController.text = pickedDateTime.toIso8601String();
          });
        }
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(consulta == null
                  ? 'Cadastrar Nova Consulta'
                  : 'Editar Consulta'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      value: selectedPacienteId,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedPacienteId = newValue;
                        });
                      },
                      items: pacientes
                          .map<DropdownMenuItem<int>>((Paciente paciente) {
                        return DropdownMenuItem<int>(
                          value: paciente.id,
                          child: Text(paciente.nome),
                        );
                      }).toList(),
                      hint: Text('Selecione o Paciente'),
                    ),
                    DropdownButton<int>(
                      value: selectedMedicoId,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedMedicoId = newValue;
                        });
                      },
                      items: funcionarios
                          .where((funcionario) => funcionario.tipo == 'Medico')
                          .map<DropdownMenuItem<int>>((Funcionario medico) {
                        return DropdownMenuItem<int>(
                          value: medico.id,
                          child: Text(medico.nome),
                        );
                      }).toList(),
                      hint: Text('Selecione o Médico'),
                    ),
                    TextField(
                      controller: dataController,
                      decoration: InputDecoration(
                        labelText: 'Data e Hora',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDateTime(context);
                          },
                        ),
                      ),
                    ),
                    TextField(
                      controller: medicamentoController,
                      decoration: InputDecoration(labelText: 'Medicamento'),
                    ),
                  ],
                ),
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
                    // Lógica para salvar ou editar consulta e receita
                    if (consulta == null) {
                      final novaConsulta = Consulta(
                        idPaciente: selectedPacienteId!,
                        idMedico: selectedMedicoId!,
                        data: DateTime.parse(dataController.text),
                      );
                      setState(() {
                        consultas.add(novaConsulta);
                        receitas.add(Receita(
                          medicamento: medicamentoController.text,
                          consultaId: novaConsulta.idPaciente,
                        ));
                      });
                    } else {
                      // Atualizar consulta existente
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(consulta == null ? 'Cadastrar' : 'Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showQuartoDialog(BuildContext context, {Quarto? quarto}) {
    final numeroController =
        TextEditingController(text: quarto?.numero.toString() ?? '');
    final idController =
        TextEditingController(text: quarto?.id.toString() ?? 0.toString());
    final idConsultorioController = TextEditingController(
        text: quarto?.idConsultorio.toString() ?? 0.toString());
    final lotacaoController =
        TextEditingController(text: quarto?.lotacao.toString() ?? '0');
    String? enfermeiraResponsavel = quarto?.enfermeiraResponsavel;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                  quarto == null ? 'Cadastrar Novo Quarto' : 'Editar Quarto'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: numeroController,
                      decoration: InputDecoration(labelText: 'Número'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: idConsultorioController,
                      decoration: InputDecoration(labelText: 'ID Consultório'),
                      enabled: false,
                    ),
                    DropdownButton<String>(
                      value: enfermeiraResponsavel,
                      onChanged: (String? newValue) {
                        setState(() {
                          enfermeiraResponsavel = newValue;
                        });
                      },
                      items: funcionarios
                          .where(
                              (funcionario) => funcionario.tipo == 'Enfermeiro')
                          .map<DropdownMenuItem<String>>(
                              (Funcionario enfermeiro) {
                        return DropdownMenuItem<String>(
                          value: enfermeiro.nome,
                          child: Text(enfermeiro.nome),
                        );
                      }).toList(),
                      hint: Text('Selecione a Enfermeira Responsável'),
                    ),
                  ],
                ),
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
                    // Lógica para salvar ou editar quarto
                    setState(() {
                      if (quarto == null) {
                        quartos.add(Quarto(
                          numero: int.parse(numeroController.text),
                          id: Random().nextInt(100000),
                          idConsultorio: 10, // Defina o ID do consultório aqui
                          lotacao: 0,
                          enfermeiraResponsavel: enfermeiraResponsavel!,
                        ));
                      } else {
                        quarto.numero = int.parse(numeroController.text);
                        quarto.enfermeiraResponsavel = enfermeiraResponsavel!;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(quarto == null ? 'Cadastrar' : 'Salvar'),
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
      _atualizarLotacaoQuartos();
    });
  }

  void _deleteFuncionario(int index) {
    setState(() {
      funcionarios.removeAt(index);
    });
  }

  void _deleteConsulta(int index) {
    setState(() {
      consultas.removeAt(index);
    });
  }

  void _deleteQuarto(int index) {
    setState(() {
      quartos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
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
          child: Column(
            children: [
              GridView.count(
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
                                            _deleteFuncionario(funcionarios
                                                .indexOf(funcionario));
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
                                'Consultas',
                                style: GoogleFonts.anekOdia(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _showConsultaDialog(context);
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: consultas.map((consulta) {
                              final paciente = pacientes.firstWhere(
                                  (p) => p.id == consulta.idPaciente);
                              final medico = funcionarios
                                  .firstWhere((f) => f.id == consulta.idMedico);
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
                                    title: Text(
                                        'Consulta de ${paciente.nome} com Dr(a). ${medico.nome}'),
                                    subtitle: Text('Data: ${consulta.data}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _showConsultaDialog(context,
                                                consulta: consulta);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteConsulta(
                                                consultas.indexOf(consulta));
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
                                'Quartos',
                                style: GoogleFonts.anekOdia(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _showQuartoDialog(context);
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: quartos.map((quarto) {
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
                                    title: Text('Quarto ${quarto.numero}'),
                                    subtitle: Text(
                                        'ID: ${quarto.id}\nID Consultório: ${quarto.idConsultorio}\nLotação: ${quarto.lotacao}\nEnfermeira Responsável: ${quarto.enfermeiraResponsavel}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _showQuartoDialog(context,
                                                quarto: quarto);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteQuarto(
                                                quartos.indexOf(quarto));
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
            ],
          ),
        ),
      ),
    );
  }
}
