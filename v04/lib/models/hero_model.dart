/* POWERSTATS */
/* POWERSTATS */
/* POWERSTATS */
class Powerstats {
  String? intelligence;
  String? strength;
  String? speed;
  String? durability;
  String? power;
  String? combat;

  Powerstats({
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  });

  // Konstruktor från JSON (från Map)
  Powerstats.fromJson(Map<String, dynamic> json) {
    intelligence = json['intelligence'];
    strength = json['strength'];
    speed = json['speed'];
    durability = json['durability'];
    power = json['power'];
    combat = json['combat'];
  }


/* MINESANTECKNING
Map<String, dynamic>: Betyder att nycklarna är strängar (String), och värdena kan vara vad som helst (dynamic). I Dart kan värden vara strängar, nummer, listor, eller till och med andra Map:ar.
Hämta värde: Använd nyckeln, t.ex. hero["name"] returnerar "Batman".
Uppdatera: Sätt ett nytt värde, t.ex. hero["name"] = "Superman";.

Map: Bra för rådata från API:er eller snabb prototyping. Men det är lätt att göra fel (t.ex. stava fel nyckel: hero['nmae'] kraschar inte men ger null).
Klass (HeroModel): Ger struktur, typesäkerhet, och IDE-stöd (t.ex. autocomplete). Om du skriver hero.name istället för hero['name'], fångar Dart fel vid kompilering.
*/

  // Till JSON (för sparande)
  Map<String, dynamic> toJson() {
    return {
      'intelligence': intelligence,
      'strength': strength,
      'speed': speed,
      'durability': durability,
      'power': power,
      'combat': combat,
    };
  }
}


/* BIOGRAFPHY */
/* BIOGRAFPHY */
/* BIOGRAFPHY */
class Biography {
  String? fullName;
  String? alterEgos;
  List<String>? aliases;
  String? placeOfBirth;
  String? firstAppearance;
  String? publisher;
  String? alignment;

  Biography({
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  });

  Biography.fromJson(Map<String, dynamic> json) {
    fullName = json['full-name'];
    alterEgos = json['alter-egos'];
    aliases = (json['aliases'] as List?)?.cast<String>(); // Cast till List<String>
    placeOfBirth = json['place-of-birth'];
    firstAppearance = json['first-appearance'];
    publisher = json['publisher'];
    alignment = json['alignment'];
  }

  Map<String, dynamic> toJson() {
    return {
      'full-name': fullName,
      'alter-egos': alterEgos,
      'aliases': aliases,
      'place-of-birth': placeOfBirth,
      'first-appearance': firstAppearance,
      'publisher': publisher,
      'alignment': alignment,
    };
  }
}


/* APPARENCE */
/* APPARENCE */
/* APPARENCE */
class Appearance {
  String? gender;
  String? race;
  List<String>? height;
  List<String>? weight;
  String? eyeColor;
  String? hairColor;

  Appearance({
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  });

  Appearance.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    race = json['race'];
    height = (json['height'] as List?)?.cast<String>();
    weight = (json['weight'] as List?)?.cast<String>();
    eyeColor = json['eye-color'];
    hairColor = json['hair-color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'race': race,
      'height': height,
      'weight': weight,
      'eye-color': eyeColor,
      'hair-color': hairColor,
    };
  }
}



/* WORK */
/* WORK */
/* WORK */
class Work {
  String? occupation;
  String? base;

  Work({
    this.occupation,
    this.base,
  });

  Work.fromJson(Map<String, dynamic> json) {
    occupation = json['occupation'];
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    return {
      'occupation': occupation,
      'base': base,
    };
  }
}


/* CONNECTIN */
/* CONNECTIN */
/* CONNECTIN */
class Connections {
  String? groupAffiliation;
  String? relatives;

  Connections({
    this.groupAffiliation,
    this.relatives,
  });

  Connections.fromJson(Map<String, dynamic> json) {
    groupAffiliation = json['group-affiliation'];
    relatives = json['relatives'];
  }

  Map<String, dynamic> toJson() {
    return {
      'group-affiliation': groupAffiliation,
      'relatives': relatives,
    };
  }
}

/* IMAGE */
/* IMAGE */
/* IMAGE */
class HeroImage { // Kallar den HeroImage för att undvika konflikt med 'image'
  String? url;

  HeroImage({
    this.url,
  });

  HeroImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}

/* HERO MODEL */
/* HERO MODEL */
/* HERO MODEL */

// lib/models/hero_model.dart (endast HeroModel-delen)
class HeroModel {
  String? response;
  String id; // Obligatorisk
  String name; // Obligatorisk
  Powerstats? powerstats;
  Biography? biography;
  Appearance? appearance;
  Work? work;
  Connections? connections;
  HeroImage? image;

  HeroModel({
    this.response,
    required this.id,
    required this.name,
    this.powerstats,
    this.biography,
    this.appearance,
    this.work,
    this.connections,
    this.image,
  });

  HeroModel.fromJson(Map<String, dynamic> json)
      : response = json['response'],
        id = json['id'] ?? '',
        name = json['name'] ?? '',
        powerstats = json['powerstats'] != null ? Powerstats.fromJson(json['powerstats']) : null,
        biography = json['biography'] != null ? Biography.fromJson(json['biography']) : null,
        appearance = json['appearance'] != null ? Appearance.fromJson(json['appearance']) : null,
        work = json['work'] != null ? Work.fromJson(json['work']) : null,
        connections = json['connections'] != null ? Connections.fromJson(json['connections']) : null,
        image = json['image'] != null ? HeroImage.fromJson(json['image']) : null;

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'id': id,
      'name': name,
      'powerstats': powerstats?.toJson(),
      'biography': biography?.toJson(),
      'appearance': appearance?.toJson(),
      'work': work?.toJson(),
      'connections': connections?.toJson(),
      'image': image?.toJson(),
    };
  }
}



