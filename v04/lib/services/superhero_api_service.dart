import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';
import 'package:v04/models/hero_model.dart';

class SuperheroApiService {
  final String _baseUrl = 'https://superheroapi.com/api';
  late final String _apiKey;

  SuperheroApiService() {
    // Ladda .env-filen
    final env = DotEnv();
    env.load(['.env']); // Läs in .env
    _apiKey = env['SUPERHERO_API_KEY'] ?? '';
    
    if (_apiKey.isEmpty) {
      throw Exception('API-nyckel saknas! Lägg till SUPERHERO_API_KEY i .env');
    }
  }

  /// Sök efter hjältar med namn
  Future<List<HeroModel>> searchHeroes(String name) async {
    final url = Uri.parse('$_baseUrl/$_apiKey/search/$name');
    
    print('Skickar förfrågan till: $url'); // Felsökning

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Kolla om API:et svarade med "error"
      if (jsonData['response'] == 'error') {
        print('API-fel: ${jsonData['error']}');
        return [];
      }

      // Hämta listan med resultat
      final List<dynamic> results = jsonData['results'] ?? [];

      // Konvertera varje resultat till HeroModel
      return results.map((json) => HeroModel.fromJson(json)).toList();
    } else {
      throw Exception('Kunde inte hämta data. Status: ${response.statusCode}');
    }
  }
}