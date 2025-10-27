// lib/managers/hero_data_manager.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v04/config/env.dart';
import 'package:v04/models/hero_model.dart';

abstract class HeroDataManaging {
  Future<void> saveHero(HeroModel hero);
  Future<List<HeroModel>> getHeroList();
  Future<List<HeroModel>> searchHero(String query);
}

class HeroDataManager implements HeroDataManaging {
  static final HeroDataManager _instance = HeroDataManager._internal();
  factory HeroDataManager() => _instance;
  HeroDataManager._internal() {
    Env.load();
    print('Laddar .env i HeroDataManager...');
    print('API-nyckel: ${Env.superheroApiKey}');
  }

  final List<HeroModel> _heroes = [];

  @override
  List<HeroModel> get heroes => List.unmodifiable(_heroes);

  Future<HeroModel?> fetchHeroFromApi(String heroName) async {
    final apiKey = Env.superheroApiKey;
    if (apiKey.isEmpty) {
      print('Fel: Ingen API-nyckel hittades i .env');
      return null;
    }

    final url = Uri.parse('https://superheroapi.com/api/$apiKey/search/$heroName');
    print('Skickar anrop till: $url');

    try {
      final response = await http.get(url);
      print('Svarsstatus: ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('JSON-data: $jsonData');
        final results = jsonData['results'] as List<dynamic>?;

        if (results != null && results.isNotEmpty) {
          final heroJson = results.first as Map<String, dynamic>;
          final hero = HeroModel.fromJson(heroJson);
          await saveHero(hero);
          return hero;
        } else {
          print('Ingen hjälte hittad för "$heroName"');
          return null;
        }
      } else {
        print('API-fel: Statuskod ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Nätverksfel: $e');
      return null;
    }
  }

  @override
  Future<void> saveHero(HeroModel hero) async {
    await Future.delayed(Duration(milliseconds: 500));
    _heroes.add(hero);
  }

  @override
  Future<List<HeroModel>> getHeroList() async {
    await Future.delayed(Duration(milliseconds: 300));
    return List.from(_heroes);
  }

  @override
  Future<List<HeroModel>> searchHero(String query) async {
    if (_heroes.isEmpty) {
      await fetchHeroFromApi(query);
    }
    return _heroes
        .where((hero) =>
            (hero.name?.toLowerCase() ?? '').contains(query.toLowerCase()))
        .toList();
  }
}