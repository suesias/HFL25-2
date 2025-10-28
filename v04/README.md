# HeroDex 3000

Ett Dart-projekt för att hantera och visa superhjältar. Projektet använder JSON-data och en extern API-tjänst för att hämta och spara information om hjältar.

---

## 🧩 Projektstruktur

| Fil | Beskrivning |
|-----|--------------|
| **main.dart** | Huvudfilen som kör applikationen och använder logiken från övriga filer. |
| **logic.dart** | Innehåller kärnlogiken för att hantera användarinteraktioner och dataflöde. |
| **hero_model.dart** | Definierar modellen för en hjälte (Hero) inklusive attribut som namn, styrka, snabbhet, etc. |
| **hero_data_manager.dart** | Ansvarar för att läsa och skriva hjälteinformation till och från den lokala JSON-filen `heroes.json`. |
| **superhero_api_service.dart** | Hanterar kommunikation med SuperHero API:t och hämtar data om hjältar online. |
| **heroes.json** | En lokal databas med exempel på hjältar, inklusive egenskapspoäng och biografi. |
| **pubspec.yaml** | Innehåller projektets metadata och beroenden. |

---

## ⚙️ Installation

1. Se till att du har **Dart SDK 3.9.2 eller senare** installerad.  
2. Kör följande kommando i projektets rotmapp:

   ```bash
   dart pub get


Kör applikationen:
dart run

Beroenden
Projektet använder följande paket:
http – för API-anrop
dotenv – för miljövariabler
path – för filhantering