import 'package:http/http.dart' as http;

var url = Uri.parse('http://localhost:5050/');

Future<void> getReceitas() async {
  try {
    var response = await http.get(url.replace(path: '/receitas'));
    print(response.body);
  } catch (e) {
    print('Erro ao buscar receitas: $e');
  }
}

Future<void> getConsultorios() async {
  try {
    var response = await http.get(url.replace(path: '/consultorios'));
    print(response.body);
  } catch (e) {
    print('Erro ao buscar consultorios: $e');
  }
}

Future<void> getEmpregados() async {
  try {
    var response = await http.get(url.replace(path: '/empregados'));
    print(response.body);
  } catch (e) {
    print('Erro ao buscar empregados: $e');
  }
}

Future<void> inserirPaciente() async {
  try {
    var response = await http.post(
      url.replace(path: '/inserir_paciente'),
      headers: {'Content-Type': 'application/json'},
      body:
          '{"ID": 10, "Nome":"TEste", "Cpf": "02422647006", "Restricoes":"Sem", "quartosID":10}',
    );
    print(response.body);
  } catch (e) {
    print('Erro ao inserir paciente: $e');
  }
}
