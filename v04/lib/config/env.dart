import 'package:dotenv/dotenv.dart' as dotenv;

class Env {
  static final dotenv.DotEnv _dotEnv = dotenv.DotEnv();

  static void load() {
    _dotEnv.load();
  }

  static String get superheroApiKey {
    return _dotEnv['SUPERHERO_API_KEY'] ?? '';
  }
}
