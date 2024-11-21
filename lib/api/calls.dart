import 'package:http/http.dart' as http;

var url = Uri.parse('http://localhost:5050/cursos');
Future<void> getUnits() async {
  try {
    var response = await http.get(url);
    print(response.body);
  } catch (e) {
    print('Erro ao buscar dados: $e');
  }
}
