import 'package:v04/config/env.dart';

void main() {
  Env.load();
  print('API-nyckel: ${Env.superheroApiKey}');
  if (Env.superheroApiKey.isEmpty) {
    print('Fel: Ingen nyckel hittades. Kontrollera .env-filen.');
  }
}