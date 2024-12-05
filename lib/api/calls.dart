import 'package:http/http.dart' as http;
import 'dart:convert';
import '../classes/paciente.dart';
import '../classes/funcionario.dart';
import '../classes/consultorio.dart';
import '../classes/receita.dart';

var url = Uri.parse('http://localhost:5050/');

Future<List<Receita>> getReceitas() async {
  try {
    var response = await http.get(url.replace(path: '/receitas'));
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
    print(response.body);
  } catch (e) {
    print('Erro ao inserir paciente: $e');
  }
}
