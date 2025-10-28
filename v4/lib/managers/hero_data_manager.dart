import 'package:v4/models/hero_model.dart'; // Importera modellen
import 'dart:async'; // För Future
import 'dart:io'; // För File
import 'dart:convert'; // För json

abstract class HeroDataManaging {
  Future<void> saveHero(HeroModel hero); // Spara en hjälte
  Future<List<HeroModel>> getHeroList(); // Hämta sorterad lista
  Future<List<HeroModel>> searchHero(String query); // Sök efter namn
}


class HeroDataManager implements HeroDataManaging {
  static HeroDataManager? _instance; // Privat singleton-instans

  factory HeroDataManager() {
    _instance ??= HeroDataManager._(); // Skapa om inte finns
    return _instance!;
  }

  HeroDataManager._(); // Privat konstruktor (kan inte skapa utanför)

  List<HeroModel> _heroes = []; // Privat lista

  Future<void> init() async {
  // print('Försöker ladda heroes.json...'); // Felsökning
  final file = File('heroes.json');
  if (await file.exists()) {
    print('Fil hittad! Läser innehåll...');
    try {
      final jsonStr = await file.readAsString();
      //print('JSON-innehåll: $jsonStr'); // Visa rå JSON
      final List<dynamic> jsonList = json.decode(jsonStr);
      //print('Parsad JSON-lista: $jsonList'); // Visa parsad lista
      _heroes = jsonList.map((json) => HeroModel.fromJson(json)).toList();
      //print('Laddade ${_heroes.length} hjältar.');
    } catch (e) {
      print('Fel vid laddning: $e'); // Visa exakt fel
    }
  } else {
    //print('heroes.json hittades inte, startar med tom lista.');
    _heroes = [];
  }
}

  @override
  Future<void> saveHero(HeroModel hero) async {
    _heroes.add(hero);
    await _saveToFile(); // Spara async
  }

  Future<void> _saveToFile() async {
    final file = File('heroes.json');
    final jsonList = _heroes.map((hero) => hero.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  @override
  Future<List<HeroModel>> getHeroList() async {
    // Sortera efter styrka (starkast först), som i ditt gamla
    final sorted = List<HeroModel>.from(_heroes);
    sorted.sort((a, b) {
      int strengthA = int.tryParse(a.powerstats?.strength ?? '0') ?? 0;
      int strengthB = int.tryParse(b.powerstats?.strength ?? '0') ?? 0;
      return strengthB.compareTo(strengthA);
    });
    return sorted;
  }

  @override
  Future<List<HeroModel>> searchHero(String query) async {
    final lowerQuery = query.toLowerCase();
    return _heroes.where((hero) => (hero.name ?? '').toLowerCase().contains(lowerQuery)).toList();
  }
}