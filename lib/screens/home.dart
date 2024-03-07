import 'package:cours_flutter_rick_et_morty/screens/details_page.dart';
import 'package:cours_flutter_rick_et_morty/service/characters_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // référence à notre service
    var service = CharactersService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rick & Morty - Profiler"),
      ),
      // On wrap le ListView dans un FutureBuilder
      body: FutureBuilder(
        future: service.fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Si l'on récupère la data correctement, afficher un ListView
            var characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) =>
                  _listElement(context, characters[index]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // Par défaut, afficher un Spinner
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

Widget _listElement(context, character) {
  return ListTile(
    leading: Image.network(character.image),
    title: Text(character.name),
    subtitle: Text(character.species),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(character: character),
      ),
    ),
  );
}
