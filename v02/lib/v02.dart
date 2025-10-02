import 'dart:io';

List<Map<String, dynamic>> heroes = [];

void addHero() {
  String name;
  while (true) {
    stdout.write("\nHjältens namn: ");
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      name = input.trim();
      break;
    }
    print("\nOgiltigt namn, försök igen!");
  }

  int styrka;
  while (true) {
    stdout.write("\nHjältens styrka (heltal): ");
    final input = stdin.readLineSync();
    final value = int.tryParse(input ?? "");
    if (value != null) {
      styrka = value;
      break;
    }
    print("\nOgiltig styrka, skriv ett heltal!");
  }

  String kraft;
  while (true) {
    stdout.write("\nHjältens specialkraft: ");
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      kraft = input.trim();
      break;
    }
    print("\nSpecialkraft får inte vara tom!");
  }

heroes.add({
  "name": name,
  "powerstats": {
    "strength": styrka,
  },
  "specialpower": kraft,
});

  print("Hjälten $name lades till!\n");
}


void showHero() {}

void searchHero() {}