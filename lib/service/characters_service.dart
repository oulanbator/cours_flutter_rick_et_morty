import 'package:cours_flutter_rick_et_morty/model/character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharactersService {
  Future<List<Character>> fetchCharacters() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    // Si l'on a un HTTP 200, on parse la réponse de notre webservice
    if (response.statusCode == 200) {
      return parseCharacters(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  List<Character> parseCharacters(String responseBody) {
    // Parse la réponse en tant que Map<String, dynamic>, à l'aide de jsonDecode()
    final Map<String, dynamic> data = jsonDecode(responseBody);

    // Récupère la clé 'results' de l'objet data, en tant que liste de dynamic (variable non typée)
    final List<dynamic> results = data['results'];

    // Effectue un mapping de chaque élément 'dynamic' de notre List
    // Map un 'Character' grâce au constructeur .fromJson
    // Retourne une List<Character> avec .toList();
    List<Character> characters =
        results.map((jsonElement) => Character.fromJson(jsonElement)).toList();

    return characters;
  }
}
