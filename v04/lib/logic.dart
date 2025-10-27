import 'package:v04/managers/hero_data_manager.dart';
import 'dart:io';

Future<void> addHero(HeroDataManager manager) async {
  stdout.write("Ange hjältens namn (t.ex. Batman): ");
  final name = stdin.readLineSync() ?? '';
  if (name.isNotEmpty) {
    final hero = await manager.fetchHeroFromApi(name);
    if (hero != null) {
      print('Hjält tillagd: ${hero.name}');
      if (hero.powerstats != null) {
        print('Intelligens: ${hero.powerstats!.intelligence}');
      }
      if (hero.biography != null) {
        print('Fullt namn: ${hero.biography!.fullName}');
      }
    } else {
      print('Kunde inte hitta hjälten "$name".');
    }
  } else {
    print('Inget namn angivet.');
  }
}

Future<void> showHeroes(HeroDataManager manager) async {
  final heroes = await manager.getHeroList();
  if (heroes.isEmpty) {
    print('Inga hjältar i listan.');
  } else {
    for (var hero in heroes) {
      print('Hjält: ${hero.name}, ID: ${hero.id}');
      if (hero.powerstats != null) {
        print('Intelligens: ${hero.powerstats!.intelligence}');
      }
    }
  }
}

Future<void> searchHero(HeroDataManager manager) async {
  stdout.write("Ange sökterm: ");
  final query = stdin.readLineSync() ?? '';
  final results = await manager.searchHero(query);
  if (results.isEmpty) {
    print('Inga hjältar hittades för "$query".');
  } else {
    for (var hero in results) {
      print('Hittad: ${hero.name}, ID: ${hero.id}');
      if (hero.powerstats != null) {
        print('Intelligens: ${hero.powerstats!.intelligence}');
      }
    }
  }
}