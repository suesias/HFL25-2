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

  print("Hjälten $name lades till!");
}


void showHero() {
    if (heroes.isEmpty) {
    print("\nInga hjältar tillagda än.");
    return;
  }

  // Sortera efter styrka (starkast först)
 heroes.sort((a, b) => (b["powerstats"]["strength"] as int).compareTo(a["powerstats"]["strength"] as int));

  print("\nLista över hjältar (starkast först):");

    heroes.forEach((h) {
        print("${h["name"]} | Styrka: ${h["powerstats"]["strength"]} | Kraft: ${h["specialpower"]}");   
    });
}

void searchHero() {
    stdout.write("\nSök efter hjälte (namn eller del av namn): ");
    final input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
        print("Du måste skriva något!");
        return;
    }

    final searchfor = input.trim().toLowerCase();

  // Filtrera listan
    final resultat = heroes.where((h) => (h["name"] as String).toLowerCase().contains(searchfor));

    if (resultat.isEmpty) {
        print("Ingen hjälte hittades på '$searchfor'.");
    } else {
        print("\nSökträffar på '$searchfor':");
        resultat.forEach((h) {
            print("${h["name"]} | Styrka: ${h["powerstats"]["strength"]} | Kraft: ${h["specialpower"]}");   
        });
    }
}