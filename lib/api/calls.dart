import 'package:http/http.dart' as http;
import 'dart:convert';
import '../classes/consulta.dart';
import '../classes/paciente.dart';
import '../classes/funcionario.dart';
import '../classes/consultorio.dart';
import '../classes/quarto.dart';
import '../classes/receita.dart';

var url = Uri.parse('http://localhost:5050/');

Future<List<Receita>> getReceitas() async {
  try {
    var response = await http.get(url.replace(path: '/receitas'));
    print(
        'Endpoint /receitas - Response body: ${response.body}'); // Debug print
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => Receita.fromJson(json))
          .toList()
          .cast<Receita>();
    } else {
      throw Exception('Erro ao buscar receitas: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao buscar receitas: $e');
    return [];
  }
}

Future<List<Consultorio>> getConsultorios() async {
  try {
    var response = await http.get(url.replace(path: '/consultorios'));
    print(
        'Endpoint /consultorios - Response body: ${response.body}'); // Debug print
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => Consultorio.fromJson(json))
          .toList()
          .cast<Consultorio>();
    } else {
      throw Exception('Erro ao buscar consultorios: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao buscar consultorios: $e');
    return [];
  }
}

Future<List<Funcionario>> getEmpregados() async {
  try {
    var response = await http.get(url.replace(path: '/empregados'));
    print(
        'Endpoint /empregados - Response body: ${response.body}'); // Debug print
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => Funcionario.fromJson(json))
          .toList()
          .cast<Funcionario>();
    } else {
      throw Exception('Erro ao buscar empregados: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao buscar empregados: $e');
    return [];
  }
}

Future<void> inserirPaciente(Paciente paciente) async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_paciente'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(paciente.toJson()),
    );
    print(
        'Endpoint /inserir_paciente - Response body: ${response.body}'); // Debug print
    print(response.body);
  } catch (e) {
    print('Erro ao inserir paciente: $e');
  }
}

Future<void> inserirPacienteComDetalhes(List<dynamic> paciente) async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_paciente'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ID": paciente[0],
        "Nome": paciente[1],
        "Cpf": paciente[2],
        "Restricoes": paciente[3],
        "quartosID": paciente[4]
      }),
    );
    print(
        'Endpoint /inserir_paciente - Response body: ${response.body}'); // Debug print
    print(response.body);
  } catch (e) {
    print('Erro ao inserir paciente: $e');
  }
}

Future<List<Paciente>> getPacientes() async {
  try {
    var response = await http.get(url.replace(path: '/pacientes'));
    print(
        'Endpoint /pacientes - Response body: ${response.body}'); // Debug print
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => Paciente.fromJson(json))
          .toList()
          .cast<Paciente>();
    } else {
      throw Exception('Erro ao buscar pacientes: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao buscar pacientes: $e');
    return [];
  }
}

Future<List<Consulta>> getConsultas() async {
  try {
    var response = await http.get(url.replace(path: '/consultas'));
    print(
        'Endpoint /consultas - Response body: ${response.body}'); // Debug print
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => Consulta.fromJson(json))
          .toList()
          .cast<Consulta>();
    } else {
      throw Exception('Erro ao buscar consultas: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao buscar consultas: $e');
    return [];
  }
}

Future<List<Quarto>> getQuartos() async {
  try {
    var response = await http.get(url.replace(path: '/quartos'));
    print('Endpoint /quartos - Response body: ${response.body}'); // Debug print
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Quarto.fromJson(json)).toList().cast<Quarto>();
    } else {
      throw Exception('Erro ao buscar quartos: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao buscar quartos: $e');
    return [];
  }
}

Future<void> inserirConsultorio(Consultorio consultorio) async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_consultorio'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(consultorio.toJson()),
    );
    print('Endpoint /inserir_consultorio - Response body: ${response.body}');
  } catch (e) {
    print('Erro ao inserir consultório: $e');
  }
}

Future<void> inserirConsulta(Consulta consulta) async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_consulta'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(consulta.toJson()),
    );
    print('Endpoint /inserir_consulta - Response body: ${response.body}');
  } catch (e) {
    print('Erro ao inserir consulta: $e');
  }
}

Future<void> inserirQuarto(Quarto quarto) async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_quarto'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(quarto.toJson()),
    );
    print('Endpoint /inserir_quarto - Response body: ${response.body}');
  } catch (e) {
    print('Erro ao inserir quarto: $e');
  }
}

Future<void> inserirFuncionario(Funcionario funcionario) async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_funcionario'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(funcionario.toJson()),
    );
    print('Endpoint /inserir_funcionario - Response body: ${response.body}');
  } catch (e) {
    print('Erro ao inserir funcionário: $e');
  }
}
