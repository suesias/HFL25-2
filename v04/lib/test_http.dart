import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(Uri.parse('https://httpbin.org/get'));
  print('Statuskod: ${response.statusCode}'); // Borde skriva 200
}