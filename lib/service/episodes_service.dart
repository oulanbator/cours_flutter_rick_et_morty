import 'package:cours_flutter_rick_et_morty/model/episode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EpisodesService {
  Future<List<Episode>> fetchEpisodes() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/episode'));

    // Si l'on a un HTTP 200, on parse la réponse de notre webservice
    if (response.statusCode == 200) {
      return parseEpisodes(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  List<Episode> parseEpisodes(String responseBody) {
    // Parse la réponse en tant que Map<String, dynamic>, à l'aide de jsonDecode()
    final Map<String, dynamic> data = jsonDecode(responseBody);

    // Récupère la clé 'results' de l'objet data, en tant que liste de dynamic (variable non typée)
    final List<dynamic> results = data['results'];

    // Effectue un mapping de chaque élément 'dynamic' de notre List
    // Map un 'Episode' grâce au constructeur .fromJson
    // Retourne une List<Episode> avec .toList();
    List<Episode> episodes =
        results.map((jsonElement) => Episode.fromJson(jsonElement)).toList();

    return episodes;
  }
}
