// lib/test_manager.dart
import 'package:v04/managers/hero_data_manager.dart';

void main() async {
  final manager = HeroDataManager();
  final hero = await manager.fetchHeroFromApi('batman');
  if (hero != null) {
    print('Hittad: ${hero.name}');
    print('ID: ${hero.id}');
    if (hero.powerstats != null) {
      print('Intelligens: ${hero.powerstats!.intelligence}');
    }
    if (hero.biography != null) {
      print('Fullt namn: ${hero.biography!.fullName}');
    }
  } else {
    print('Kunde inte hämta Batman');
  }
}