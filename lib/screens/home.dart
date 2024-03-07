import 'package:cours_flutter_rick_et_morty/screens/details_page.dart';
import 'package:cours_flutter_rick_et_morty/service/characters_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Les profils "en dur" sont stockés dans cette variable
    var profiles = CharactersService().profiles;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rick & Morty - Profiler"),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) => _listElement(context, profiles[index]),
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
