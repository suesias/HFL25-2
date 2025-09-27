# Enkel Miniräknare i Dart

Enkelt program som körs i CLI. 
Programmet frågar först efter ett tal, sedan vilken operation (+, -, *, /) som ska utföras, och till sist efter ett till tal.  
Resultatet skrivs sedan ut i terminalen.

## Hur man kör programmet

Öppna en terminal i projektets rotmapp och kör följande kommando:
dart run bin/main.dart



### Hur man gör en funktion i dart

int readInt(String prompt) { //funktionens namn readInt, fånga upp string i promt
  while (true) {
    print(prompt); // Skriv ut promt som skickades med när funktionen kallades
    String? input = stdin.readLineSync();

    try {
      return int.parse(input!); // Skicka tillbaka värde 
    } catch (e) {
      print('Du måste skriva ett heltal. Försök igen.');
    }
  }
}

  int num1 = readInt('Skriv första talet:'); // Kör funktionen och värdet som returneras läggs i num1